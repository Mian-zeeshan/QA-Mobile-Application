import 'package:flutter/material.dart';
import 'package:kfccheck/common/common.dart';
import 'package:kfccheck/common/const.dart';
import 'package:kfccheck/common/user.dart';
import 'package:kfccheck/components/bg.dart';
import 'package:kfccheck/config/config.dart';
import 'package:kfccheck/screens/inspection_screen/inspection_standards.dart';
import 'package:provider/provider.dart';
import '../../components/bottom_navbar.dart';
import '../../models/branch_model.dart';
import '../../provider/branch_provider.dart';
import '../../services/services.dart';

class AssignWalk extends StatefulWidget {
  const AssignWalk({super.key});

  @override
  State<AssignWalk> createState() => _AssignWalkState();
}

class _AssignWalkState extends State<AssignWalk> {
  List<dynamic> branches = [];

  // getData() async {
  //   var branch = await locator.get<FirebaseHandler>().getBranches(locator.get<LocalUser>().userData['customerId']);
  //   branch.forEach((element) {
  //     BlocProvider.of<InspectionBloc>(context).add(InspectionPointsLoaded(branchId: element.id));
  //   });
  //   setState(() {
  //     branches = branch;
  //   });
  // }

  // showAlertDialog(BuildContext context, String branchId) {
  //   AlertDialog alert = AlertDialog(
  //     title: const Text(
  //       "Do you want to report an emergency",
  //       textAlign: TextAlign.center,
  //     ),
  //     actions: [
  //       Row(
  //         children: [
  //           Expanded(
  //             child: GestureDetector(
  //               child: Container(
  //                 width: 151,
  //                 height: 48,
  //                 decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: GRay),
  //                 child: const Center(
  //                     child: Text(
  //                   'No',
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: white),
  //                 )),
  //               ),
  //               onTap: () {
  //                 routeTo(
  //                     Inspection(
  //                       branchId: branchId,
  //                     ),
  //                     context: context);
  //               },
  //             ),
  //           ),
  //           const SizedBox(
  //             width: 10,
  //           ),
  //           Expanded(
  //             child: GestureDetector(
  //               child: Container(
  //                 width: 151,
  //                 height: 48,
  //                 decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: Black),
  //                 child: const Center(
  //                     child: Text(
  //                   'Yes',
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Dgreen),
  //                 )),
  //               ),
  //               onTap: () {
  //                 Navigator.push(context, MaterialPageRoute(builder: (context) => Report()));
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
  @override
  void initState() {
   var branchProvider = Provider.of<BranchProvider>(context, listen: false);
    branch.getBranchDetail(branchProvider.branchId.toString(),branchProvider);

    // TODO: implement initState
    super.initState();
  }

  var branch = locator.get<LocalUser>();
  int groupValue = -1;
  bool isfalse = false;

  @override
  Widget build(BuildContext context) {
    var branchProvider = Provider.of<BranchProvider>(context, listen: false);
    return Background(
      title: 'Assign Walk',
      isBranchScreen: true,
     
      
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 629,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: gray,
        ),
        child:Consumer<BranchProvider>(builder: (context, value, child) {
          return  AppConfig.inspectionWalkPages[value.walkPagesIndex];
        },)
       
       // child:AppConfig.inspectionWalkPages[0],
     
      ),
    );
  }
}
