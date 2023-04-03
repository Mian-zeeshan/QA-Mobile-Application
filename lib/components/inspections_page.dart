import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kfccheck/common/const.dart';
import 'package:kfccheck/components/bg.dart';

import '../common/local_storage_provider.dart';
import '../services/services.dart';

class InspectionComponent extends StatelessWidget {
  final String pageTitle;
  final Stream<QuerySnapshot> collection;
  final Function route;

  const InspectionComponent({super.key, required this.pageTitle, required this.collection, required this.route});
  @override
  Widget build(BuildContext context) {
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
                                  route(
                                    snapshot.data!.docs[index]['id'].toString(),
                                    snapshot.data!.docs[index]['name'].toString(),
                                    snapshot.data!.docs.length,
                                  );
                                },
                                //  routeTo(InspectionChapters(standardId:snapshot.data!.docs[index]['id'].toString() ), context: context);
                                // showAlertDialog(context, branches[index].id);

                                child: FutureBuilder<String>(
                                  future: getValue(  snapshot.data!.docs[index]['id'].toString()),
                                  builder: (context, d) {
                                    return Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                      elevation: 0,
                                      color: Colors.white,
                                      child: ListTile(
                                        // leading: CircleAvatar(backgroundColor: Colors.black,radius: 10,),
                                        title: Text(
                                          snapshot.data!.docs[index]['name'],
                                          style:
                                              const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Sblack),
                                        ),
                                        // subtitle: Text(snapshot.data!.docs[index]['userName']),
                                        trailing: d.data == 'true' ? Icon(Icons.check,color: Colors.green,) : const Text(''),
                                      ),
                                    );
                                  },
                                ));
                          });
                    }
                  },
                ))));
  }
  Future<String> getValue(String id) async
{

  return await locator.get<LocalStorageProvider>().retrieveDataByKey(id)??'';
}
}


