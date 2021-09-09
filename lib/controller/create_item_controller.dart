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
    try {
      await _storageService.addItem(item);
    } catch (error) {
      showErrorMessage(error);
    }
  }
}