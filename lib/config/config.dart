import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kfccheck/common/common.dart';
import 'package:uuid/uuid.dart';

import '../common/local_storage_provider.dart';
import '../models/inspectionChecklistModel.dart';
import '../screens/done.dart';
import '../services/services.dart';

class AppConfig {
// Diaog box for regetser customer admin user
  static Future<void> addUserDialog(
    context,
    //String title,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        // ignore: unused_local_variable
        Size size;
        size = MediaQuery.of(context).size;
        return SizedBox(
          width: 400,
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                  child: Column(
                    children: const [Text('Are you want to submit Walk? ')],
                  )),
            ),
          ),
        );
      },
    );
  }
}

showAlertDialog(BuildContext context) {
  const storage = FlutterSecureStorage();
  final CollectionReference assignDataCollection = FirebaseFirestore.instance.collection('AssignmentData');

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () async {
      var email = await locator.get<LocalStorageProvider>().retrieveDataByKey('checkListLocalyData');

      List<dynamic> decodedPeople = await json.decode(email);

      List<CheckListModel> myModelList = decodedPeople.map((map) => CheckListModel.fromJson(map)).toList();
      for (var data in myModelList) {
      
        assignDataCollection.doc(data.id).set(data.toMap());
      }
      Navigator.pop(context);
       routeTo(Done(), context: context);
    },
  );
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () async {
      await storage.deleteAll();
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("QA Walk"),
    content: Text("Do you want to submit?"),
    actions: [
      cancelButton,
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
