import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kfccheck/provider/branch_provider.dart';
import 'package:provider/provider.dart';

import '../../common/common.dart';
import '../../common/const.dart';
import '../../common/user.dart';
import '../../models/branch_model.dart';
import '../../provider/login_provider.dart';
import '../../services/services.dart';
import '../inspection_screen/inspection_standards.dart';

class CompletedWalk extends StatelessWidget {

 var branch = locator.get<LocalUser>();
  @override
  Widget build(BuildContext context) {
    var branchProvider = Provider.of<BranchProvider>(context, listen: false);
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('AssignmentTemplate')
              .where('branchId', isEqualTo: branchProvider.branchId)
              .where('assignTo', isEqualTo: loginProvider.crunntUserId).where('status',isEqualTo: 'completed')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          //routeTo(InspectionStandards(), context: context);
                          // showAlertDialog(context, branches[index].id);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          elevation: 0,
                          color: Colors.white,
                          child: 
                          Consumer<BranchProvider>(builder: (context, value, child) {
                            return  ListTile(
                          leading: Image.asset('asset/MC.png'),
                          title:  Text(
                              value.branchDetail[0].branchName.toString(),
                            //  branch.branchDetail[index].branchName.toString(),
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Sblack),
                          ),
                          subtitle: Text(value.branchDetail[0].branchLocation.toString() +
                              "" +
                             value.branchDetail[0].branchCity.toString()),
                          trailing: Text(snapshot.data!.docs[index]['status'],
                           // "Last Walk: 2 days ago",
                            style: TextStyle(color: Colors.black.withOpacity(0.5)),
                          ),
                          );
                       
                          },)
                          
                        ),
                      );
                    });
              }
            } else
              return Container(
                child: const Center(
                  child: Text(
                    'no data found ',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              );
          },
        ));
  }
}
