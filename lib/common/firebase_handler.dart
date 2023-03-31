import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kfccheck/common/user.dart';
import 'package:kfccheck/models/branch_response.dart';
import 'package:uuid/uuid.dart';

import '../services/services.dart';

class FirebaseHandler {
  late FirebaseAuth _firebaseAuth;
  late FirebaseFirestore _firebaseFirestore;
  static final FirebaseHandler _instance = FirebaseHandler._internal();

  late String? _userId;

  var uuid = const Uuid();

  factory FirebaseHandler() {
    _instance._firebaseAuth = FirebaseAuth.instance;
    _instance._firebaseFirestore = FirebaseFirestore.instance;
    _instance._userId = FirebaseAuth.instance.currentUser!.uid;
    return _instance;
  }
  FirebaseHandler._internal();

  Future<dynamic> getBranches(String customerId) async {
    var response = await _firebaseFirestore.collection('branch').where('customerId', isEqualTo: customerId).get();
    var customer = await _firebaseFirestore.collection('customers').doc(customerId).get();
    return response.docs
        .map(
          (e) => BranchResponse(name: e['name'], area: e['area'], imageLogo: customer['imageLogo'], id: e['id']),
        )
        .toList();
  }

  Future<dynamic> getInspectionPoints(String branchId) async {
    var response = await _firebaseFirestore
        .collection('checkLists')
        .where('roleId', isEqualTo: locator.get<LocalUser>().userData['roleId'])
        .get();
    var oldInspection = await _firebaseFirestore
        .collection('scheduledCheckLists')
        .doc(locator.get<LocalUser>().userData['docId'])
        .get();
    if (oldInspection.exists) {
      var response = await _firebaseFirestore
          .collection('scheduledCheckLists')
          .doc(locator.get<LocalUser>().userData['docId'])
          .collection('checkLists')
          .get();
      return {
        'isOld': true,
        'doc': oldInspection,
        'data': response.docs,
      };
    } else {
      await _firebaseFirestore
          .collection('scheduledCheckLists')
          .doc(locator.get<LocalUser>().userData['docId'])
          .set({});
      await _firebaseFirestore
          .collection('scheduledCheckLists')
          .doc(locator.get<LocalUser>().userData['docId'])
          .update({branchId: ''});
      for (var doc in response.docs) {
        List<Map<String, dynamic>> updatedList = [];
        doc.data()['ips'].forEach((e) {
          updatedList.add({
            'options': e['options'],
            'question': e['question'],
            'answer': '',
          });
        });
        await _firebaseFirestore
            .collection('scheduledCheckLists')
            .doc(locator.get<LocalUser>().userData['docId'])
            .collection('checkLists')
            .doc(doc.id)
            .set({
          'categoryName': doc.data()['categoryName'],
          'ipsCount': 0,
          'ips': updatedList,
        });
      }
      return {
        'isOld': false,
        'doc': {branchId: ''},
        'data': response.docs,
      };
    }
  }
}
