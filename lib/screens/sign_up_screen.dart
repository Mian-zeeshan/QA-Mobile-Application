import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kfccheck/common/common.dart';
import 'package:kfccheck/common/const.dart';
import 'package:kfccheck/common/local_storage_provider.dart';
import 'package:kfccheck/components/global_button.dart';
import 'package:kfccheck/components/qa_scaffold.dart';
import 'package:kfccheck/models/roles_enum.dart';
import 'package:kfccheck/services/services.dart';

import 'approval_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firbeaseAuth = FirebaseAuth.instance;
  final _firebaseStore = FirebaseFirestore.instance;
  bool isLoading = false;
  bool isShow = false;
  bool check = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void saveDetails() async {
    await locator.get<LocalStorageProvider>().saveByKey("Password", data: passwordController.text);
    await locator.get<LocalStorageProvider>().saveByKey("Email", data: emailController.text);
  }

  registerEmail() async {
    setState(() {
      isLoading = true;
    });
    try {
      UserCredential? user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      printDebug(user);
      if (user.user != null) {
        saveDetails();
        var docRef = _firebaseStore.collection('users').doc(user.user?.uid);
        docRef.set({
          'docId': user.user?.uid,
          'roleId': getRoleIdByEnum(Roles.admin),
          'isApproved': false,
          'firstName': nameController.text,
          'lastName': lastNameController.text,
        });
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: 'Sign up Successfully');
        routeTo(const ApprovalAwaitPage(), context: context, clearStack: true);
      }
    } catch (e) {
      printDebug(e.toString());
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: 'Some Error: $e');
    }
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return QaScaffold(
      button: Column(
        children: [
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GlobalButton(
                  title: 'Sign Up',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      registerEmail();
                    }
                  },
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Already have an account?",
                style: TextStyle(color: lGrey),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(color: black),
                  ))
            ],
          )
        ],
      ),
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Form(
              key: formKey,
              child: Column(children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Image(
                    image: AssetImage(
                      'asset/QA-icon.png',
                    ),
                    height: 150,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  'Sign Up!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: kBoldColor),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                        hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: lGrey),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter UserName';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'First Name',
                        hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: lGrey),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter First Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: lastNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Last Name',
                        hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: lGrey),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Last Name';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: isShow,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Password',
                          hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: lGrey),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isShow = !isShow;
                                });
                              },
                              child: Icon(isShow ? Icons.visibility : Icons.visibility_off))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter password';
                        }
                      },
                    ),
                  ],
                ),
              ]),
            )),
      ),
    );
  }
}
