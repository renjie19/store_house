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

  bool get isSearching => _isSearching.value;

  set isSearching(bool value) {
    _isSearching.value = value;
  }

  List<Map<String, dynamic>> get items => _items;


  @override
  void onInit() async {
    super.onInit();
    await getItems();
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
