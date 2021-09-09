import 'package:get/get.dart';
import 'package:store_house/service/auth_service.dart';
import 'package:store_house/service/storage_service.dart';

void initGetDependencies() {
  Get.put(AuthService());
  Get.put(StorageService());
}