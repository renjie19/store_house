import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_house/config/get_config.dart';
import 'package:store_house/config/project_build.dart';
import 'package:store_house/config/routes.dart';
import 'package:store_house/controller/main_app_controller.dart';
import 'package:store_house/pages/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ProjectBuild.init();
  initGetDependencies();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
        debugShowCheckedModeBanner: !kReleaseMode,
        title: 'STORE HOUSE',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.nunitoTextTheme(),
          primaryTextTheme: GoogleFonts.antonTextTheme().copyWith(
            headline6: TextStyle(
              color: Colors.white,
              fontFamily: GoogleFonts.anton().fontFamily,
            ),
          ),
          primaryColor: Color(0xFF247BA0),
          accentColor: Color(0xFFF6FFF8),
        ),
        initialBinding: MainAppBinding(),
        getPages: routes,
        home: MainApp());
  }
}
