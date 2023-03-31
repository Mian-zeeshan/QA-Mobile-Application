import 'package:flutter/material.dart';
import 'package:kfccheck/components/bg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../common/const.dart';
import 'inspection_screen/inspection_areas.dart';

class Anomalies extends StatefulWidget {
  @override
  State<Anomalies> createState() => _Anomalies();
}

class _Anomalies extends State<Anomalies> {
  final TextEditingController nameController = TextEditingController();
  List<String> answers = ['Yes', 'No'];
  int groupValue = -1;
  bool? check1 = false;
  bool? check2 = false;
  bool? check3 = false;
  bool? check4 = false;

  @override
  Widget build(BuildContext context) {
    return Background(
      title: 'Anomalies',
      child: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: Container(
          width: double.infinity,
          decoration:const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),color: gray),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    height: 241,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Center(
                            child: CircularPercentIndicator(
                              radius: 40,
                              lineWidth: 20.0,
                              percent: 0.7,
                              animation: true,
                              backgroundColor: lightgray,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: GREEN,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 156,
                decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)),color: white),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20,left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Type of Anomaly:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Sblack),),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('Reported By:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Sblack)),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                         const Text('Action Taken',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Sblack)),
                          Checkbox( //only check box
                              value: check1,
                              activeColor: GREEN,//unchecked
                              onChanged: (bool? value){
                                //value returned when checkbox is clicked
                                setState(() {
                                  check1 = value;
                                  check2 = false;
                                });
                              }
                          ),
                         const Text('YES',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Black),
                          ),
                          Checkbox( //only check box
                              value: check2,
                              activeColor: GREEN,//unchecked
                              onChanged: (bool? value){
                                //value returned when checkbox is clicked
                                setState(() {
                                  check2 = value;
                                  check1 = false;

                                });
                              }
                          ),
                         const Text('NO',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 156,
                decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)),color: white),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20,left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const  Text('Type of Anomaly:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Sblack),),
                    const  SizedBox(
                        height: 15,
                      ),
                     const Text('Reported By:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Sblack)),
                     const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                         const Text('Action Taken',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Sblack)),
                          Checkbox( //only check box
                              value: check3,
                              activeColor: GREEN,//unchecked
                              onChanged: (bool? value){
                                //value returned when checkbox is clicked
                                setState(() {
                                  check3 = value;
                                  check4 = false;
                                });
                              }
                          ),
                         const Text('YES',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Black),
                          ),
                          Checkbox( //only check box
                              value: check4,
                              activeColor: GREEN,//unchecked
                              onChanged: (bool? value){
                                //value returned when checkbox is clicked
                                setState(() {
                                  check4 = value;
                                  check3 = false;
                                });
                              }
                          ),
                         const Text('NO',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
      );
  }
}
