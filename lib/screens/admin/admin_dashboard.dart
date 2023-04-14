import 'package:flutter/material.dart';
import 'package:kfccheck/common/const.dart';
import 'package:kfccheck/screens/actions.dart';
import 'package:kfccheck/screens/admin/admin_dashboard_screen.dart';
import 'package:kfccheck/screens/anomalies.dart';
import 'package:kfccheck/screens/report_emergency.dart';
class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}
class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;
  List<Widget> pages = [
  AdminDashboardScreen(),
     Report(),
    ActionScreen(),
     Anomalies(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
        body: Center(
          child: pages[_currentIndex],
        ),
        bottomNavigationBar: 
        NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
          child: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (int newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            },
            destinations: const [
               NavigationDestination(
                icon: Icon(Icons.home,size: 25,),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.warning_amber_sharp,color: black,size: 25,),
                label: 'Emergencies',
              ),
              NavigationDestination(
               icon: ImageIcon(AssetImage('asset/actions.png'),size: 25,color: Colors.black),
                label: 'Actions',
              ),
              NavigationDestination(

                icon: ImageIcon(AssetImage('asset/anomalies.png'),size: 25,),
                label: 'Anomalies',
              ),
            ],
          ),
        ));
  }
}