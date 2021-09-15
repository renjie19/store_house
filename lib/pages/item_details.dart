import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:store_house/controller/item_details_controller.dart';
import 'package:store_house/pages/edit_item.dart';
import 'package:store_house/util/date_util.dart';
import 'package:store_house/util/notification_util.dart';
import 'package:store_house/util/string_formatter.dart';

class ItemDetails extends StatefulWidget {
  static final String name = '/ITEM_CHECK';

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  final bool _isEdit = Get.arguments['isEdit'] ?? false;
  final ItemDetailsController _itemDetailsController = Get.find();
  Map<String, dynamic> _itemInfo = Get.arguments['item'] ?? {};
  String _action = '';

  final _trailTextStyle = TextStyle(fontSize: 16);

  final _buttonStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  void _updateItem() {
    try {
      Get.toNamed(EditItem.name, arguments: _itemInfo)?.then((value) {
        if (value != null) {
          setState(() {
            _itemInfo = value;
            _action = 'update';
          });
        }
      });
    } catch (e) {
      showErrorMessage(e);
    }
  }

  Future<void> _deleteItem(documentId) async {
    try {
      _itemDetailsController.deleteItem(documentId).then((value) {
        setState(() => _action = 'delete');
        Get.back(result: _action);
      });
    } catch (e) {
      showErrorMessage(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: _action);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Item Details'),
          ),
          body: Container(
            margin: EdgeInsets.all(16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Created By: ', style: _trailTextStyle),
                            Text('${_itemInfo['createdBy'] ?? ''}',
                                style: _trailTextStyle),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Modified By: ', style: _trailTextStyle),
                            Text('${_itemInfo['modifiedBy'] ?? ''}',
                                style: _trailTextStyle),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Date Created: ', style: _trailTextStyle),
                            Text(
                              formatDate(DateTime.fromMillisecondsSinceEpoch(
                                  _itemInfo['dateCreated'])),
                              style: _trailTextStyle,
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Date Modified: ', style: _trailTextStyle),
                            Text(
                              formatDate(DateTime.fromMillisecondsSinceEpoch(
                                  _itemInfo['dateModified'])),
                              style: _trailTextStyle,
                            ),
                          ]),
                      Divider(height: 24),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Item Name: ', style: TextStyle(fontSize: 22),),
                            Expanded(
                              child: Text(
                                '${_itemInfo['itemName'] ?? ''}',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                ),
                              ),
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Barcode: ', style: TextStyle(fontSize: 22)),
                            Text(
                              '${_itemInfo['barcodeId'] ?? ''}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 26),
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Capital: ', style: TextStyle(fontSize: 22)),
                            Text(
                              '${toCommaSeparatedNumber(_itemInfo['capital']) ?? '0.00'}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Wholesale: ', style: TextStyle(fontSize: 22)),
                            Text(
                              '${toCommaSeparatedNumber(_itemInfo['wholesale']) ?? '0.00'}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Retail: ', style: TextStyle(fontSize: 22)),
                            Text(
                              '${toCommaSeparatedNumber(_itemInfo['retail']) ?? '0.00'}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            ),
                          ]),
                    ],
                  ),
                  Visibility(
                    visible: _isEdit,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: MaterialButton(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              elevation: 0,
                              color: Theme.of(context).errorColor,
                              onPressed: () =>
                                  _deleteItem(_itemInfo['documentId']),
                              child: Text(
                                'DELETE',
                                style: _buttonStyle.copyWith(
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: MaterialButton(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              elevation: 0,
                              color: Theme.of(context).primaryColor,
                              onPressed: () => _updateItem(),
                              child: Text(
                                'UPDATE',
                                style: _buttonStyle.copyWith(
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
