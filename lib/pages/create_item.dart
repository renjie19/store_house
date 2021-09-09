import 'package:flutter/material.dart';

class CreateItem extends StatelessWidget {
  static final String name = '/CREATE_ITEM';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Item'),
        ),
      ),
    );
  }
}
