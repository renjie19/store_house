import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showErrorMessage(final dynamic error, {final SnackPosition snackPosition = SnackPosition.TOP}) {
  Get.snackbar('Error', error.toString(),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      snackPosition: snackPosition,
      margin: EdgeInsets.all(12.0));
}

showSuccessMessage(final String message) {
  Get.snackbar('Success', message.toString(),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.green,
      colorText: Colors.white);
}
