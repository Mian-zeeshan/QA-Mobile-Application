import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kfccheck/common/common.dart';
import 'package:kfccheck/common/user.dart';
import 'package:kfccheck/screens/intro_screen/intro_screen.dart';
import 'package:kfccheck/screens/qa_walk.dart';

import '../../common/local_storage_provider.dart';
import '../../services/services.dart';
import '../choose_login_screen/choose_login_screen.dart';
import '../login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    verify();
  }

  Future<void> verify() async {
    try{
    var isLoggedIn = await locator.get<LocalUser>().verifyUserLoggedIn();
    if (isLoggedIn) {
      var data = locator.get<LocalUser>().userData;
      if (data['isApproved']) {
        routeTo(const QA_walk(), context: context, clearStack: true);
      }
    } else {
      await Future.delayed(const Duration(milliseconds: 700));
      String? appInitiated = await locator
          .get<LocalStorageProvider>()
          .retrieveDataByKey('appInitiated');
      routeTo(
          appInitiated == 'true' ? const LoginScreen() : const IntroScreen(),
          context: context,
          clearStack: true);
    }
    } catch(e) {
      Fluttertoast.showToast(msg: "Something went wrong! Try Restarting app!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image.asset('asset/QAA.png'),
    ));
  }
}
