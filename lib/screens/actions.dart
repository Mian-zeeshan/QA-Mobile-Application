import 'package:flutter/material.dart';
import 'package:kfccheck/components/bg.dart';
import '../common/const.dart';
import 'inspection_screen/inspection_areas.dart';

class ActionScreen extends StatefulWidget {
  @override
  State<ActionScreen> createState() => _ActionScreenState();
}

class _ActionScreenState extends State<ActionScreen> {
  final TextEditingController nameController = TextEditingController();
  List<String> inspect = [
    'Total Actions=',
    'Completed Actions=',
    'Open Actions=',
  ];
  List<int> answerss = [
    1,
    2,
    3,
  ];
  int groupValue = -1;
  bool isfalse = false;

  @override
  Widget build(BuildContext context) {
    return Background(
      title: 'Actions',
      child: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)), color: gray),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    width: 424,
                    height: 200,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                      color: Colors.white,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              inspect[0],
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Sblack),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              inspect[1],
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Sblack),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              inspect[2],
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Sblack),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
