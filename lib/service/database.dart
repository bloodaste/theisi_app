import 'package:cloud_firestore/cloud_firestore.dart';

class Databaseservices {
  //collection reference
  final CollectionReference product =
      FirebaseFirestore.instance.collection('Inventorydata');

  Future<void> deleteproducts(String productid) async {
    return await product.doc(productid).delete();
  }

  Future<void> updateproduct(
    String qr,
    String productid,
    String name,
    num layernumber,
    num initialstock,
    num restockvalue,
  ) async {
    return await product.doc(productid).update({
      'qr': qr,
      'name': name,
      'layernumber': layernumber,
      'initalStock': initialstock,
      'restockvalue': restockvalue,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getProducts() {
    return product.orderBy('timestamp', descending: true).snapshots();
  }

  Future<DocumentReference> addproducts(
    String name,
    num layernumber,
    num initalstock,
    num restockvalue,
    String qr,
  ) async {
    return await product.add({
      'qr': qr,
      'name': name,
      'layernumber': layernumber,
      'initalStock': initalstock,
      'restockvalue': restockvalue,
      'timestamp': Timestamp.now(),
      // 'imageurl': iamgeurl
    });
  }
}
