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
  String chaptersId;
  String standardId;
  int chapterListLength;
  InspectionSubChapters({super.key, required this.chaptersId,required this.standardId, this.chapterListLength=0,});
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
  //  /ranch.clearbranchDetail();

    // TODO: implement dispose
    super.dispose();
  }

  var branch = locator.get<LocalUser>();
  int groupValue = -1;
  bool isfalse = false;
   String? isAttempt;

  @override
  Widget build(BuildContext context) {
    return InspectionComponent(
      collection: FirebaseFirestore.instance
          .collection('AssigningSubChaptersCopy')
          .where('chpid', isEqualTo: widget.chaptersId)
          .snapshots(),
      pageTitle: 'SubChapters',
      route: (id, nam, length) async {
        String subChpId = id;
         isAttempt = await locator.get<LocalStorageProvider>().retrieveDataByKey(subChpId);

        if (isAttempt == 'true') {
        }
         else {
          // ignore: use_build_context_synchronously
          routeTo(
              InspectionScreen(
                subChpId: id,
                title: nam,
                subChaptersListLength: length,
                standardId: widget.standardId,
                chapterId:widget.chaptersId ,
                chapterListLength: widget.chapterListLength,
              ),
              context: context);
        }
      },
      
    );
  }
}
