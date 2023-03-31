import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kfccheck/blocs/bloc/inspection_bloc.dart';
import 'package:kfccheck/common/common.dart';
import 'package:kfccheck/common/const.dart';
import 'package:kfccheck/common/user.dart';
import 'package:kfccheck/components/bg.dart';
import 'package:kfccheck/screens/inspection_screen/inspection_areas.dart';
import 'package:kfccheck/screens/report_emergency.dart';
import 'package:provider/provider.dart';
import '../../common/firebase_handler.dart';
import '../../models/branch_model.dart';
import '../../provider/branch_provider.dart';
import '../../provider/customer_provider.dart';
import '../../services/services.dart';


class InspectionComponent extends StatelessWidget {
  
 final String pageTitle;
 final  Stream<QuerySnapshot> collection;
final  Function route;
InspectionComponent({required this.pageTitle,required this.collection,required this.route});
  @override
  Widget build(BuildContext context) {
    var branchProvider = Provider.of<BranchProvider>(context, listen: false);
    var customerProvider = Provider.of<CustomerProvider>(context, listen: false);
    return Background(
        title: pageTitle,
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 629,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: gray,
            ),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: StreamBuilder<QuerySnapshot>(
                  stream: collection,
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
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                route(snapshot.data!.docs[index]['id'].toString(),snapshot.data!.docs[index]['name'].toString());
                               
                              }, 
                              //  routeTo(InspectionChapters(standardId:snapshot.data!.docs[index]['id'].toString() ), context: context);
                                // showAlertDialog(context, branches[index].id);
                              
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                elevation: 0,
                                color: Colors.white,
                                child: ListTile(
                                  // leading: CircleAvatar(backgroundColor: Colors.black,radius: 10,),
                                  title: Text(
                                    snapshot.data!.docs[index]['name'],
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Sblack),
                                  ),
                                  // subtitle: Text(snapshot.data!.docs[index]['userName']),
                                  // trailing: Text(
                                  //   "Last Walk: 2 days ago",
                                  //   style: TextStyle(color: Colors.black.withOpacity(0.5)),
                                  // ),
                                ),
                              ),
                            );
                          });
                    }
                  },
                ))));
  }


}
