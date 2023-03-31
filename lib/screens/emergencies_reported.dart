import 'package:flutter/material.dart';
import 'package:kfccheck/components/bg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../common/const.dart';
import 'inspection_screen/inspection_areas.dart';

class Emergencies extends StatefulWidget {
  @override
  State<Emergencies> createState() => _Emergencies();
}

class _Emergencies extends State<Emergencies> {
  final TextEditingController nameController = TextEditingController();
  List<String> inspect = [
    'Type of Emergency =',
    'Reported to =',
    'Actions Taken=',
  ];

  @override
  Widget build(BuildContext context) {
    return Background(
        title: 'Emergencies',
        child:Padding(
          padding: const EdgeInsets.only(top: 120),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),color: gray),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      width:340,
                      height: 156,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          color: white),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Type of Emergency:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Sblack),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text('Reported to:',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Sblack)),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Action Taken:',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Sblack)),
                          ],
                        ),
                      ),
                    ),
                  ),
                 const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 156,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: white),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Type of Emergency:',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Sblack),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text('Reported to:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Sblack)),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Action Taken:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Sblack)),
                        ],
                      ),
                    ),
                  )
                ])),

          ),
        ),
    );
  }
}
