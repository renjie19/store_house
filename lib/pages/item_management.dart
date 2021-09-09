import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';

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
              onPressed: () {},
              icon: Icon(Typicons.plus_outline, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
