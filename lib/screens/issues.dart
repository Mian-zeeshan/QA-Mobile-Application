import 'package:flutter/material.dart';
import 'package:kfccheck/screens/qa_walk.dart';

class Issues extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              'Notes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 550,
                width: 600,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.white, border: Border.all(color: Colors.black)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Assign To',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                          ),
                          Text('---------------------------'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: const [
                          Text(
                            'Notes :',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => QA_walk()));
              },
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
              ),
              color: Color.fromRGBO(43, 45, 66, 1),
            ),
          ],
        ),
      ),
    );
  }
}
