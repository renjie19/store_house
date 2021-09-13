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
  RxString _selectedAvatar = 'avatar-beard-man'.obs;

  String get selectedAvatar => _selectedAvatar.value;

  set selectedAvatar(String value) {
    _selectedAvatar.value = value;
  }

  Future<void> login(email, password) async {
    await _authService.login(email, password);
  }

  Future<void> register(email, password, displayName, photoUrl) async {
    await _authService.register(email, password, displayName, photoUrl);
  }

  User? getCurrentUser() {
    return _authService.currentUser;
  }

  void logOut() {
    _authService.signOut();
  }

  Future<Map<String, dynamic>> findItemByBarcode(barcodeId) async {
    return await _storageService.findItemByBarcodeId(barcodeId);
  }
}
