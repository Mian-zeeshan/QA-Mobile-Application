// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:kfccheck/common/common.dart';
// import 'package:kfccheck/common/const.dart';
// import 'package:kfccheck/screens/actions.dart';
// import 'package:kfccheck/screens/anomalies.dart';
// import 'package:kfccheck/screens/emergencies_reported.dart';
// import 'package:kfccheck/screens/report_emergency.dart';
// import 'package:kfccheck/screens/walk_per_weak.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import '../../common/user.dart';
// import '../../main.dart';
// import '../../services/services.dart';
// import '../menu_bar.dart';
//
// class Admin extends StatefulWidget {
//   const Admin({super.key});
//
//   @override
//   State<Admin> createState() => _Admin();
// }
//
// class _Admin extends State<Admin> {
//   DateTime? Date;
//   bool isFieldShow = false;
//
//   // bool isCalibratedShow = false;
//   TextEditingController DateController = TextEditingController();
//
//   selectDate(BuildContext context, int index) async {
//     DateTime? selectDate;
//     await DatePicker.showDatePicker(context, showTitleActions: true, onChanged: (date) {}, onConfirm: (date) {
//       selectDate = date;
//     }, currentTime: DateTime.now());
//     if (selectDate != null) {
//       setState(() {
//         if (index == 0) {
//           DateController.text = DateFormat('dd/MM/yyyy').format(selectDate!);
//           Date = selectDate;
//         }
//       });
//     }
//   }
//
//   List<String> _branches = [
//     'KFC Johar Town',
//     'KFC Township',
//     'KFC DHA',
//     'KFC Gulberg',
//     'KFC Bahria Town',
//     'KFC Emporium Mall'
//   ];
//   int _selectedIndex = 0;
//
//   List<Widget> _widgetOptions = <Widget>[
//     Report(),
//     ActionScreen(),
//     Anomalies(),
//   ];
//
//   final _tooltip = TooltipBehavior(enable: true);
//   String? _selectedbranches = null;
//
//   final List<ChartData> chartData = [
//     ChartData('week 1', 10),
//     ChartData('week 2', 10),
//     ChartData('week 3', 10),
//     ChartData('week 4', 10),
//   ];
//
//   showAlertDialog(BuildContext context) {
//     AlertDialog alert = AlertDialog(
//       title: const Text(
//         "Are you sure you want to sign out?",
//         textAlign: TextAlign.center,
//       ),
//       actions: [
//         Row(
//           children: [
//             Expanded(
//               child: GestureDetector(
//                 child: Container(
//                   width: 151,
//                   height: 48,
//                   decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: GRay),
//                   child: const Center(
//                       child: Text(
//                     'Cancel',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: white),
//                   )),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             Expanded(
//               child: GestureDetector(
//                 child: Container(
//                   width: 151,
//                   height: 48,
//                   decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: Black),
//                   child: const Center(
//                       child: Text(
//                     'Sign Out',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Dgreen),
//                   )),
//                 ),
//                 onTap: () async {
//                   await locator.get<LocalUser>().handleLogout();
//                   routeTo(const MyApp(), context: context, clearStack: true);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: gray,
//         body: SafeArea(
//             child: Column(children: [
//           Stack(children: [
//             Container(
//               color: black,
//               height: 231,
//               width: double.infinity,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                       Text(
//                         'Hello ${locator.get<LocalUser>().userData['firstName']} !',
//                         style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: yellow),
//                       ),
//                       GestureDetector(
//                         child: Container(
//                           width: 38,
//                           height: 38,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: GREEN,
//                           ),
//                           child: Center(
//                               child: Text(
//                             locator.get<LocalUser>().userData['firstName'][0],
//                             style: const TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.w400, color: Color.fromRGBO(51, 51, 51, 1)),
//                           )),
//                         ),
//                         onTap: () {
//                           showAlertDialog(context);
//                         },
//                       ),
//                     ]),
//                     const Text('Have a great day!',
//                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Gray))
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 150, left: 10, right: 10),
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(19)),
//                     color: Colors.white,
//                   ),
//                   height: 241,
//                   width: MediaQuery.of(context).size.width,
//                   child: const Padding(
//                     padding: EdgeInsets.only(top: 20, left: 20),
//                     child: Text(
//                       'Total Walks',
//                       style: TextStyle(
//                           fontSize: 20, fontWeight: FontWeight.w600, color: kala, fontStyle: FontStyle.normal),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 219, left: 150),
//               child: CircularPercentIndicator(
//                 radius: 40,
//                 lineWidth: 20.0,
//                 percent: 0.7,
//                 animation: true,
//                 backgroundColor: lightgray,
//                 circularStrokeCap: CircularStrokeCap.round,
//                 progressColor: GREEN,
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(top: 334, left: 39),
//               child: Text(
//                 'Open Actions =',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: kala, fontStyle: FontStyle.normal),
//               ),
//             ),
//           ]),
//           const SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 10, right: 10),
//             child: Container(
//               height: 255,
//               width: 385,
//               decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(19)), color: white),
//               child: Column(children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       const Expanded(
//                         flex: 2,
//                         child: Text(
//                           'Walk Trends',
//                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: kala),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 3,
//                         child: Container(
//                           height: 30,
//                           width: 210,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: const Color(0xffE8E8E8), width: 1),
//                             borderRadius: const BorderRadius.all(Radius.circular(6)),
//                             color: light,
//                           ),
//                           child: DropdownButton(
//                             hint: const Padding(
//                               padding: EdgeInsets.only(left: 5),
//                               child: Text(
//                                 'Select a Branch',
//                                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: lighht),
//                               ),
//                             ),
//                             underline: Container(),
//                             iconSize: 25,
//                             icon: const Padding(
//                               padding: EdgeInsets.only(left: 10),
//                               child: Icon(
//                                 Icons.arrow_drop_down,
//                                 color: Black,
//                               ),
//                             ),
//                             value: _selectedbranches,
//                             onChanged: (newValue) {
//                               setState(() {
//                                 _selectedbranches = newValue!;
//                               });
//                             },
//                             items: _branches.map((e) {
//                               return DropdownMenuItem(
//                                 child: new Text(e),
//                                 value: e,
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10, right: 10),
//                   child: Container(
//                       height: 209,
//                       width: 340,
//                       child: SfCartesianChart(
//                           primaryXAxis: CategoryAxis(
//                             arrangeByIndex: false,
//                             //rangePadding: ChartRangePadding.additional
//                           ),
//                           series: <ChartSeries<ChartData, String>>[
//                             ColumnSeries<ChartData, String>(
//                                 // isTrackVisible: true,
//                                 color: GRAY,
//                                 dataSource: chartData,
//                                 xValueMapper: (ChartData data, io) => data.x,
//                                 yValueMapper: (ChartData data, io) => data.y)
//                           ])),
//                 ),
//               ]),
//             ),
//           ),
//           Expanded(
//             child: const SizedBox(),
//           ),
//           Container(
//             child: BottomNavigationBar(
//               type: BottomNavigationBarType.fixed,
//               backgroundColor: white,
//               currentIndex: _selectedIndex,
//               selectedItemColor: kala,
//               unselectedItemColor: kala,
//               selectedFontSize: 14,
//               unselectedFontSize: 14,
//               onTap: (index) {
//                 setState(() {
//                   _selectedIndex = index;
//                 });
//               },
//               items: [
//                 BottomNavigationBarItem(
//                   icon: InkWell(
//                       child: const Icon(
//                         Icons.warning_amber,
//                         color: Black,
//                         size: 30,
//                       ),
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => Emergencies()));
//                       }),
//                   label: ('Emergency'),
//                 ),
//                 BottomNavigationBarItem(
//                   icon: InkWell(
//                     child: const ImageIcon(
//                       AssetImage('asset/actions.png'),
//                       color: Black,
//                       size: 30,
//                     ),
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => ActionScreen()));
//                     },
//                   ),
//                   label: ('Actions'),
//                 ),
//                 BottomNavigationBarItem(
//                   icon: InkWell(
//                     child: const ImageIcon(
//                       AssetImage('asset/anomalies.png'),
//                       color: Black,
//                       size: 30,
//                     ),
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => Anomalies()));
//                     },
//                   ),
//                   label: ('Users'),
//                 ),
//               ],
//             ),
//           ),
//         ])));
//   }
// }
//
// class ChartData {
//   ChartData(this.x, this.y);
//   final String x;
//   final double? y;
// }
