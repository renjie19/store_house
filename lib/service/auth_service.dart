import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:store_house/util/notification_util.dart';

class AuthService extends GetxService {
  late FirebaseAuth _auth;

  @override
  void onInit() {
    _auth = FirebaseAuth.instance;
    super.onInit();
  }

  Future<User?> login(email, password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      print(userCredential);
      return userCredential.user;
    } catch (e) {
      showErrorMessage(e);
    }
  }

  Future<User?> register(email, password) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential);
      return userCredential.user;
    } catch (e) {
      showErrorMessage(e);
    }
  }
}
