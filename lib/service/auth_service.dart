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

  User? get currentUser => _auth.currentUser;

  Future<User?> login(email, password) async {
    final UserCredential userCredential = await _auth
        .signInWithEmailAndPassword(email: email, password: password);
    print(userCredential);
    return userCredential.user;
  }

  Future<void> register(email, password, displayName, photoUrl) async {
    final UserCredential userCredential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password);
    await userCredential.user!.updateDisplayName(displayName);
    await userCredential.user!.updatePhotoURL(photoUrl);
  }

  Future<void> updateUser({displayName = '', contactNumber = '', photoUrl = ''}) async {
    await _auth.currentUser?.updateDisplayName(displayName);
    await _auth.currentUser?.updatePhoneNumber(contactNumber);
    await _auth.currentUser?.updatePhotoURL(photoUrl);
  }

  Future<void> forgotPassword(email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  void signOut() {
    _auth.signOut();
  }
}
