import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kfccheck/common/const.dart';
import 'package:kfccheck/components/bg.dart';
import 'package:kfccheck/screens/comment_screen.dart';
import 'package:kfccheck/screens/roles.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:uuid/uuid.dart';
import '../../common/local_storage_provider.dart';
import '../../models/inspectionChecklistModel.dart';
import '../../provider/customer_provider.dart';
import '../../provider/globel_provider.dart';
import '../../provider/login_provider.dart';
import '../../services/services.dart';

class InspectionScreen extends StatefulWidget {
  final String subChpId;
  final String title;

  const InspectionScreen({
    super.key,
    required this.subChpId,
    required this.title,
  });

  @override
  State<InspectionScreen> createState() => _InspectionScreenState();
}

class _InspectionScreenState extends State<InspectionScreen> {
  final TextEditingController nameController = TextEditingController();
  final List<TextEditingController> numericQuestionAnswerReceiveController = [];
  final List<TextEditingController> freeTextQuestionAnswerReceiveController = [];
  final _formKey = GlobalKey<FormState>();
  List<String> questionIdsList = [];
  bool isFieldShow = false;
  List<int> questioList = [];
  List<int> e = [];
  static const storage = FlutterSecureStorage();
  File? imageFile;
  // getFromCamera() async {
  //   PickedFile? pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     // setState(() {
  //     //   imageFile = File(pickedFile.path);
  //     // });
  //   }
  // }

  String? expectedAnswer;

