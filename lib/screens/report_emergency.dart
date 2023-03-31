import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kfccheck/common/const.dart';
import 'package:kfccheck/screens/roles.dart';

var emergencySend;

class Report extends StatefulWidget {
  Report({super.key});

  @override
  State<Report> createState() => _Report();
}

class _Report extends State<Report> {
  List<String> emergencies = [
    'Unavailibility of water and alternate resource.',
    'No working restroom.',
    'Sewage backup in the resturant.',
    'No hot water(if it cant be restored in 1 hour).',
    'No electricity.',
    'Rodent,Flies, or cockroach infestation,',
  ];
  List<int> answers = [
    1,
    2,
    3,
    4,
    5,
    6,
  ];
  int groupValue = -1;
  bool isfalse = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                Container(
                  width: 424,
                  height: 204,
                  decoration: const BoxDecoration(color: kala),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 40),
                    child: Row(
                      children: [
                        InkWell(
                          child: const Icon(Icons.arrow_back_ios, color: white),
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin()));
                          },
                        ),
                        const Text(
                          'Report Emergency',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Dgreen),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: Container(
                      width: 424,
                      height: 687,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        color: gray,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: emergencies.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Card(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                        elevation: 5,
                                        color: Colors.white,
                                        child: ListTile(
                                          title: Text(emergencies[index]),
                                          trailing: Radio<int>(
                                            value: answers[index]!,
                                            groupValue: groupValue,
                                            onChanged: (value) {
                                              setState(() {
                                                groupValue = value!;
                                              });
                                              emergencySend = emergencies[index];
                                              print("emergency == $emergencySend");
                                              Timer(
                                                  Duration(seconds: 1),
                                                  () => groupValue != -1
                                                      ? Navigator.push(context, MaterialPageRoute(builder: (context) => Roles()))
                                                      : Container());
                                            },
                                          ),
                                        )),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
