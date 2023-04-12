import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/const.dart';
import '../common/user.dart';
import '../provider/branch_provider.dart';
import '../services/services.dart';
import 'bottom_navbar.dart';

class Background extends StatelessWidget {
  final String title;
  final Widget child;
  final double? childPositionUp;
  final double? childPositionBottom;
  final double? childPositionRight;
  final double? childPositionLeft;
  final bool isBranchScreen;
  //final Widget? bottomNavBar;

  Background({
    super.key,
    required this.child,
    required this.title,
    this.childPositionBottom,
    this.childPositionLeft,
    this.childPositionRight,
    this.childPositionUp,
    this.isBranchScreen = false,
    // this.bottomNavBar
  });

  @override
  Widget build(BuildContext context) {
    var branchProvider = Provider.of<BranchProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: isBranchScreen
              ? CustomBottomNavBar(
                  selectedIndex: 0,
                  onTabChanged: (index) {
                    branchProvider.setWalkPagesIndex(index);
                    
                     
                  },
                  navItems: [
                      NavigationDestination(
                        selectedIcon: Image.asset("asset/alltask.png", color: Colors.white, height: 27),
                        //  selectedIcon: SvgPicture.asset('assets/images/home.png'),

                        icon: Image.asset(
                          "asset/alltask.png",
                          color: Colors.grey,
                          height: 25,
                        ),
                        label: 'All',
                      ),
                      NavigationDestination(
                        selectedIcon: Image.asset("asset/pending.png", color: Colors.white, height: 27),
                        icon: Image.asset(
                          "asset/pending.png",
                           color: Colors.grey,
                          height: 25,
                        ),
                        label: 'Missed',
                      ),
                      NavigationDestination(
                        selectedIcon: Image.asset("asset/completed.png", color: Colors.white, height: 27),
                        icon: Image.asset(
                           color: Colors.grey,
                          "asset/completed.png",
                          height: 25,
                        ),
                        label: 'Completed',
                      ),
                    ])
              : null,
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
                        isBranchScreen == false ? Navigator.pop(context) : false;
                      },
                    ),
                    Text(
                      title,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Dgreen),
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
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 9),
                child: child,
              ),
            ),
            // Positioned(
            //   bottom: 0,

            //   child: bottomNavBar ??Container(width: 50,height: 50,color: Colors.black,))
          ])),
    );
  }
}
