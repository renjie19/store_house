import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:store_house/controller/main_app_controller.dart';
import 'package:store_house/pages/item_details.dart';
import 'package:store_house/pages/item_management.dart';
import 'package:store_house/pages/profile.dart';
import 'package:store_house/util/loading_util.dart';
import 'package:store_house/util/notification_util.dart';

class Home extends StatelessWidget {
  static final String name = 'HOME';
  final fontStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  final MainAppController _mainAppController = Get.find();

  Future<void> _startScan(BuildContext context) async {
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode(
          '#FF247BA0'.toString(), 'Cancel', true, ScanMode.BARCODE);
      if (barcode != '-1') {
        LoadingUtil.show(context);
        final result = await _mainAppController.findItemByBarcode(barcode);
        Get.toNamed(ItemDetails.name, arguments: {'item': result});
      }
    } catch (e) {
      showErrorMessage(e);
    } finally {
      LoadingUtil.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'STORE HOUSE',
          ),
          actions: [
            GestureDetector(
              onTap: () => Get.toNamed(Profile.name),
              child: Center(
                child: _mainAppController.getCurrentUser()?.photoURL == null
                    ? Container(
                        margin: EdgeInsets.all(16),
                        child: Icon(Typicons.user_outline, color: Colors.white),
                      )
                    : Lottie.asset(
                        'assets/${_mainAppController.getCurrentUser()?.photoURL}.json',
                        height: 50,
                        width: 50,
                        fit: BoxFit.fill,
                      ),
              ),
            )
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Lottie.asset(
                    'assets/online-shopping.json',
                    height: 300,
                    width: 300,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 60),
                Expanded(
                  flex: 3,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MaterialButton(
                          padding: EdgeInsets.all(16),
                          onPressed: () => _startScan(context),
                          child: Text('SCAN ITEM', style: fontStyle),
                          color: Theme.of(context).primaryColor,
                          elevation: 0,
                        ),
                        SizedBox(height: 16),
                        MaterialButton(
                          padding: EdgeInsets.all(16),
                          onPressed: () => Get.toNamed(ItemManagement.name),
                          child: Text('MANAGE ITEMS', style: fontStyle),
                          color: Theme.of(context).primaryColor,
                          elevation: 0,
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
