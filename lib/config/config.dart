import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:kfccheck/common/common.dart';
import 'package:kfccheck/screens/assign_walk/assign_walk.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../common/const.dart';
import '../common/local_storage_provider.dart';
import '../common/user.dart';
import '../models/inspectionChecklistModel.dart';
import '../provider/branch_provider.dart';
import '../provider/customer_provider.dart';
import '../provider/login_provider.dart';
import '../screens/assign_walk/completed_walk.dart';
import '../screens/assign_walk/missed_walk.dart';
import '../screens/assign_walk/pending_walk.dart';
import '../screens/done.dart';
import '../screens/qa_walk.dart';
import '../screens/report_emergency.dart';
import '../services/services.dart';

class AppConfig {
  static const storage = FlutterSecureStorage();
  static final CollectionReference assignDataCollection = FirebaseFirestore.instance.collection('AssignmentData');
  static var localUserHandler = locator.get<LocalUser>();
  static String? assignmentId;

  static var inspectionWalkPages = [PendingWalk(), MissedWalk(), CompletedWalk()];

  static Widget branchesDropDownWidget(context) {
    var customerProvider = Provider.of<CustomerProvider>(context, listen: false);
    // final provider = Provider.of<screenprovider>(context);
    return Container(
      // width: 200,
      // height: 50,
      color: const Color(0xFFF2F1F1),

      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Branch')
            .where('customerId', isEqualTo: customerProvider.customerId)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasData == false) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return Consumer<BranchProvider>(
            builder: (context, value, child) {
              return DropdownButton<String>(
                dropdownColor: Colors.white,

                isDense: true,
                hint: const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    'Select a branch',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: lighht),
                  ),
                ),
                underline: Container(),
                value: value.branchName,
                iconSize: 25,
                icon: const Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: Black,
                  ),
                ),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                // decoration: const InputDecoration(enabledBorder: InputBorder.none),
                // validator: (value) {
                //   if(value?.isEmpty ?? true){
                //     return'This Field Required*';
                //   }
                //   return null;
                // },
                onChanged: (String? newValue) async {
                  value.clearadminChartData();

                  await getBranchIdByName(newValue!, context);
                  await getBranchCompletedWalk(context);
                  await getAdminWalkDetailByWeek(context);
                  value.setBranchName(newValue);
                },
                items: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                  return DropdownMenuItem<String>(
                    value: data['branchName'],
                    child: Row(
                      children: [
                        Text(
                          data['branchName'],
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }

  static Future getBranchIdByName(String branchName, context) async {
    try {
      var branchProvider = Provider.of<BranchProvider>(context, listen: false);
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Branch').where('branchName', isEqualTo: branchName).get();
      for (var element in snapshot.docs) {
        String branchId = await element['branchId'];
        branchProvider.setBranchId(branchId);
      }
    } catch (e) {
      print(e.toString());
    }
  }
// Diaog box for regetser customer admin user

  static Future<void> saveChecklistsDataInLocalStorage() async {
    var email = await locator.get<LocalStorageProvider>().retrieveDataByKey('checkListLocalyData');
    if (email != null) {
      List<dynamic> decodedPeople = json.decode(email);

      List<CheckListModel> myModelList = decodedPeople.map((map) => CheckListModel.fromJson(map)).toList();

      final List<Map<String, dynamic>> updatedMappedList =
          List<Map<String, dynamic>>.from(myModelList.map((e) => e.toMap()))
            ..addAll(InspectionChecklist.checkListAnswers.map((e) => e.toMap()));
      await storage.write(key: 'checkListLocalyData', value: json.encode(updatedMappedList));
      print('sucee fuly add second time');

      // String checkListData = json.encode(myModelList.map((e) => e.toMap()).toList()).a;
    } else {
      String checkListData = await json.encode(InspectionChecklist.checkListAnswers.map((e) => e.toMap()).toList());
      // var email = await locator.get<LocalStorageProvider>().retrieveDataByKey('zeeshan');

      await storage.write(key: 'checkListLocalyData', value: (checkListData));
      print('sucessfully wriote list first time');
    }

    // String encodedChecklistsData = json.encode(InspectionChecklist.checkListAnswers.map((p) => p.toMap()).toList());

    // await locator.get<LocalStorageProvider>().saveByKey(subchapterId, data: encodedChecklistsData);
    // // await storage.write(key: subchapterId, value: encodedChecklistsData);
  }

  static Future<void> savesAllLocallyStorageKeys(String subchapterId, String key) async {
    String subChapterkeyValue = subchapterId;
    List<String> listOfKeys = [];

    var keyList = await locator.get<LocalStorageProvider>().retrieveDataByKey(key);
    if (keyList == null) {
      listOfKeys.add(subChapterkeyValue);
      await storage.write(key: key, value: jsonEncode(listOfKeys));
      listOfKeys.clear();
      print('first time execute');
    } else {
      List<dynamic> listDataOfKeys = await jsonDecode(keyList);
      List<String> swapKeysListOfStringType = [];
      swapKeysListOfStringType.addAll(listDataOfKeys.cast<String>());
      swapKeysListOfStringType.add(subChapterkeyValue);

      await storage.write(key: key, value: jsonEncode(swapKeysListOfStringType));

      listDataOfKeys.clear();
      swapKeysListOfStringType.clear();

      print('second time');
      // List<String> myListU=[];
    }
  }

  static Widget numericOptionAnswerWidget(String questionId, int index, LoginProvider loginProvider) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('AssigningCheckListNumericOption')
            .where('questionId', isEqualTo: questionId)
            .where('isExpected', isEqualTo: true)
            .snapshots(),
        builder: (BuildContext contex, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasData == false) {
            return const Center(
              child: Text(
                'Data not found',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else {
            return Container(
              height: 50,
              color: const Color(0xFFF2F2F2),
              width: 160,
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter value';
                  }
                  null;
                  return null;
                },
                onChanged: (value) async {
                  DateTime now = DateTime.now();

// format the DateTime object
                  String formattedDate = DateFormat('MMM d, yyyy – h:mm a').format(now);
                  //String nowDate = formatter.format(now);
                  var uuid = const Uuid().v4();
                  int answer = int.parse(value);
                  int max = int.parse(snapshot.data!.docs[0]['max'].toString());
                  int min = int.parse(snapshot.data!.docs[0]['min'].toString());

                  await InspectionChecklist.addDataIntoCheckListModelList(
                      questionId.toString(),
                      (answer > min && answer < max) ? true : false,
                      value,
                      loginProvider.assignmentId.toString(),
                      uuid,
                      formattedDate);
                },
                decoration: const InputDecoration(
                    hintText: 'Enter the Value',
                    hintStyle: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w400, color: Color(0xFFABAAAA), fontFamily: 'SofiaPro'),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFF2F1F1))),
                    errorBorder: InputBorder.none),
              ),
            );
          }
        },
      ),
    );
  }

  static Future submitTemplateResponse(BuildContext context) async {
    var email = await locator.get<LocalStorageProvider>().retrieveDataByKey('checkListLocalyData');

    List<dynamic> decodedPeople = await json.decode(email);

    List<CheckListModel> myModelList = decodedPeople.map((map) => CheckListModel.fromJson(map)).toList();

    for (var data in myModelList) {
      assignDataCollection.doc(data.id).set(data.toMap());
    }
    assignmentId = myModelList[0].assignmentId.toString();
  }

  static Future assignTaskCompleted(BuildContext context) async {
    try {
      String currentDate = localUserHandler.getCurrentDateTime();
      var getCollection = await FirebaseFirestore.instance.collection('AssignmentTemplate');
      await getCollection.doc(assignmentId).update({
        'status': 'completed',
        'completedAt': currentDate,
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static Future getBranchCompletedWalk(
    BuildContext context,
  ) async {
    var branchProvider = Provider.of<BranchProvider>(context, listen: false);
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('AssignmentTemplate')
        .where('branchId', isEqualTo: branchProvider.branchId)
        .where('status', isEqualTo: 'completed')
        .get();

    branchProvider.setBranchCompletedWalk(snapshot.docs.length);
  }

  static getWalkDetailByWeek(BuildContext context) async {
    // List<ChartData> chartData = [];
    var branchProvider = Provider.of<BranchProvider>(context, listen: false);

    List<int> firstWeek = [];
    List<int> secondWeek = [];
    List<int> thirdWeek = [];
    List<int> fourthWeek = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('AssignmentTemplate')
        .where('branchId', isEqualTo: branchProvider.branchId)
        // .where('status', isEqualTo: 'completed')
        .get();
    branchProvider.setBranchTotalWalk(snapshot.docs.length);
    for (var data in snapshot.docs) {
      int dayOfMonth = (getDayFromDateTime(data['assignAt']));
      if (dayOfMonth == 1) {
        firstWeek.add(dayOfMonth);
      } else if (dayOfMonth == 2) {
        secondWeek.add(dayOfMonth);
      } else if (dayOfMonth == 3) {
        thirdWeek.add(dayOfMonth);
      } else {
        fourthWeek.add(dayOfMonth);
      }
    }

    branchProvider.setChartData(ChartData('week1', firstWeek.length));
    branchProvider.setChartData(ChartData('week2', secondWeek.length));
    branchProvider.setChartData(ChartData('week3', thirdWeek.length));
    branchProvider.setChartData(ChartData('week4', fourthWeek.length));
    // chartData.add(ChartData('week1', int.parse(firstWeek.length.toString())));
    // chartData.add(ChartData('week2', int.parse(secondWeek.length.toString())));
    // chartData.add(ChartData('week3', int.parse(thirdWeek.length.toString())));
    // chartData.add(ChartData('week4', int.parse(fourthWeek.length.toString())));

    //  return chartData;
  }

  static getAdminWalkDetailByWeek(BuildContext context) async {
    // List<ChartData> chartData = [];
    var branchProvider = Provider.of<BranchProvider>(context, listen: false);

    List<int> firstWeek = [];
    List<int> secondWeek = [];
    List<int> thirdWeek = [];
    List<int> fourthWeek = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('AssignmentTemplate')
        .where('branchId', isEqualTo: branchProvider.branchId)
        // .where('status', isEqualTo: 'completed')
        .get();
    branchProvider.setBranchTotalWalk(snapshot.docs.length);
    for (var data in snapshot.docs) {
      int dayOfMonth = (getDayFromDateTime(data['assignAt']));
      if (dayOfMonth == 1) {
        firstWeek.add(dayOfMonth);
      } else if (dayOfMonth == 2) {
        secondWeek.add(dayOfMonth);
      } else if (dayOfMonth == 3) {
        thirdWeek.add(dayOfMonth);
      } else {
        fourthWeek.add(dayOfMonth);
      }
    }

    branchProvider.setadminChartData(AdminChartData('week1', firstWeek.length));
    branchProvider.setadminChartData(AdminChartData('week2', secondWeek.length));
    branchProvider.setadminChartData(AdminChartData('week3', thirdWeek.length));
    branchProvider.setadminChartData(AdminChartData('week4', fourthWeek.length));
    firstWeek.clear();
    secondWeek.clear();
    thirdWeek.clear();
    fourthWeek.clear();
    // chartData.add(ChartData('week1', int.parse(firstWeek.length.toString())));
    // chartData.add(ChartData('week2', int.parse(secondWeek.length.toString())));
    // chartData.add(ChartData('week3', int.parse(thirdWeek.length.toString())));
    // chartData.add(ChartData('week4', int.parse(fourthWeek.length.toString())));

    //  return chartData;
  }

  static int getDayFromDateTime(String dateTime) {
    String dateString = dateTime;
    DateTime date = DateTime.parse(dateString);

    int currentWeekOfMonth = ((date.day - 1) / 7).floor() + 1;

    return currentWeekOfMonth;
  }
}

showAlertDialog(BuildContext context) {
  const storage = FlutterSecureStorage();
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () async {
      await AppConfig.submitTemplateResponse(context).then(
        (value) async {
          await AppConfig.assignTaskCompleted(context).then(
            (value) {
              Navigator.pop(context);

              routeTo(Done(), context: context);
            },
          );
        },
      );
    },
  );
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () async {
      await storage.deleteAll();
      // ignore: use_build_context_synchronously
      routeTo(const AssignWalk(), context: context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("QA Walk"),
    content: const Text("Do you want to submit?"),
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

Text text(
  text, {
  color = Colors.black,
  size = 14.0,
  fontWeight = FontWeight.normal,
  fontfamily = '',
  maxLines = 2,
}) {
  return Text(
    text,
    maxLines: 2,
    softWrap: false,
    style: TextStyle(color: color, fontSize: size, fontWeight: fontWeight, fontFamily: fontfamily),
  );
}

showReportEmergecyAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    title: const Text(
      "Do you want to report any emergency?",
      textAlign: TextAlign.center,
    ),
    actions: [
      Row(
        children: [
          Expanded(
            child: GestureDetector(
              child: Container(
                width: 151,
                height: 48,
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: GRay),
                child: const Center(
                    child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: white),
                )),
              ),
              onTap: () {
                routeTo(const AssignWalk(), context: context);
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                width: 151,
                height: 48,
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: Black),
                child: const Center(
                    child: Text(
                  'Report',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Dgreen),
                )),
              ),
              onTap: () {
                routeTo(Report(), context: context, clearStack: true);
              },
            ),
          ),
        ],
      ),
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
