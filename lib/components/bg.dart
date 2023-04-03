import 'package:flutter/material.dart';

import '../common/const.dart';

class Background extends StatelessWidget {
  final String title;
  final Widget child;
  final double? childPositionUp;
  final double? childPositionBottom;
  final double? childPositionRight;
  final double? childPositionLeft;
  final bool isBranchScreen;

  const Background({
    super.key,
    required this.child,
    required this.title,
    this.childPositionBottom,
    this.childPositionLeft,
    this.childPositionRight,
    this.childPositionUp,
    this.isBranchScreen=false
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: gray,
          body: Stack(children: [
            Container(
              width: 424,
              height: 204,
              decoration: const BoxDecoration(color: black),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 110),
                child: Row(
                  children: [
                    InkWell(
                      child: const Icon(Icons.arrow_back_ios, color: white),
                      onTap: () {
                        isBranchScreen==false?
                        Navigator.pop(context):false;
                      },
                    ),
                    Text(
                      title,
                      style:
                          const TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Dgreen),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: childPositionBottom,
              top: childPositionUp,
              right: childPositionRight,
              left: childPositionLeft,
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/9),
                child: child,
              ),
            ),
          ])),
    );
  }
}
