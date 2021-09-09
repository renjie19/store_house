import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:store_house/service/auth_service.dart';
import 'package:store_house/util/notification_util.dart';

class MainAppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MainAppController());
  }
}

class MainAppController extends GetxController {
  final AuthService _authService = Get.find();
  User? _user;


  User? get user => _user;

  set user(User? value) {
    _user = value;
  }

  Future<void> login(email, password) async {
    try {
      await _authService.login(email, password);
    } catch (e) {
      showErrorMessage(e);
    }
  }
}
