import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kfccheck/common/const.dart';

class ListofUser extends StatefulWidget {
  ListofUser({super.key});
  @override
  State<ListofUser> createState() => _ListofUser();
}

class _ListofUser extends State<ListofUser> {
  final _formKey = GlobalKey<FormState>();

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phonenumberController = TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phonenumberController.dispose();
  }

  clearText() {
    firstnameController.clear();
    lastnameController.clear();
    emailController.clear();
    passwordController.clear();
    phonenumberController.clear();
  }

  bool isLoading = false;

  CollectionReference User = FirebaseFirestore.instance.collection('users');

  Future addUser() async {
    setState(() {
      isLoading = true;
    });
    UserCredential user = await firebaseAuth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    await User.doc(user.user?.uid).set({
      'firstName': firstnameController.text,
      'lastName': lastnameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'phonenumber': phonenumberController.text,
      'isApproved': true,
      'role': 'teammember'
    });
    var email = await secureStorage.read(key: 'Email');
    var password = await secureStorage.read(key: 'Password');
    if (email != null && password != null) {
      firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    User.get();
    User.snapshots();
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 164,
                  width: MediaQuery.of(context).size.width,
                  color: black,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Text(
                      'Users List',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Dgreen),
                    ),
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16)), color: grayish),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Search',
                                  hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: lGrey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
