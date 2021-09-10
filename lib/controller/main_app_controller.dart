import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:store_house/service/auth_service.dart';
import 'package:store_house/service/storage_service.dart';
import 'package:store_house/util/notification_util.dart';

class MainAppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MainAppController());
  }
}

class MainAppController extends GetxController {
  final AuthService _authService = Get.find();
  final StorageService _storageService = Get.find();

  Future<void> login(email, password) async {
    try {
      await _authService.login(email, password);
    } catch (e) {
      throw e;
    }
  }

  Future<void> register(email, password, displayName) async {
    try {
      await _authService.register(email, password, displayName);
    } catch (e) {
      throw e;
    }
  }

  void logOut() {
    _authService.signOut();
  }

  Future<Map<String, dynamic>> findItemByBarcode(barcodeId) async {
    try {
      return await _storageService.findItemByBarcodeId(barcodeId);
    } catch (e) {
      throw e;
    }
  }
}
