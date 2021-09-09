import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:store_house/service/auth_service.dart';
import 'package:store_house/util/notification_util.dart';

class StorageService extends GetxService {
  static const String ITEM_COLLECTION = 'store_house_items';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _itemCollection = FirebaseFirestore.instance.collection(ITEM_COLLECTION);

  Future<void> addItem(item) async {
    try {
      final itemWithTrail = addTrail(item);
      var itemDocument = _itemCollection.doc();
      itemWithTrail['documentId'] = itemDocument.id;
      await itemDocument.set(itemWithTrail);
    } catch (error) {
      showErrorMessage(error);
    }
  }

  Future<void> updateItem(item) async {
    try {

    } catch (error) {
      showErrorMessage(error);
    }
  }

  Future<void> deleteItem(id) async {
    try {

    } catch (error) {
      showErrorMessage(error);
    }
  }

  Future<void> findItemByBarcodeId(barCodeId) async {
    try {

    } catch (error) {
      showErrorMessage(error);
    }
  }

  Future<void> findItemByName(barCodeId) async {
    try {

    } catch (error) {
      showErrorMessage(error);
    }
  }

  Map<String, dynamic> addTrail(data, {isNew = true}) {
    final dataWithTrail = new Map<String, dynamic>.from(data);
    if(isNew) {
      dataWithTrail['dateCreated'] = DateTime.now().millisecondsSinceEpoch;
      dataWithTrail['createdBy '] = _auth.currentUser!.displayName ?? _auth.currentUser!.email;
    }
    dataWithTrail['dateModified'] = DateTime.now().millisecondsSinceEpoch;
    dataWithTrail['modifiedBy'] = _auth.currentUser!.displayName ?? _auth.currentUser!.email;
    return dataWithTrail;
  }


}