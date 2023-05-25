import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:kfccheck/common/common.dart';
import 'package:kfccheck/common/const.dart';
import 'package:kfccheck/components/global_button.dart';
import 'package:kfccheck/provider/branch_provider.dart';
import 'package:kfccheck/screens/assign_walk/assign_walk.dart';
import 'package:kfccheck/screens/login_screen/login_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../common/user.dart';
import '../components/qa_scaffold.dart';
import '../config/config.dart';
import '../services/services.dart';

class QA_walk extends StatefulWidget {
  const QA_walk({super.key});

  @override
  State<QA_walk> createState() => _QA_walkState();
}

class _QA_walkState extends State<QA_walk> {
  DateTime? Date;
  bool isFieldShow = false;

  // bool isCalibratedShow = false;
  TextEditingController DateController = TextEditingController();

  selectDate(BuildContext context, int index) async {
    DateTime? selectDate;
    await DatePicker.showDatePicker(context, showTitleActions: true, onChanged: (date) {}, onConfirm: (date) {
      selectDate = date;
    }, currentTime: DateTime.now());
    if (selectDate != null) {
      setState(() {
        if (index == 0) {
          DateController.text = DateFormat('dd/MM/yyyy').format(selectDate!);
          Date = selectDate;
        }
      });
    }
  }

  List<String> _branches = [

  ];

  final _tooltip = TooltipBehavior(enable: true);
  String? _selectedbranches = null;
  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: const Text(
        "Are you sure you want to sign out?",
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
                  Navigator.pop(context);
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
                    'Sign Out',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Dgreen),
                  )),
                ),
                onTap: () {
                  routeTo(const LoginScreen(), context: context, clearStack: true);
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

  final User = FirebaseAuth.instance.currentUser;
  final formKey = GlobalKey<FormState>();

  final List<ChartData> chartDummyData = [
    ChartData('week 1', 1),
    ChartData('week 2', 1),
    ChartData('week 3', 1),
    ChartData('week 4', 1),
  ];
  var storage = const FlutterSecureStorage();
  var localUserHandler = locator.get<LocalUser>();
  @override
  void initState() {
    AppConfig.getBranchCompletedWalk(context);
    AppConfig.getWalkDetailByWeek(context);
    localUserHandler.getBranchName( context);
    

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     var branchProvider = Provider.of<BranchProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to exit from app?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                    //Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: QaScaffold(
        button: GlobalButton(
          title: 'Start QA Walk',
          onTap: () async {
            showReportEmergecyAlertDialog(context);
            // await   storage.deleteAll();
           // routeTo(const AssignWalk(), context: context);
          },
        ),
        child: SingleChildScrollView(
          child: Column(children: [
            Stack(children: [
              Container(
                color: black,
                height: 231,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child:  Text(
                              // 'Hello ${locator.get<LocalUser>().userData['firstName']}',
                              'Hello ${(localUserHandler.loginUserName)![0].toUpperCase()+ (localUserHandler.loginUserName)!.substring(1)}!',
                              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: yellow,fontFamily: 'SofiaPro'),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: GREEN,
                              ),
                              child:  Center(
                                  child: Text(
                                // locator.get<LocalUser>().userData['firstName'][0],
                               localUserHandler.loginUserName!.substring(0,1).toUpperCase().toString() ,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400, color: Color.fromRGBO(51, 51, 51, 1)),
                              )),
                            ),
                            onTap: () {
                              showAlertDialog(context);
                            },
                          ),
                        ],
                      ),
                      const Text('Have a great day!',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Gray))
                    ],
                  ),
                ),
              ),
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.only(top: 150, left: 10, right: 10),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(19)),
                      color: Colors.white,
                    ),
                    height: 241,
                    width: MediaQuery.of(context).size.width,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 20, left: 20),
                      child: Text(
                        'Total Walks',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600, color: kala, fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                ),
              ),
              Consumer<BranchProvider>(
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 219, left: 150),
                    child: CircularPercentIndicator(
                      radius: 40,
                      lineWidth: 20.0,
                        percent: value.branchCompletedWalk==null  || value.branchTotalWalk == null? 0 :
                       (value.branchCompletedWalk!  / value.branchTotalWalk!) ,
                     // percent: value.branchCompletedWalk!.toDouble() / value.branchTotalWalk!.toDouble(),
                      //snapshot.hasData? double.parse('0.'+snapshot.data.toString()):0.0,
                      animation: true,
                      backgroundColor: lightgray,
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: GREEN,
                    ),
                  );
                },
              ),
              Consumer<BranchProvider>(
                builder: (context, value, child) {
                  return Padding(
                      padding: const EdgeInsets.only(top: 334, left: 39),
                      child: Text(
                        'Open Actions = ${value.branchTotalWalk ?? 0}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500, color: kala, fontStyle: FontStyle.normal),
                      ));
                },
              )
            
            
            ]),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 270,
                width: 385,
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(19)), color: white),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        const Text(
                          'Walk Trends',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: kala,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 30,
                          width: 185,
                          decoration:
                              const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6)), color: light),
                          child: DropdownButton(
                            hint:  Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                branchProvider.branchName.toString(),
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: lighht),
                              ),
                            ),
                            underline: Container(),
                            iconSize: 25,
                            icon: const Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Black,
                              ),
                            ),
                            value: _selectedbranches,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedbranches = newValue!;
                              });
                            },
                            items: _branches.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Consumer<BranchProvider>(
                    builder: (context, value, child) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SizedBox(
                          height: 209,
                          width: 340,
                          child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(
                                arrangeByIndex: false,
                                //rangePadding: ChartRangePadding.additional
                              ),
                              series: <ChartSeries<ChartData, String>>[
                                ColumnSeries<ChartData, String>(
                                    // isTrackVisible: true,
                                    color: GRAY,
                                    dataSource: value.chartData,
                                    xValueMapper: (ChartData data, String) => data.x,
                                    yValueMapper: (ChartData data, int) => data.y)
                              ]),
                        ),
                      );
                    },
                  )
                
                
                
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}
