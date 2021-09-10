import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_house/config/project_build.dart';
import 'package:store_house/controller/main_app_controller.dart';
import 'package:store_house/service/auth_service.dart';

class Profile extends StatelessWidget {
  static final String name = '/PROFILE';
  final AuthService _authService = Get.find();
  final MainAppController _mainAppController = Get.find();

  final buttonTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.all(24),
              child: Card(
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        _authService.currentUser?.displayName ?? '',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontFamily: GoogleFonts.anton().fontFamily,
                          fontSize: 38,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _authService.currentUser?.email ?? '',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('Contact Us', style: buttonTextStyle),
                  ),
                  Text('Version: ${ProjectBuild.appVersion}.${ProjectBuild.buildVersion}', style: buttonTextStyle),
                  TextButton(
                    onPressed: () => _mainAppController.logOut(),
                    child: Text('Terms and Conditions', style: buttonTextStyle),
                  ),
                  TextButton(
                    onPressed: () => {},
                    child: Text('Privacy Policy', style: buttonTextStyle),
                  ),
                  TextButton(
                    onPressed: () => _mainAppController.logOut(),
                    child: Text('LOG OUT', style: buttonTextStyle.copyWith(color: Theme.of(context).errorColor)),
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
