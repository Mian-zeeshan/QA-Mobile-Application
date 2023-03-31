// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:kfccheck/blocs/bloc/inspection_bloc.dart';
// import 'package:kfccheck/common/common.dart';
// import 'package:kfccheck/common/const.dart';
// import 'package:kfccheck/components/bg.dart';
// import 'package:kfccheck/components/global_button.dart';
// import 'package:kfccheck/components/qa_scaffold.dart';

// import 'inspection_screen.dart';

// class Inspection extends StatefulWidget {
//   final String branchId;
//   const Inspection({Key? key, required this.branchId}) : super(key: key);

//   @override
//   State<Inspection> createState() => _InspectionState();
// }

// class _InspectionState extends State<Inspection> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   DateTime? Date;
//   bool isFieldShow = true;
//   // bool isCalibratedShow = false;
//   TextEditingController DateController = TextEditingController();
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

//   @override
//   Widget build(BuildContext context) {
//     return QaScaffold(
//       button: GlobalButton(
//         onTap: () {},
//         title: 'Submit',
//       ),
//       child: Background(
//         title: 'Inspection Areas',
//         child: Container(
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//             color: gray,
//           ),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15),
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 3, right: 3),
//                   child: Container(
//                     width: 374,
//                     decoration:
//                         const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: Colors.white60),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Padding(
//                           padding: EdgeInsets.only(left: 10, top: 10),
//                           child: Text('Is the thermometer calibrated?',
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400,
//                                   color: Black,
//                                   fontStyle: FontStyle.normal)),
//                         ),
//                         Row(
//                           children: [
//                             Theme(
//                               data: Theme.of(context).copyWith(
//                                 unselectedWidgetColor: Colors.grey[500],
//                               ),
//                               child: Checkbox(
//                                 checkColor: black,
//                                 value: !isFieldShow,
//                                 activeColor: Dgreen,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     isFieldShow = !isFieldShow;
//                                   });
//                                 },
//                                 shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
//                               ),
//                             ),
//                             const Text(
//                               'Yes',
//                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Black),
//                             ),
//                             Theme(
//                               data: Theme.of(context).copyWith(
//                                 unselectedWidgetColor: Colors.grey[500],
//                               ),
//                               child: Checkbox(
//                                 checkColor: black,
//                                 value: isFieldShow,
//                                 activeColor: Dgreen,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     isFieldShow = !isFieldShow;
//                                   });
//                                 },
//                                 shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
//                               ),
//                             ),
//                             Text('No', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: black)),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Visibility(
//                           visible: !isFieldShow,
//                           child: GestureDetector(
//                             child: SizedBox(
//                               height: 40,
//                               child: TextFormField(
//                                 textAlign: TextAlign.left,
//                                 controller: DateController,
//                                 decoration: const InputDecoration(
//                                   border: OutlineInputBorder(),
//                                   hintText: 'Select Date',
//                                   contentPadding: EdgeInsets.only(left: 10),
//                                   hintStyle: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                     color: GREY,
//                                   ),
//                                   suffixIcon: Padding(
//                                     padding: EdgeInsets.only(bottom: 8),
//                                     child: Icon(Icons.calendar_month_outlined, size: 20),
//                                   ),
//                                   enabled: false,
//                                 ),
//                               ),
//                             ),
//                             onTap: () {
//                               selectDate(context, 0);
//                             },
//                           ),
//                         ),
//                         Visibility(
//                             visible: isFieldShow,
//                             child: const Text('Calibrate now!',
//                                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: green)))
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Expanded(
//                   child: Visibility(
//                     visible: !isFieldShow,
//                     child: BlocBuilder<InspectionBloc, InspectionState>(
//                       builder: (context, state) {
//                         if (state is InspectionFetechedSuccessfull) {
//                           return ListView.builder(
//                               physics: const ScrollPhysics(),
//                               shrinkWrap: true,
//                               itemCount: state.data['data'].length,
//                               itemBuilder: (context, index) {
//                                 print(
//                                     state.data['data'][index]['ips'].length);
//                                 return GestureDetector(
//                                   onTap: () {
//                                     routeTo(
//                                         InspectionScreen(
//                                           docId: state.data['data'][index].id,
//                                           title: state.data['data'][index]['categoryName'],
//                                         ),
//                                         context: context);
//                                   },
//                                   child: Card(
//                                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
//                                     elevation: 0,
//                                     color: Colors.white,
//                                     child: Column(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.only(top: 20, left: 10),
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(state.data['data'][index]['categoryName'],
//                                                   style: const TextStyle(
//                                                       fontSize: 16, fontWeight: FontWeight.w400, color: Sblack)),
//                                               const Icon(
//                                                 Icons.arrow_forward_ios_outlined,
//                                                 color: black,
//                                                 size: 15,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           height: 20,
//                                         ),
//                                         LinearProgressIndicator(
//                                           backgroundColor: white,
//                                           valueColor: const AlwaysStoppedAnimation<Color>(gReen),
//                                           value:
//                                               state.data['data'][index]['ips'].where((e) => e['answer'] != '').length /
//                                                   state.data['data'][index]['ips'].length,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               });
//                         } else if (state is InspectionInProgress) {
//                           return const Center(
//                             child: CircularProgressIndicator(),
//                           );
//                         } else {
//                           return Container();
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
