import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kfccheck/common/common.dart';
import 'package:kfccheck/common/user.dart';
import 'package:provider/provider.dart';
import '../../common/local_storage_provider.dart';
import '../../components/inspections_page.dart';
import '../../provider/branch_provider.dart';
import '../../provider/customer_provider.dart';
import '../../services/services.dart';
import 'inspection_chapters.dart';
import 'inspection_subchapters.dart';

class InspectionChapters extends StatefulWidget {
  String standardId;
  
  InspectionChapters({required this.standardId, });
  @override
  State<InspectionChapters> createState() => _InspectionChaptersState();
}

class _InspectionChaptersState extends State<InspectionChapters> {
  List<dynamic> branches = [];
  @override
  void initState()  {
   // String keyList = getValue();


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
    var branchProvider = Provider.of<BranchProvider>(context, listen: false);
    var customerProvider = Provider.of<CustomerProvider>(context, listen: false);
    return InspectionComponent(
      collection: FirebaseFirestore.instance
          .collection('AssigningChaptersCopy')

          // .where('branchid', isEqualTo: branchProvider.branchId.toString())
          .where('stdid', isEqualTo: widget.standardId)
          .snapshots(),
      pageTitle: 'Chapters',
      route: (id, name, length) async {
        String chpId = id;
        String? isAttempt;
        isAttempt = await locator.get<LocalStorageProvider>().retrieveDataByKey(chpId);
        if (isAttempt == 'true') {
        } else {
          routeTo(
            InspectionSubChapters(chaptersId: id, standardId: widget.standardId,chapterListLength: length),
            context: context,
          );
        }
      },
    );
  }


}
