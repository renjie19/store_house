import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';
import 'package:store_house/pages/create_item.dart';

class ItemManagement extends StatelessWidget {
  static final String name = '/ITEM_MANAGEMENT';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Manage Items'),
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(CreateItem.name),
              icon: Icon(Typicons.plus_outline, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
