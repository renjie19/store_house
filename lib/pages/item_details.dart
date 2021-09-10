import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  static final String name = '/ITEM_CHECK';
  final itemInfo = Get.arguments ?? {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Item Details'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
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
                            fontWeight: FontWeight.bold,
                            fontSize: 26
                          ),
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
      ),
    );
  }
}
