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
import '../../services/services.dart';
import 'inspection_screen.dart';

class InspectionSubChapters extends StatefulWidget {
  String? chaptersId;
  InspectionSubChapters({super.key, required this.chaptersId});
  @override
  State<InspectionSubChapters> createState() => _InspectionSubChaptersState();
}

class _InspectionSubChaptersState extends State<InspectionSubChapters> {
  List<dynamic> branches = [];
  @override
  void initState() {
    super.initState();
     
    // getData();
  }

  @override
  void dispose() {
    var branch = locator.get<LocalUser>();
    branch.clearbranchDetail();

    // TODO: implement dispose
    super.dispose();
  }

  var branch = locator.get<LocalUser>();
  int groupValue = -1;
  bool isfalse = false;
  

  @override
  Widget build(BuildContext context) {
    return InspectionComponent(
      collection: FirebaseFirestore.instance
          .collection('AssigningSubChaptersCopy')
          // .where('customerId', isEqualTo: customerProvider.customerId.toString())
          // .where('branchid', isEqualTo: branchProvider.branchId.toString())
          .where('chpid', isEqualTo: widget.chaptersId)
          .snapshots(),
      pageTitle: 'SubChapters',
      route: (id,nam) async{
        String subChpId=id;
         const storage = FlutterSecureStorage();
       String? isAttempt =  await locator.get<LocalStorageProvider>().retrieveDataByKey(subChpId);
       
        // await storage.deleteAll();
        if('false'=='true'){

        }
        else{
  routeTo(InspectionScreen(subChpId: id,title: nam,), context: context);
        }
        
        
      },
    );
  }
}
