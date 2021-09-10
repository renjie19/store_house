import 'package:get/get.dart';
import 'package:store_house/service/storage_service.dart';

class ItemDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ItemDetailsController());
  }
}

class ItemDetailsController extends GetxController {
  final StorageService _storageService = Get.find();

  Future<void> deleteItem(documentId) async {
    await _storageService.deleteItem(documentId);
  }
}