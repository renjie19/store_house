import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_house/controller/main_app_controller.dart';
import 'package:store_house/pages/item_details.dart';
import 'package:store_house/pages/item_management.dart';
import 'package:store_house/pages/profile.dart';
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
        Loader.show(context);
        final result = await _mainAppController.findItemByBarcode(barcode);
        Get.toNamed(ItemDetails.name, arguments: {'item': result});
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
        appBar: AppBar(
          title: Text(
            'STORE HOUSE',
            style: TextStyle(
              color: Colors.white,
              fontFamily: GoogleFonts.nunito().fontFamily,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(Profile.name),
              icon: Icon(Typicons.user_outline, color: Colors.white),
            )
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
