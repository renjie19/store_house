import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:store_house/service/auth_service.dart';
import 'package:store_house/util/notification_util.dart';

class StorageService extends GetxService {
  static const String ITEM_COLLECTION = 'store_house_items';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _itemCollection =
      FirebaseFirestore.instance.collection(ITEM_COLLECTION);

  Future<void> addItem(item) async {
    try {
      await _barcodeExists(item['barcodeId']);
      final itemWithTrail = addTrail(item);
      var itemDocument = _itemCollection.doc();
      itemWithTrail['documentId'] = itemDocument.id;
      await itemDocument.set(itemWithTrail);
    } catch (error) {
      throw error;
    }
  }

  Future<void> _barcodeExists(final String barcode) async {
    var existingItemWithBarcode =
        await _itemCollection.where('barcodeId', isEqualTo: barcode).get();
    if (existingItemWithBarcode.docs.isNotEmpty) {
      throw 'Barcode already exists';
    }
  }

  Future<void> updateItem(item) async {
    try {} catch (error) {
      showErrorMessage(error);
    }
  }

  Future<void> deleteItem(documentId) async {
    await _itemCollection.doc(documentId).delete();
  }

  Future<Map<String, dynamic>> findItemByBarcodeId(barcodeId) async {
    try {
      final result = await _itemCollection
          .where('barcodeId', isEqualTo: barcodeId)
          .limit(1)
          .get();
      if (result.docs.isEmpty) {
        throw 'Item does not exist.';
      }
      return result.docs.first.data();
    } catch (error) {
      throw error;
    }
  }

  Future<List<Map<String, dynamic>>> findItemsByName(itemName) async {
    print(itemName);
    final results = await _itemCollection.orderBy('itemName')
        .startAt([itemName]).endAt([itemName + '\uf8ff']).get();
    print(results.docs);
    return results.docs.map((e) => e.data()).toList();
  }

  Map<String, dynamic> addTrail(data, {isNew = true}) {
    final dataWithTrail = new Map<String, dynamic>.from(data);
    if (isNew) {
      dataWithTrail['dateCreated'] = DateTime.now().millisecondsSinceEpoch;
      dataWithTrail['createdBy'] =
          _auth.currentUser!.displayName ?? _auth.currentUser!.email;
    }
    dataWithTrail['dateModified'] = DateTime.now().millisecondsSinceEpoch;
    dataWithTrail['modifiedBy'] =
        _auth.currentUser!.displayName ?? _auth.currentUser!.email;
    return dataWithTrail;
  }

  Future<List<Map<String, dynamic>>> findAllItems(
      {itemName = '', barcodeId = ''}) async {
    final results = await _itemCollection.orderBy('itemName').get();
    if (results.docs.isEmpty) {
      return [];
    }
    return results.docs.map((e) => e.data()).toList();
  }
}
