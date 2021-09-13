import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:store_house/service/auth_service.dart';

class EditProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(EditProfileController());
  }

}

class EditProfileController extends GetxController {
  final AuthService _authService = Get.find();
  RxString _avatar = ''.obs;


  String get avatar => _avatar.value;

  set avatar(String value) {
    _avatar.value = value;
  }

  @override
  void onClose() {
    _avatar.value = '';
  }

  Future<void> updateProfile(profile) async {
    await _authService.updateUser(displayName: profile['displayName'],
        phoneNumber: profile['phoneNumber'],
        photoUrl: profile['photoUrl']);
  }

  Map<String, dynamic> getCurrentUser() {
    var user = _authService.currentUser;
    _avatar.value = user!.photoURL ?? '';
    var map = {
      'displayName': user.displayName,
      'phoneNumber': user.phoneNumber ?? '',
      'photoUrl': user.photoURL
    };
    print(map);
    return map;
  }
}