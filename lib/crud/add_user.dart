import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kfccheck/common/const.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final createdOnController = TextEditingController();
  final createdByController = TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    createdOnController.dispose();
    createdByController.dispose();
  }

  clearText() {
    nameController.clear();
    passwordController.clear();
    emailController.clear();
    createdOnController.clear();
    createdByController.clear();
  }

  bool isLoading = false;

  CollectionReference User = FirebaseFirestore.instance.collection('users');

  Future addUser() async {
    setState(() {
      isLoading = true;
    });
    UserCredential user = await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    await User.doc(user.user?.uid).set({
      'firstName': nameController.text,
      'email': emailController.text,
      'createdOn': createdOnController.text,
      'createdBy': createdByController.text,
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

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(children: [
              Stack(children: [
                Container(
                  height: 204,
                  width: 414,
                  decoration: const BoxDecoration(color: black),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Text(
                      'User',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Dgreen),
                    ),
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Container(
                      height: 640,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(19)),
                          color: grayish),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 15, right: 15),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Name',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 55,
                                width: 339,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    color: white,
                                    border: Border.all(color: white)),
                                child: TextFormField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    hintText: 'Name',
                                    hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: lGrey),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Email',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 55,
                                width: 339,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    color: white,
                                    border: Border.all(color: white)),
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: lGrey),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Last Name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Created On',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 55,
                                width: 339,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    color: white,
                                    border: Border.all(
                                        color:
                                            Color.fromRGBO(239, 235, 235, 1))),
                                child: TextFormField(
                                  controller: createdOnController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    hintText: 'Created On',
                                    hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: lGrey),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Created By',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 55,
                                width: 339,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Color.fromRGBO(239, 235, 235, 1),
                                  ),
                                ),
                                child: TextFormField(
                                  controller: createdByController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    hintText: 'Created By',
                                    hintStyle: TextStyle(color: lGrey),
                                    constraints: BoxConstraints.tightFor(
                                      width: 80,
                                      height: 100,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                      color: black),
                                  child: const Center(
                                    child: Text(
                                      'Add User',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                          color: Dgreen),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    addUser();
                                  }
                                },
                              ),
                            ]),
                        // Spacer(key:key ,flex: 1),
                      ),
                    ),
                  ),
                ),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}
