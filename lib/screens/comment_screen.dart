import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  Timer? _timer;
  @override
  void initState() {
    setState(() {});

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final commentController = TextEditingController();
  final replyCommentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [

          Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: 1,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, postIndex) {
                      return Column(
                        children: [],
                      );
                    }),
              ),
              SizedBox(
                height: 200,
              ),
            ],
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 5,
                child: Container(
                  height: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        leading: Container(
                          height: 40,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCImG4nIo_-jn5_eFrduYg9F-YxhPA9dsr0lF4XVOGlvTH5_zUblU73zFJlRkqiknCao8&usqp=CAU",
                              ),
                              //   fit: BoxFit.fill
                            ),
                          ),
                        ),
                        title: TextFormField(
                          controller: commentController,
                          decoration: new InputDecoration(
                              hintText: 'Write a Comment',
                              suffixIcon: GestureDetector(
                                onTap: (){
                                  Fluttertoast.showToast(msg: 'Comment successfully');
                                },
                                child: Icon(
                                  Icons.send,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              )),
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          minLines: 1,

                          ///  maxLines: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
