import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_house/config/get_config.dart';
import 'package:store_house/config/routes.dart';
import 'package:store_house/controller/main_app_controller.dart';
import 'package:store_house/pages/loading.dart';
import 'package:store_house/pages/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initGetDependencies();
  runApp(StoreHouseApp());
}

class StoreHouseApp extends StatelessWidget {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return _getMaterialApp();
  }

  GetMaterialApp _getMaterialApp() {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.nunitoTextTheme(),
        primaryColor: Color(0xFF247BA0),
        accentColor: Color(0xFFE3BE78),
      ),
      initialBinding: MainAppBinding(),
      getPages: routes,
      // home: FutureBuilder(
      //   // Initialize FlutterFire:
      //   future: _initialization,
      //   builder: (context, snapshot) {
      //     // Check for errors
      //     if (snapshot.hasError) {
      //       // return SomethingWentWrong();
      //     }
      //
      //     // Once complete, show your application
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       return MainApp();
      //     }
      //
      //     // Otherwise, show something whilst waiting for initialization to complete
      //     return Loading();
      //   },
      // ),
      home: MainApp()
    );
  }
}
