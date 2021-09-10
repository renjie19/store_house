import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';
import 'package:store_house/controller/item_management_controller.dart';
import 'package:store_house/pages/create_item.dart';
import 'package:store_house/util/notification_util.dart';

class ItemManagement extends StatelessWidget {
  static final String name = '/ITEM_MANAGEMENT';
  final ItemManagementController _itemManagementController = Get.find();
  final _formKey = GlobalKey<FormBuilderState>();

  final subTitleStyle = TextStyle(fontWeight: FontWeight.bold);

  Future<void> _loadItems(BuildContext context) async {
    try {
      Loader.show(context);
      await _itemManagementController.getItems();
    } catch (e) {
      showErrorMessage(e);
    } finally {
      Loader.hide();
    }
  }

  Future<void> _searchItemByName(BuildContext context) async {
    try {
      Loader.show(context);
      if (_formKey.currentState!.saveAndValidate()) {
        await _itemManagementController
            .findItemsByName(_formKey.currentState!.value['itemName']);
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
            onPressed: () => Get.toNamed(CreateItem.name),
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
                    visible: _itemManagementController.isSearching,
                    child: FormBuilder(
                      key: _formKey,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: FormBuilderTextField(
                                name: 'itemName',
                                decoration:
                                    InputDecoration(labelText: 'Item Name'),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                ]),
                              ),
                            ),
                            IconButton(
                              onPressed: () => _searchItemByName(context),
                              icon: Icon(
                                Typicons.search_outline,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ]),
                    ),
                  );
                }),
                Expanded(
                  child: Obx(() {
                    return ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: _itemManagementController.items.length,
                        itemBuilder: (context, index) {
                          final item = _itemManagementController.items[index];
                          return ListTile(
                            title: Text(
                              item['itemName'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            subtitle: Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(children: [
                                      Text('Capital: '),
                                      SizedBox(width: 32),
                                      Text(
                                        item['capital'],
                                        style: subTitleStyle,
                                      ),
                                    ]),
                                    Row(children: [
                                      Text('Wholesale: '),
                                      SizedBox(width: 9),
                                      Text(
                                        item['wholesale'],
                                        style: subTitleStyle,
                                      ),
                                    ]),
                                    Row(children: [
                                      Text('Retail: '),
                                      SizedBox(width: 40),
                                      Text(
                                        item['retail'],
                                        style: subTitleStyle,
                                      ),
                                    ]),
                                  ]),
                            ),
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
