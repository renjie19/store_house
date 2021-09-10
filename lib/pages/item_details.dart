import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:store_house/util/date_util.dart';

class ItemDetails extends StatelessWidget {
  static final String name = '/ITEM_CHECK';
  final itemInfo = Get.arguments ?? {};

  final trailTextStyle = TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    print(itemInfo);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Item Details'),
        ),
        body: Container(
          margin: EdgeInsets.all(24),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
              ]),
        ),
      ),
    );
  }
}
