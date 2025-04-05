import 'package:cloud_firestore/cloud_firestore.dart';

class Qrdatabase {
  final CollectionReference qravailable =
      FirebaseFirestore.instance.collection('availableqr');

  Stream<QuerySnapshot> getqr() {
    return qravailable.orderBy('time', descending: true).snapshots();
  }

  Future<void> addqr(String qr) async {
    try {
      qravailable.add({
        'time': Timestamp.now(),
        'qr': qr,
        'linked': false,
      });
    } catch (e) {
      print('something is wrong');
    }
  }

  Future<void> delqr(String qrid) async {
    try {
      qravailable.doc(qrid).delete();
    } catch (e) {
      print('unsucessful delete');
    }
  }

  Future<void> updateqr(String qrid, bool islinked) async {
    try {
      qravailable.doc(qrid).update({
        'time': Timestamp.now(),
        'linked': islinked,
      });
    } catch (e) {
      print(e);
    }
  }
}
