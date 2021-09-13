import 'package:get/get.dart';
import 'package:store_house/service/storage_service.dart';

class ItemManagementBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ItemManagementController());
  }
}

class ItemManagementController extends GetxService {
  final StorageService _storageService = Get.find();
  List<Map<String, dynamic>> _items = <Map<String, dynamic>>[].obs;
  RxBool _isSearching = false.obs;
  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) {
    _isLoading.value = value;
  }

  bool get isSearching => _isSearching.value;

  set isSearching(bool value) {
    _isSearching.value = value;
  }

  List<Map<String, dynamic>> get items => _items;

  @override
  void onInit() async {
    super.onInit();
    _isLoading.value = true;
    await getItems();
    Future.delayed(Duration(seconds: 2), () => _isLoading.value = false);
  }

  Future<void> getItems() async {
    final itemResults = await _storageService.findAllItems();
    _items.clear();
    _items.addAll(itemResults);
  }

  Future<void> findItemsByName(itemName) async {
    final results = await _storageService.findItemsByName(itemName);
    _items.clear();
    _items.addAll(results);
  }

  Future<Map<String, dynamic>> findItemByBarcode(barcodeId) async {
    return await _storageService.findItemByBarcodeId(barcodeId);
  }
}
