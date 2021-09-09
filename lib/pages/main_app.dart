import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_house/pages/home.dart';
import 'package:store_house/pages/login.dart';
import 'package:store_house/service/user_service.dart';

class MainApp extends StatelessWidget {
  final UserService _userService = Get.find();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: null,
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> user) {
          print('state changed');
          print(user.data);
          _userService.user = user.data;
          if(user.data == null) {
            return Login();
          } else {
            return Home();
          }
          // return Home();
        });
  }
}
