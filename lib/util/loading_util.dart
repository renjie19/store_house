import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:lottie/lottie.dart';

class LoadingUtil {
  static void show(BuildContext context) {
    Loader.show(context,progressIndicator: Center(
      child: Lottie.asset(
        'assets/loading.json',
        width: 250,
        height: 250,
        fit: BoxFit.fill,
      ),
    ));
  }

  static void hide() {
    Loader.hide();
  }
}