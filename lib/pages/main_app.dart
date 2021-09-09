import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store_house/pages/home.dart';
import 'package:store_house/pages/login.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: null,
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> user) {
          if(user.data == null) {
            return Login();
          } else {
            return Home();
          }
          // return Home();
        });
  }
}
