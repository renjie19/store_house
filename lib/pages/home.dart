import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';
import 'package:store_house/controller/main_app_controller.dart';

class Home extends StatelessWidget {
  static final String name = 'HOME';
  final fontStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  final MainAppController _mainAppController = Get.find();

  void _logout() {
    _mainAppController.logOut();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'STORE HOUSE',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () => _logout(),
              icon: Icon(Typicons.forward_outline, color: Colors.white),
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
                  onPressed: () {},
                  child: Text('SCAN ITEM', style: fontStyle),
                  color: Theme.of(context).accentColor,
                  elevation: 0,
                ),
                SizedBox(height: 16),
                MaterialButton(
                  padding: EdgeInsets.all(16),
                  onPressed: () {},
                  child: Text('MANAGE ITEMS', style: fontStyle),
                  color: Theme.of(context).accentColor,
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
