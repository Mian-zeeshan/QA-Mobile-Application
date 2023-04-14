import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kfccheck/common/common.dart';
import 'package:kfccheck/common/const.dart';
import 'package:kfccheck/common/user.dart';
import 'package:kfccheck/components/global_button.dart';
import 'package:kfccheck/components/qa_scaffold.dart';
import 'package:kfccheck/models/roles_enum.dart';
import 'package:kfccheck/screens/assign_walk/assign_walk.dart';
import 'package:kfccheck/screens/qa_walk.dart';
import 'package:kfccheck/screens/sign_up_screen.dart';
import 'package:kfccheck/services/services.dart';
import 'package:provider/provider.dart';

import '../../provider/branch_provider.dart';
import '../../provider/customer_provider.dart';
import '../../provider/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool isShow = false;
  bool check = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late FirebaseAuth _firebaseAuth;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    var customerProvider = Provider.of<CustomerProvider>(context, listen: false);
    var branchProvider = Provider.of<BranchProvider>(context, listen: false);
    return QaScaffold(
        button: Column(
          children: [
            Consumer<LoginProvider>(
              builder: (context, loginProvider, child) {
                return loginProvider.isLogin == true
                    ? const CircularProgressIndicator()
                    : GlobalButton(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            var localUserHandler = locator.get<LocalUser>();
                            loginProvider.setIsLogin(true);

                            await localUserHandler
                                .signInWithEmailPassword(nameController.text, passwordController.text, context,
                                    loginProvider, customerProvider, branchProvider)
                                .then((value) {
                              loginProvider.setIsLogin(false);
                            });
                          }
                        },
                        title: 'Login');
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(color: lGrey),
                ),
                TextButton(
                    onPressed: () {
                      routeTo(const SignUpScreen(), context: context);
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(color: black),
                    ))
              ],
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                SizedBox(height: 20),
                Row(
                  children: const [
                    Text(
                      'Welcome Back!',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: kBoldColor),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Text('Enter your account details.',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: lGrey)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                        hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: lGrey),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter UserName';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: !isShow,
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
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: check,
                          onChanged: (value) {
                            setState(() {
                              check = value ?? false;
                            });
                          },
                        ),
                        const Text(
                          'Keep me logged in',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: lGrey),
                        ),
                        const Spacer(),
                        const Text(
                          'Forgot Password?',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kBoldColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ));
  }
}
