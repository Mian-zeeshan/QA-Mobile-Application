import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:kfccheck/screens/assign_walk/assign_walk.dart';
import 'package:provider/provider.dart';
import '../models/branch_model.dart';
import '../provider/branch_provider.dart';
import '../provider/customer_provider.dart';
import '../provider/globel_provider.dart';
import '../provider/login_provider.dart';
import '../screens/admin/admin_dashboard.dart';
import '../screens/admin/admin_dashboard_screen.dart';
import '../screens/qa_walk.dart';
import '../services/services.dart';
import 'common.dart';
import 'local_storage_provider.dart';
import 'package:collection/collection.dart';

class LocalUser {
  late FirebaseAuth _firebaseAuth;
  late FirebaseFirestore _firebaseFirestore;
  static final LocalUser _instance = LocalUser._internal();

  final List<String> _templatesIdsList = [];
  List<String> get templatesIdsList => _templatesIdsList;

  UserCredential? _user;

  UserCredential? get user => _user;

  dynamic _userData;

  String? _loginUserName;
 String? get loginUserName => _loginUserName;

// set userName(String value) => this._userName = value;


  dynamic get userData => _userData;
  String? _branchName;
  String? _branchCity;
  String? _branchLocation;
  String? get branchName => _branchName;

  String? get branchCity => _branchCity;

  String? get branchLocation => _branchLocation;

  factory LocalUser() {
    _instance._firebaseAuth = FirebaseAuth.instance;
    _instance._firebaseFirestore = FirebaseFirestore.instance;
    return _instance;
  }

  LocalUser._internal();

  Future<void> createUser() async {}

  Future<void> handleLogout() async {
    await locator.get<LocalStorageProvider>().deleteByKey('Email');
    await locator.get<LocalStorageProvider>().deleteByKey('Password');
    _user = null;
    _userData = null;
  }

//Todo:function use for login with firebase
  Future<bool> handleLogin({required String email, required String password, required bool isPasswordSaved}) async {
    try {
      var authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        Fluttertoast.showToast(msg: 'Successfully logged in');

        return true;
      } else {
        Fluttertoast.showToast(msg: 'Incorrect email or password');
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
    return false;
  }

//Todo:function use for  verfy login with firebase  return condition
  Future<bool> verifyUserLoggedIn() async {
    var email = await locator.get<LocalStorageProvider>().retrieveDataByKey('Email');
    var password = await locator.get<LocalStorageProvider>().retrieveDataByKey('Password');
    printDebug('EMail: $email Password: $password');
    if (email != null && password != null) {
      UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (user.user != null) {
        var doc = _firebaseFirestore.collection('users').doc(user.user?.uid);
        _userData = await doc.get();
        return true;
      }
      return false;
    } else {
      return false;
    }
  }

  Future<User?> signInWithEmailPassword(String email, String password, BuildContext context,
      LoginProvider loginProvider, CustomerProvider customerProvider, BranchProvider branchProvider) async {
    await Firebase.initializeApp();
    User? user;

    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

      if (user != null) {
        String userid = user.uid;

        loginProvider.setCurrentUserId(userid);
        _firebaseFirestore.collection('Users').doc(userid).get().then((DocumentSnapshot docs) {
          final data = docs.data() as Map<String, dynamic>;
          String role = data['userRole'];
          String customerId = data['customerId'].toString();
          String userName = data['userName'];
          customerProvider.setcustomerId(customerId);
            _loginUserName=userName;
          loginProvider.setLoginUserName(userName);

          if (role == 'admin') {
            routeTo(const AdminDashboard(), context: context,clearStack: true);
            loginProvider.setIsLogin(false);
            Fluttertoast.showToast(msg: 'sucessfully login');
          } else if (role == 'brancAdminUser') {
            branchProvider.setBranchId(data['branchid'].toString());
            routeTo(const QA_walk(), context: context,clearStack: true);
            loginProvider.setIsLogin(false);

            Fluttertoast.showToast(msg: 'sucessfully login');
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'User not found');
        //showSnackBar(context, 'User not found');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'wrong email & password');
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    }

    return user;
  }

  Future getBranchDetail(String branchId, BranchProvider branchProvider) async {
    //var userProvider = Provider.of<AddUserProvider>(context, listen: false);
    //learbranchDetail();
    await _firebaseFirestore.collection('Branch').doc(branchId).get().then((DocumentSnapshot docs) {
      final data = docs.data() as Map<String, dynamic>;

      branchProvider.setBranchDetail(BranchModel(
          branchName: data['branchName'].toString(),
          branchCity: data['branchCity'].toString(),
          branchLocation: data['branchLocation'].toString()));
    });
  }

  // Future<List<String>> getAssignsTemplatesIdsd(BuildContext context, String userid) async {
  //   var loginProvider = Provider.of<LoginProvider>(context, listen: false);
  //   try {
  //     QuerySnapshot snapshot =
  //         await FirebaseFirestore.instance.collection('AssignmentTemplate').where('assignTo', isEqualTo: userid).get();

  //     for (var element in snapshot.docs) {
  //       String templateId = await element['templateId'];
  //       _templatesIdsList.add(templateId);
  //     }
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }

  //   return _templatesIdsList;
  // }

  String loginUserId(context) {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return loginProvider.crunntUserId.toString();
  }

  String getCurrentDateTime() {
    DateTime now = DateTime.now();
    String nowDate = now.toIso8601String();
    return nowDate;
  }

  Future checkTaskOverDue(String dueTime, String docId) async {
    DateTime dueDate = DateFormat('dd-MM-yyyy hh:mm a').parse(dueTime);

    DateTime currentDate = DateTime.now();

    int result = currentDate.compareTo(dueDate);
    if (result > 0) {
      await _firebaseFirestore.collection('AssignmentTemplate').doc(docId).update({
        'status': 'missed',
      });
    }
  }

  Future getBranchName(context) async {
    //
      var branchProvider = Provider.of<BranchProvider>(context, listen: false);

    String branchName = '';
    await _firebaseFirestore.collection('Branch').doc(branchProvider.branchId).get().then((DocumentSnapshot docs) {
      final data = docs.data() as Map<String, dynamic>;
      String branchName = data['branchName'].toString();
         branchProvider.setBranchName(branchName);
      //String datam=data['customer_name'].toString();
    });
    
  }
}

showSnackBar(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
    message,
  )));
}