  @override
  Widget build(BuildContext context) {
    var customerProvider = Provider.of<CustomerProvider>(context, listen: false);
    var globalProvider = Provider.of<GlobelProvider>(context, listen: false);

    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    print('widget build');
    return Background(
      title: widget.title,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 414,
                height: 478,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  color: gray,
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('AssigningChecklistCopy')
                      .where('customerId', isEqualTo: customerProvider.customerId.toString())
                      .where('subchapterId', isEqualTo: widget.subChpId)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Something went wrong");
                    }

                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            questionIdsList.add(snapshot.data!.docs[index]['questionId'].toString());
                            if (snapshot.data!.docs[index]['DataType'] == 'Options') {
                              globalProvider.setsaveNumericChecklistIndex(index);
                              for (int i = 0; i < globalProvider.saveNumericChecklistIndex.length; i++) {
                                globalProvider.setValueInlistOfOptionCheckList();
                              }

                              // numericQuestionAnswerReceiveController.add(TextEditingController());
                            } else if (snapshot.data!.docs[index]['DataType'] == 'Boolean') {
                              globalProvider.setsaveBooleanChecklistIndex(index);
                              for (int i = 0; i < globalProvider.saveBooleanChecklistIndex.length; i++) {
                                globalProvider.setValueInlistOfBooleanChecklist();
                              }

                              // freeTextQuestionAnswerReceiveController.add(TextEditingController());
                            }

                            return Padding(
                              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                elevation: 0,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]['question'],
                                        style:
                                            const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Sblack),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      snapshot.data!.docs[index]['DataType'] == 'Options'
                                          ? SizedBox(
                                              width: 500,
                                              height: 50,
                                              child: StreamBuilder<QuerySnapshot>(
                                                stream: FirebaseFirestore.instance
                                                    .collection('AssigningCheckListOption')
                                                    .where('questionId',
                                                        isEqualTo: snapshot.data!.docs[index]['questionId'])
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
                                                    return ListView.builder(
                                                      scrollDirection: Axis.horizontal,
                                                      shrinkWrap: false,
                                                      itemBuilder: (context, newIndex) {
                                                        int findindex =
                                                            globalProvider.saveNumericChecklistIndex.indexOf(index);
                                                        if (snapshot.data!.docs[newIndex]['isExpected'] == true) {
                                                          expectedAnswer =
                                                              snapshot.data!.docs[newIndex]['name'].toString();
                                                        }
                                                        return Row(
                                                          children: [
                                                            Consumer<GlobelProvider>(
                                                              builder: (context, value, child) {
                                                                return Radio(
                                                                  value: newIndex,
                                                                  groupValue: value.isSelectedoption.contains(index)
                                                                      ? value.listOfOptionCheckList[findindex][0]
                                                                      : null,
                                                                  onChanged: (val) async {
                                                                    value.addisSelectedoption(index);
                                                                    //value.setisSelected(true);

                                                                    value.removeValueFromlistOfOptionCheckList(
                                                                        findindex);
                                                                    value
                                                                        .addIndexInSpecificIndexOfListOfOptionCheckList(
                                                                            findindex, val!);
                                                                    // globelProvider.rows[findindex].removeAt(0);
                                                                    // globelProvider.rows[findindex].add(val!);

                                                                    DateTime now = DateTime.now();

                                                                    String formattedDate =
                                                                        DateFormat('MMM d, yyyy – h:mm a').format(now);

                                                                    var uuid = const Uuid().v4();
                                                                    //setSelectedRadioTile(val!);
                                                                    String answer = snapshot
                                                                        .data!
                                                                        .docs[value.listOfOptionCheckList[findindex][0]]
                                                                            ['name']
                                                                        .toString();

                                                                    await InspectionChecklist
                                                                        .addDataIntoCheckListModelList(
                                                                            snapshot.data!.docs[newIndex]['questionId']
                                                                                .toString(),
                                                                            answer == expectedAnswer ? true : false,
                                                                            answer,
                                                                            loginProvider.assignmentId.toString(),
                                                                            uuid,
                                                                            formattedDate);
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                            Text(snapshot.data!.docs[newIndex]['name'],
                                                                style: const TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.w400,
                                                                    color: Black)),
                                                          ],
                                                        );
                                                      },
                                                      itemCount: 2,
                                                    );
                                                  }
                                                },
                                              ))
                                          : snapshot.data!.docs[index]['DataType'] == 'Numeric'
                                              ? numericAnswerWidget(
                                                  snapshot.data!.docs[index]['questionId'], index, loginProvider)
                                              : snapshot.data!.docs[index]['DataType'] == 'Boolean'
                                                  ? SizedBox(
                                                      width: 500,
                                                      height: 50,
                                                      child: ListView.builder(
                                                        scrollDirection: Axis.horizontal,
                                                        shrinkWrap: false,
                                                        itemBuilder: (context, newIndex) {
                                                          int findindex =
                                                              globalProvider.saveBooleanChecklistIndex.indexOf(index);

                                                          return Row(
                                                            children: [
                                                              Consumer<GlobelProvider>(
                                                                builder: (context, value, child) {
                                                                  return Radio(
                                                                    value: newIndex,
                                                                    groupValue: value.isSelectedoption.contains(index)
                                                                        ? value.listOfBooleanChecklist[findindex][0]
                                                                        : null,
                                                                    onChanged: (val) async {
                                                                      value.addisSelectedoption(index);
                                                                      value.setisSelected(true);

                                                                      value.removeValueFromlistOfBooleanChecklist(
                                                                          findindex);
                                                                      value
                                                                          .addIndexInSpecificIndexOfListOfBooleanChecklist(
                                                                              findindex, val!);
                                                                      // value.listOfBooleanChecklist[findindex].removeAt(0);
                                                                      // value.listOfBooleanChecklist[findindex].add(val);
                                                                      int ans =
                                                                          value.listOfBooleanChecklist[findindex][0];
                                                                      // print(ans);
                                                                      bool expectedAnser =
                                                                          snapshot.data!.docs[index]['booleanAnswer'];
                                                                      DateTime now = DateTime.now();

                                                                      String formattedDate =
                                                                          DateFormat('MMM d, yyyy – h:mm a')
                                                                              .format(now);

                                                                      var uuid = const Uuid().v4();
                                                                      String questionId = snapshot
                                                                          .data!.docs[index]['questionId']
                                                                          .toString();
                                                                      bool answer = false;
                                                                      if (ans == 0) {
                                                                        answer = true;
                                                                      }
                                                                      // //setSelectedRadioTile(val!);

                                                                      await InspectionChecklist
                                                                          .addDataIntoCheckListModelList(
                                                                              questionId,
                                                                              answer == expectedAnser ? true : false,
                                                                              ans == 0 ? 'yes' : 'no',
                                                                              loginProvider.assignmentId.toString(),
                                                                              uuid,
                                                                              formattedDate);
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                              Text(newIndex == 0 ? 'yes' : 'no',
                                                                  style: const TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w400,
                                                                      color: Black)),
                                                            ],
                                                          );
                                                        },
                                                        itemCount: 2,
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 50,
                                                      color: const Color(0xFFF2F2F2),
                                                      width: 130,
                                                      child: TextFormField(
                                                        validator: (value) {
                                                          if (value == null) {
                                                            return 'Enter value';
                                                          }
                                                          null;
                                                          return null;
                                                        },
                                                        onChanged: (value) {},
                                                        controller: freeTextQuestionAnswerReceiveController[index],
                                                        // controller: chpController,
                                                        decoration: const InputDecoration(
                                                          hintText: 'Comment here',
                                                          hintStyle: TextStyle(
                                                              fontSize: 16.0,
                                                              fontWeight: FontWeight.w400,
                                                              color: Color(0xFFABAAAA),
                                                              fontFamily: 'SofiaPro'),
                                                          enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(color: Color(0xFFF2F1F1))),
                                                        ),
                                                      ),
                                                    ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            child: Container(
                                              width: 67,
                                              height: 20,
                                              decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(10)), color: Silver),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: const [
                                                  Icon(Icons.person, color: white, size: 15),
                                                  Center(
                                                      child: Text(
                                                    'Task',
                                                    style: TextStyle(
                                                        fontSize: 10, fontWeight: FontWeight.w400, color: white),
                                                  ))
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => Roles()));
                                            },
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 67,
                                            height: 20,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10)), color: Silver),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    // getFromCamera();
                                                  },
                                                  child: const Icon(Icons.camera_alt_outlined, color: white, size: 15),
                                                ),
                                                const Text(
                                                  'Image',
                                                  style: TextStyle(
                                                      fontSize: 10, fontWeight: FontWeight.w400, color: white),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            child: Container(
                                              width: 67,
                                              height: 20,
                                              decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(10)), color: Silver),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: const [
                                                  Icon(Icons.message, color: white, size: 15),
                                                  Text(
                                                    'Notes',
                                                    style: TextStyle(
                                                        fontSize: 10, fontWeight: FontWeight.w400, color: white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context) => const CommentsScreen()));
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }

                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("loading...."),
                        SizedBox(
                          height: 10,
                        ),
                        Center(child: CircularProgressIndicator()),
                      ],
                    ));
                  },
                ),
              ),
              SizedBox(
                width: 300,
                height: 60,
                child: MaterialButton(
                  color: Colors.black,
                  onPressed: () async {
                    final _storage = const FlutterSecureStorage();
                    // String encodedPeople = await locator
                    //     .get<LocalStorageProvider>()
                    //     .retrieveDataByKey('listOfKeys');

                    // print(encodedPeople);
                    // List<dynamic> decodedPeople = json.decode(encodedPeople);
                    // List<CheckListModel> people = decodedPeople.map((p) => CheckListModel.fromJson(p)).toList();
                    // for (var d in people) {
                    //   print(d.toMap());
                    // }
                    // await storage.deleteAll();
                    // String email = await locator
                    //     .get<LocalStorageProvider>()
                    //     .retrieveDataByKey('251b2a1a-31a4-46ba-80f1-891707347aab');
                    //     print(email);

                    // String? encodedPeople = await storage.read(key: '251b2a1a-31a4-46ba-80f1-891707347aab');
                    // List<dynamic> decodedPeople = json.decode(encodedPeople!);
                    // List<CheckListModel> people = decodedPeople.map((p) => CheckListModel.fromJson(p)).toList();
                    // for (var d in people) {
                    //   print(d.toMap());
                    // }
                    // print(email);

                    // for (var d in InspectionChecklist.checkListAnswers) {
                    //   print(d.toMap());
                    // }
                    // InspectionChecklist.checkListAnswers.clear();
                    // globalProvider.clearisSelectedoption();

                    // var globelProvider = Provider.of<GlobelProvider>(context, listen: false);
                    //  await   storage.deleteAll();
//todo:--------------------------------------------------------
                    var email = await locator.get<LocalStorageProvider>().retrieveDataByKey('ali1');
                     print(email);
                    List<dynamic> decodedPeople = json.decode(email);

                    List<CheckListModel> myModelList =
                        decodedPeople.map((map) => CheckListModel.fromJson(map)).toList();
                    for (var d in myModelList) {
                      print(d.value);
                    }
                    //---------------------------------------------------------

//final data = await storage.read(key: '251b2a1a-31a4-46ba-80f1-891707347aab');
// final List<dynamic> retrievedMappedList = jsonDecode(data!);
// final List<CheckListModel> retrievedList = retrievedMappedList.map((e) => CheckListModel.fromJson(e)).toList();

//  const storage = FlutterSecureStorage();
//         String? isAttempt= await storage.read(key: widget.subChpId);
                    //   print(email);

                    // globelProvider.clearisSelectedoption();
                    // InspectionChecklist.checkListAnswers.clear();
                    //   const storage = FlutterSecureStorage();
                    // String? stringOfItems = await storage.read(key: 'listOfItems');
                    // List<dynamic> listOfItems = jsonDecode(stringOfItems!);
                    // print(listOfItems);

// String? stringDataOfKeys = await storage.read(key: 'zeeshan');
//  List<dynamic> listDataOfKeys = await jsonDecode(stringDataOfKeys!);
//  print(listDataOfKeys);

//Todo:this code used for confirmation of successfully submitted checklists
                    // const storage = FlutterSecureStorage();
                    // String submitted = 'true';
                    // await storage.write(key: widget.subChpId, value: submitted);

                    //----------------------------------

                    //todo: this code used for write the checklists into local storage with subchapter key values
                    //   if (_formKey.currentState!.validate()) {
                    //     String subchapterId = widget.subChpId;
                    //     await saveChecklistsDataInLocalStorage(subchapterId);

                    //    // await savesAllSubChaptersKeys(subchapterId);
                    //   //     String submitted = 'true';
                    //   // await locator.get<LocalStorageProvider>().saveByKey(subchapterId, data: submitted);
                    // globalProvider.clearisSelectedoption();
                    // InspectionChecklist.checkListAnswers.clear();
                    // print('sucessfully complete all function');
                    //  // Navigator.pop(context);

                    //   }

                    //ToDo:this code use for insert data in the firebase
                    // if (_formKey.currentState!.validate()) {
                    // final CollectionReference assignDataCollection =
                    //     FirebaseFirestore.instance.collection('AssignmentData');
                    // for (var data in InspectionChecklist.checkListAnswers) {
                    //   var uuid = const Uuid().v4();
                    //   assignDataCollection.doc(data.id).set(data.toMap());
                    // }
                    //-----------------------------------------

                    //Todo:this code used for read list of objects data
//                     String? encodedPeople = await storage.read(key: 'questionlist');
// List<dynamic> decodedPeople = json.decode(encodedPeople!);
// List<CheckListModel> people = decodedPeople.map((p) => CheckListModel.fromJson(p)).toList();
//   for(var d in people){
//     print(d.toMap());
//   }
//
//                       globelProvider.clearisSelectedoption();
//                      InspectionChecklist.checkListAnswers.clear();

                    //--------------------------------
                  },
                  child: const Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveChecklistsDataInLocalStorage(String subchapterId) async {
    var email = await locator.get<LocalStorageProvider>().retrieveDataByKey('ali1');
    if (email != null) {
      List<dynamic> decodedPeople = json.decode(email);

      List<CheckListModel> myModelList = decodedPeople.map((map) => CheckListModel.fromJson(map)).toList();

      final List<Map<String, dynamic>> updatedMappedList =
          List<Map<String, dynamic>>.from(myModelList.map((e) => e.toMap()))
            ..addAll(InspectionChecklist.checkListAnswers.map((e) => e.toMap()));
             await storage.write(key: 'ali1', value: json.encode(updatedMappedList));
              print('sucee fuly add second time');

      // String checkListData = json.encode(myModelList.map((e) => e.toMap()).toList()).a;
    } else {
      String checkListData = await  json.encode(InspectionChecklist.checkListAnswers.map((e) => e.toMap()).toList());
      // var email = await locator.get<LocalStorageProvider>().retrieveDataByKey('zeeshan');

      await storage.write(key: 'ali1', value: (checkListData));
      print('sucessfully wriote list first time');
    }

    // String encodedChecklistsData = json.encode(InspectionChecklist.checkListAnswers.map((p) => p.toMap()).toList());

    // await locator.get<LocalStorageProvider>().saveByKey(subchapterId, data: encodedChecklistsData);
    // // await storage.write(key: subchapterId, value: encodedChecklistsData);
  }

  Future<void> savesAllSubChaptersKeys(String subchapterId) async {
    String key = subchapterId;
    List<String> listOfKeys = [];
    String? stringDataOfKeys = await storage.read(key: 'listOfKeys');
    if (stringDataOfKeys == null) {
      listOfKeys.add(key);
      await storage.write(key: 'listOfKeys', value: jsonEncode(listOfKeys));
      listOfKeys.clear();
      print('first time execute');
    } else {
      List<dynamic> listDataOfKeys = await jsonDecode(stringDataOfKeys);
      List<String> swapKeysListOfStringType = [];
      swapKeysListOfStringType.addAll(listDataOfKeys.cast<String>());
      swapKeysListOfStringType.add(key);

      await storage.write(key: 'listOfKeys', value: jsonEncode(swapKeysListOfStringType));

      listDataOfKeys.clear();
      swapKeysListOfStringType.clear();

      print('second time');
      // List<String> myListU=[];
    }
  }

  Widget numericAnswerWidget(String questionId, int index, LoginProvider loginProvider) {
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
}
