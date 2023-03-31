import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kfccheck/common/const.dart';
import 'package:kfccheck/screens/report_emergency.dart';

class Roles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Roles();
}

class _Roles extends State<Roles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            color: white,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 40),
              child: Row(
                children: const [
                  Icon(Icons.warning, color: red),
                  Text(
                    'Report the Emergency to the following',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: black),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'RGM',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Sblack),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  child: Container(
                    width: 73,
                    height: 29,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: black),
                    child: const Center(
                      child: Text(
                        'Assign',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: gReen),
                      ),
                    ),
                  ),
                  onTap: () {
                    var id = DateTime.now().microsecondsSinceEpoch;
                    try {
                      FirebaseFirestore.instance.collection('RGM').doc('$id').set({
                        "Emergency": emergencySend.toString(),
                      });
                      Fluttertoast.showToast(msg: 'Taskassigned');
                    } catch (e) {
                      Fluttertoast.showToast(msg: 'error');
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'QA Head',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Sblack),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  child: Container(
                    width: 73,
                    height: 29,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: black),
                    child: const Center(
                      child: Text(
                        'Assign',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: gReen),
                      ),
                    ),
                  ),
                  onTap: () {
                    var id = DateTime.now().microsecondsSinceEpoch;
                    try {
                      FirebaseFirestore.instance.collection('QA Head').doc('$id').set({
                        "Emergency": emergencySend.toString(),
                      });
                      Fluttertoast.showToast(msg: 'Taskassigned');
                    } catch (e) {
                      Fluttertoast.showToast(msg: 'error');
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Regional Head',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Sblack),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  child: Container(
                    width: 73,
                    height: 29,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: black),
                    child: const Center(
                      child: Text(
                        'Assign',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: gReen),
                      ),
                    ),
                  ),
                  onTap: () {
                    var id = DateTime.now().microsecondsSinceEpoch;
                    try {
                      FirebaseFirestore.instance.collection('Regional Head').doc('$id').set({
                        "Emergency": emergencySend.toString(),
                      });
                      Fluttertoast.showToast(msg: 'Taskassigned');
                    } catch (e) {
                      Fluttertoast.showToast(msg: 'error');
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Area Coach',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Sblack),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  child: Container(
                    width: 73,
                    height: 29,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: black),
                    child: const Center(
                      child: Text(
                        'Assign',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: gReen),
                      ),
                    ),
                  ),
                  onTap: () {
                    var id = DateTime.now().microsecondsSinceEpoch;
                    try {
                      FirebaseFirestore.instance.collection('Area Coach').doc('$id').set({
                        "Emergency": emergencySend.toString(),
                      });
                      Fluttertoast.showToast(msg: 'Taskassigned');
                    } catch (e) {
                      Fluttertoast.showToast(msg: 'error');
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
