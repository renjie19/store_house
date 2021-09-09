import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  User? _user;


  User? get user => _user;

  set user(User? value) {
    _user = value;
  }
}