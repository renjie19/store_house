import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class StorageService extends GetxService {
  static const String DEBUG_ITEM_COLLECTION = 'debug_store_house_items';
  static const String ITEM_COLLECTION = 'store_house_items';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _itemCollection = FirebaseFirestore.instance
      .collection(kReleaseMode ? ITEM_COLLECTION : DEBUG_ITEM_COLLECTION);

  Future<void> addItem(item) async {
    try {
      if (!item['barcodeId'].isEmpty) {
        await _barcodeExists(item['barcodeId']);
      } else {
        await _itemNameExists(item['itemName']);
      }
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

  Future<void> _barcodeWithDocumentIdExists(final String barcode,
      final String documentId) async {
    var existingItemWithBarcode = await _itemCollection
        .where('barcodeId', isEqualTo: barcode)
        .where('documentId', isNotEqualTo: documentId)
        .get();
    if (existingItemWithBarcode.docs.isNotEmpty) {
      throw 'Barcode already exists on another item';
    }
  }

  Future<void> _itemNameExists(final String itemName) async {
    var existingItemWithName =
    await _itemCollection.where('itemName', isEqualTo: itemName).get();
    if (existingItemWithName.docs.isNotEmpty) {
      throw 'Item with name already exists.';
    }
  }

  Future<Map<String, dynamic>> updateItem(item) async {
    final updatedItemWithTrail = addTrail(item, isNew: false);
    if (!item['barcodeId'].isEmpty) {
      await _barcodeWithDocumentIdExists(item['barcodeId'], item['documentId']);
    } else {
      await _itemNameExists(item['itemName']);
    }
    await _itemCollection.doc(item['documentId']).update(updatedItemWithTrail);
    return updatedItemWithTrail;
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

  Future<List<Map<String, dynamic>>> findItemsByName(String itemName) async {
    print(itemName);
    final results = await _itemCollection.orderBy('itemName').get();
    final filteredResults = results.docs.where((element) =>
        (element.data()['itemName'] as String).toLowerCase().contains(
            itemName.toLowerCase()));
    return filteredResults.map((e) => e.data()).toList();
  }

  Map<String, dynamic> addTrail(data, {isNew = true}) {
    final dataWithTrail = new Map<String, dynamic>.from(data);
    if (isNew) {
      dataWithTrail['dateCreated'] = DateTime
          .now()
          .millisecondsSinceEpoch;
      dataWithTrail['createdBy'] =
          _auth.currentUser!.displayName ?? _auth.currentUser!.email;
    }
    dataWithTrail['dateModified'] = DateTime
        .now()
        .millisecondsSinceEpoch;
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
