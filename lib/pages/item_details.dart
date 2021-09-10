import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:store_house/controller/item_details_controller.dart';
import 'package:store_house/util/date_util.dart';
import 'package:store_house/util/notification_util.dart';

class ItemDetails extends StatelessWidget {
  static final String name = '/ITEM_CHECK';
  final itemInfo = Get.arguments['item'] ?? {};
  final bool isEdit = Get.arguments['isEdit'] ?? false;
  final ItemDetailsController _itemDetailsController = Get.find();

  final trailTextStyle = TextStyle(fontSize: 16);
  final buttonStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  Future<void> _deleteItem(documentId) async {
    try {
      await _itemDetailsController.deleteItem(documentId);
      Get.back(result: 'delete');
    } catch (e) {
      showErrorMessage(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                          Text('Created By: ', style: trailTextStyle),
                          Text('${itemInfo['createdBy'] ?? ''}',
                              style: trailTextStyle),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Modified By: ', style: trailTextStyle),
                          Text('${itemInfo['modifiedBy'] ?? ''}',
                              style: trailTextStyle),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Date Created: ', style: trailTextStyle),
                          Text(
                            formatDate(DateTime.fromMillisecondsSinceEpoch(
                                itemInfo['dateCreated'])),
                            style: trailTextStyle,
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Date Modified: ', style: trailTextStyle),
                          Text(
                            formatDate(DateTime.fromMillisecondsSinceEpoch(
                                itemInfo['dateModified'])),
                            style: trailTextStyle,
                          ),
                        ]),
                    Divider(height: 24),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Item Name: ', style: TextStyle(fontSize: 22)),
                          Text(
                            '${itemInfo['itemName'] ?? ''}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Barcode: ', style: TextStyle(fontSize: 22)),
                          Text(
                            '${itemInfo['barcodeId'] ?? ''}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 26),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Capital: ', style: TextStyle(fontSize: 22)),
                          Text(
                            '${itemInfo['capital'] ?? '0.00'}',
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
                            '${itemInfo['wholesale'] ?? '0.00'}',
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
                            '${itemInfo['retail'] ?? '0.00'}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                          ),
                        ]),
                  ],
                ),
                Visibility(
                  visible: isEdit,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: MaterialButton(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            elevation: 0,
                            color: Theme.of(context).errorColor,
                            onPressed: () =>
                                _deleteItem(itemInfo['documentId']),
                            child: Text(
                              'DELETE',
                              style: buttonStyle.copyWith(
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
                            onPressed: () {},
                            child: Text(
                              'UPDATE',
                              style: buttonStyle.copyWith(
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                        ),
                      ]),
                ),
              ]),
        ),
      ),
    );
  }
}
