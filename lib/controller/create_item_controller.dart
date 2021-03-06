import 'package:get/get.dart';
import 'package:store_house/service/auth_service.dart';
import 'package:store_house/service/storage_service.dart';
import 'package:store_house/util/notification_util.dart';

class CreateItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CreateItemController());
  }
}

class CreateItemController extends GetxController {
  final StorageService _storageService = Get.find();

  Future<void> createItem(item) async {
    await _storageService.addItem(item);
  }
  Future<Map<String, dynamic>> updateItem(item) async {
    return await _storageService.updateItem(item);
  }
}