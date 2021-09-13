import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:store_house/config/project_build.dart';
import 'package:store_house/controller/main_app_controller.dart';
import 'package:store_house/pages/edit_profile.dart';
import 'package:store_house/service/auth_service.dart';
import 'package:store_house/util/notification_util.dart';

class Profile extends StatelessWidget {
  static final String name = '/PROFILE';
  final MainAppController _mainAppController = Get.find();

  final buttonTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black);

  void _logOut() {
    _mainAppController.logOut();
    Get.back();
  }

  void _toEditProfile() {
    try {
      Get.toNamed(EditProfile.name);
    } catch (e) {
      showErrorMessage(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => _toEditProfile(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Lottie.asset(
                        _mainAppController.getCurrentUser()!.photoURL!.isEmpty
                            ? 'assets/salad-cat.json'
                            : 'assets/${_mainAppController.getCurrentUser()?.photoURL}.json',
                        width: 300,
                        height: 300,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      _mainAppController.getCurrentUser()?.displayName ?? '',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: GoogleFonts.anton().fontFamily,
                        fontSize: 38,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _mainAppController.getCurrentUser()?.email ?? '',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ]),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('Contact Us', style: buttonTextStyle),
                  ),
                  Text(
                      'Version: ${ProjectBuild.appVersion}.${ProjectBuild.buildVersion}',
                      style: buttonTextStyle),
                  TextButton(
                    onPressed: () => _mainAppController.logOut(),
                    child: Text('Terms and Conditions', style: buttonTextStyle),
                  ),
                  TextButton(
                    onPressed: () => {},
                    child: Text('Privacy Policy', style: buttonTextStyle),
                  ),
                  TextButton(
                    onPressed: () => _logOut(),
                    child: Text('LOG OUT',
                        style: buttonTextStyle.copyWith(
                            color: Theme.of(context).errorColor)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
