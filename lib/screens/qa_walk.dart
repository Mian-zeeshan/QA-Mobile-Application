import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:kfccheck/common/common.dart';
import 'package:kfccheck/common/const.dart';
import 'package:kfccheck/common/user.dart';
import 'package:kfccheck/components/global_button.dart';
import 'package:kfccheck/screens/branches/branches.dart';
import 'package:kfccheck/services/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../components/qa_scaffold.dart';

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

  List<String> _branches = ['KFC Johar Town', 'KFC Township', 'KFC DHA', 'KFC Gulberg', 'KFC Bahria Town', 'KFC Emporium Mall'];

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
                onTap: () {},
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

  final List<ChartData> chartData = [
    ChartData('week 1', 10),
    ChartData('week 2', 10),
    ChartData('week 3', 10),
    ChartData('week 4', 10),
  ];
  @override
  Widget build(BuildContext context) {
    return QaScaffold(
      button: GlobalButton(
        title: 'Start QA Walk',
        onTap: () {
          routeTo(Branches(), context: context);
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
                          child: Text(
                            'Hello ${locator.get<LocalUser>().userData['firstName']}',
                            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: yellow),
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
                            child: Center(
                                child: Text(
                              locator.get<LocalUser>().userData['firstName'][0],
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Color.fromRGBO(51, 51, 51, 1)),
                            )),
                          ),
                          onTap: () {
                            showAlertDialog(context);
                          },
                        ),
                      ],
                    ),
                    const Text('Have a great day!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Gray))
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
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: kala, fontStyle: FontStyle.normal),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 219, left: 150),
              child: CircularPercentIndicator(
                radius: 40,
                lineWidth: 20.0,
                percent: 0.7,
                animation: true,
                backgroundColor: lightgray,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: GREEN,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 334, left: 39),
              child: Text(
                'Open Actions =',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: kala, fontStyle: FontStyle.normal),
              ),
            ),
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
                        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6)), color: light),
                        child: DropdownButton(
                          hint: const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              'Select a branch',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: lighht),
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
                              child: new Text(e),
                              value: e,
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
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
                              dataSource: chartData,
                              xValueMapper: (ChartData data, io) => data.x,
                              yValueMapper: (ChartData data, io) => data.y)
                        ]),
                  ),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}