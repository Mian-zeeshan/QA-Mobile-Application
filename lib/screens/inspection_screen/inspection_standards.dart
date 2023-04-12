import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kfccheck/common/common.dart';
import 'package:kfccheck/common/user.dart';
import 'package:provider/provider.dart';
import '../../common/local_storage_provider.dart';
import '../../components/inspections_page.dart';
import '../../provider/branch_provider.dart';
import '../../provider/customer_provider.dart';
import '../../provider/login_provider.dart';
import '../../services/services.dart';
import 'inspection_chapters.dart';

class InspectionStandards extends StatefulWidget {

  String? assignStandardId;
   InspectionStandards({super.key,
  this.assignStandardId
  });

  @override
  State<InspectionStandards> createState() => _InspectionStandardsState();
}

class _InspectionStandardsState extends State<InspectionStandards> {
  List<dynamic> branches = [];
  @override
  void initState() {
    // var branch = locator.get<LocalUser>();
    // branch.clearbranchDetail();

    super.initState();
    // getData();
  }

  @override
  void dispose() {
    // var branch = locator.get<LocalUser>();
    // branch.clearbranchDetail();

    // TODO: implement dispose
    super.dispose();
  }

  var branch = locator.get<LocalUser>();
  int groupValue = -1;
  bool isfalse = false;

  @override
  Widget build(BuildContext context) {
    var localUserHandler = locator.get<LocalUser>();
    var branchProvider = Provider.of<BranchProvider>(context, listen: false);
    var customerProvider = Provider.of<CustomerProvider>(context, listen: false);
     const storage = FlutterSecureStorage();
    return InspectionComponent(

      collection: FirebaseFirestore.instance
          .collection('AssigningStandardsCopy')
          .where('customerId', isEqualTo: customerProvider.customerId.toString())
          .where('id', isEqualTo: widget.assignStandardId)
         // .where('id', whereIn: localUserHandler.templatesIdsList)
          .snapshots(),
      pageTitle: 'Standard',
      route: (id, name,length) async {
        await getAssignsTemplatesIdsd(context, id);
          String? isAttempt;
        isAttempt = await locator.get<LocalStorageProvider>().retrieveDataByKey(id);
        if(isAttempt=='true'){
         // await   storage.deleteAll();
        }
        else{routeTo(InspectionChapters(standardId: id,), context: context);}
        
      },
    );
    
  }

  Future getAssignsTemplatesIdsd(BuildContext context, String id) async {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('AssignmentTemplate')
          .where('assignTo', isEqualTo: loginProvider.crunntUserId)
          .where('templateId', isEqualTo: id)
          .get();
      for (var element in snapshot.docs) {
        String assignId = await element['id'];
        loginProvider.setassignmentId(assignId);
        // _templatesIdsList.add(templateId);
      }
    } catch (e) {
      // showSnackBar(context, e.toString());
    }
  }
}
