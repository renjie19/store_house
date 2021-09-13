import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';
import 'package:store_house/controller/item_management_controller.dart';
import 'package:store_house/pages/create_item.dart';
import 'package:store_house/util/notification_util.dart';
import 'package:store_house/util/string_formatter.dart';

import 'item_details.dart';

class ItemManagement extends StatelessWidget {
  static final String name = '/ITEM_MANAGEMENT';
  final ItemManagementController _itemManagementController = Get.find();
  final _formKey = GlobalKey<FormBuilderState>();

  final subTitleStyle = TextStyle(fontWeight: FontWeight.bold);

  Future<void> _loadItems(BuildContext context) async {
    try {
      _itemManagementController.isLoading = true;
      await _itemManagementController.getItems();
    } catch (e) {
      showErrorMessage(e);
    } finally {
      Future.delayed(Duration(seconds: 2),
          () => _itemManagementController.isLoading = false);
    }
  }

  Future<void> _toCreateItem(BuildContext context) async {
    try {
      Get.toNamed(CreateItem.name)
          ?.then((value) async => await _loadItems(context));
    } catch (e) {
      showErrorMessage(e);
    }
  }

  Future<void> _startScan(BuildContext context) async {
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode(
          '#FF247BA0'.toString(), 'Cancel', true, ScanMode.BARCODE);
      if (barcode != '-1') {
        Loader.show(context);
        final result =
            await _itemManagementController.findItemByBarcode(barcode);
        Get.toNamed(ItemDetails.name,
                arguments: {'item': result, 'isEdit': true})
            ?.then((value) async => await _loadItems(context));
      }
    } catch (e) {
      showErrorMessage(e);
    } finally {
      Loader.hide();
    }
  }

  void _toEditItemPage(context, item) {
    try {
      Get.toNamed(ItemDetails.name, arguments: {'item': item, 'isEdit': true})
          ?.then((value) async => await _loadItems(context));
    } catch (e) {
      showErrorMessage(e);
    }
  }

  Future<void> _searchItemByName(BuildContext context) async {
    try {
      Loader.show(context);
      if (_formKey.currentState!.saveAndValidate()) {
        await _itemManagementController
            .findItemsByName(_formKey.currentState!.value['itemName']);
        FocusScope.of(context).unfocus();
      }
    } catch (e) {
      showErrorMessage(e);
    } finally {
      Loader.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Manage Items'), actions: [
          IconButton(
            tooltip: 'Search',
            onPressed: () => _itemManagementController.isSearching =
                !_itemManagementController.isSearching,
            icon: Icon(Typicons.search_outline, color: Colors.white),
          ),
          IconButton(
            tooltip: 'Get all items',
            onPressed: () => _loadItems(context),
            icon: Icon(Typicons.download_outline, color: Colors.white),
          ),
          IconButton(
            tooltip: 'Create',
            onPressed: () => _toCreateItem(context),
            icon: Icon(Typicons.plus_outline, color: Colors.white),
          ),
        ]),
        body: Container(
          padding: EdgeInsets.all(8),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Obx(() {
                  return Visibility(
                    visible: _itemManagementController.isLoading,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Loading Items',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(width: 5),
                          SizedBox(
                            child: CircularProgressIndicator(strokeWidth: 3),
                            height: 15,
                            width: 15,
                          )
                        ]),
                  );
                }),
                Obx(() {
                  return Visibility(
                    visible: _itemManagementController.isSearching,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: FormBuilder(
                        key: _formKey,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 7,
                                child: FormBuilderTextField(
                                  name: 'itemName',
                                  decoration:
                                      InputDecoration(labelText: 'Item Name'),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.done,
                                  valueTransformer: toSnakeCase,
                                  onSubmitted: (value) =>
                                      _searchItemByName(context),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                  ]),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () => _searchItemByName(context),
                                  icon: Icon(
                                    Typicons.search_outline,
                                    color: Theme.of(context).primaryColor,
                                    size: 32,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  tooltip: 'Scan Barcode',
                                  onPressed: () => _startScan(context),
                                  icon: Icon(
                                    Elusive.barcode,
                                    color: Theme.of(context).primaryColor,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  );
                }),
                Obx(() {
                  return Visibility(
                    visible: _itemManagementController.items.length > 0,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: Text(
                        'Records found: ${_itemManagementController.items.length}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }),
                Expanded(
                  child: Obx(() {
                    return _itemManagementController.items.length == 0
                        ? Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Typicons.thumbs_down,
                                    size: 80,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  Text(
                                    'No Records Found. You can create items by clicking the plus icon.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ]),
                          )
                        : ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: _itemManagementController.items.length,
                            itemBuilder: (context, index) {
                              final item =
                                  _itemManagementController.items[index];
                              return ListTile(
                                onTap: () => _toEditItemPage(context, item),
                                title: Text(
                                  item['itemName'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                // subtitle: Container(
                                //   margin: EdgeInsets.only(left: 8),
                                //   child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.stretch,
                                //       children: [
                                //         Row(children: [
                                //           Text('Capital: '),
                                //           SizedBox(width: 32),
                                //           Text(
                                //             item['capital'],
                                //             style: subTitleStyle,
                                //           ),
                                //         ]),
                                //         Row(children: [
                                //           Text('Wholesale: '),
                                //           SizedBox(width: 9),
                                //           Text(
                                //             item['wholesale'],
                                //             style: subTitleStyle,
                                //           ),
                                //         ]),
                                //         Row(children: [
                                //           Text('Retail: '),
                                //           SizedBox(width: 40),
                                //           Text(
                                //             item['retail'],
                                //             style: subTitleStyle,
                                //           ),
                                //         ]),
                                //       ]),
                                // ),
                              );
                            });
                  }),
                )
              ]),
        ),
      ),
    );
  }
}
