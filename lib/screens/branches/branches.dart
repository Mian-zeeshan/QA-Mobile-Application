import 'package:flutter/material.dart';
import 'package:kfccheck/common/common.dart';
import 'package:kfccheck/common/const.dart';
import 'package:kfccheck/common/user.dart';
import 'package:kfccheck/components/bg.dart';
import 'package:kfccheck/screens/inspection_screen/inspection_standards.dart';
import 'package:provider/provider.dart';
import '../../models/branch_model.dart';
import '../../provider/branch_provider.dart';
import '../../services/services.dart';

class Branches extends StatefulWidget {
  const Branches({super.key});

  @override
  State<Branches> createState() => _BranchesState();
}

class _BranchesState extends State<Branches> {
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
    var branch = locator.get<LocalUser>();
    branch.clearbranchDetail();

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
        title: 'Branches',
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 629,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: gray,
          ),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: FutureBuilder<List<BranchModel>>(
                future: branch.getBranchDetail(branchProvider.branchId.toString()),
                builder: (context,AsyncSnapshot<List<BranchModel>> snapshot) {
                  if(snapshot.hasData){
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }
       else{
          return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            routeTo(InspectionStandards(), context: context);
                            // showAlertDialog(context, branches[index].id);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            elevation: 0,
                            color: Colors.white,
                            child: ListTile(
                              leading: Image.asset('asset/MC.png'),
                              title: Text(
                                branch.branchDetail[index].branchName.toString(),
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Sblack),
                              ),
                              subtitle: Text(snapshot.data![index].branchLocation.toString()+""+ snapshot.data![index].branchCity.toString()),
                              trailing: Text(
                                "Last Walk: 2 days ago",
                                style: TextStyle(color: Colors.black.withOpacity(0.5)),
                              ),
                            ),
                          ),
                        );
                      });
               
       }
        
                  }
                  else
        
                  
                 return Container(
                  child: Center(child: Text('no data found ',style: TextStyle(fontSize: 20),),),
                 );
                 
                 
                },
              )),
        ),
        
        isBranchScreen: true,);
  }
}
