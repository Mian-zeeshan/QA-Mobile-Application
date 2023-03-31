import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kfccheck/common/common.dart';
import 'package:kfccheck/common/const.dart';
import 'package:kfccheck/common/user.dart';
import 'package:kfccheck/components/global_button.dart';
import 'package:kfccheck/components/qa_scaffold.dart';
import 'package:kfccheck/models/roles_enum.dart';
import 'package:kfccheck/screens/branches/branches.dart';
import 'package:kfccheck/screens/qa_walk.dart';
import 'package:kfccheck/screens/sign_up_screen.dart';
import 'package:kfccheck/services/services.dart';

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


  // userLogin() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var localUserHandler = locator.get<LocalUser>();
  //   var isLoggedIn = await localUserHandler.handleLogin(
  //       email: nameController.text, password: passwordController.text, isPasswordSaved: check);
  //   if (isLoggedIn) {
  //     Roles role = getRoleById(localUserHandler.userData['roleId']);
  //     routeTo(const QA_walk(), context: context, clearStack: true);
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

//   Future userLogin( String email,String password) async{


// try{
//   // setState(() {
//   //   isLoading = true;
//   // });
//   var authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
//   //await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);


//   if(authResult.user !=null){
   
//     // setState(() {
//     //   isLoading = false;
//     // });
//     //routeTo(const QA_walk(), context: context, clearStack: true);
    
//     // ignore: use_build_context_synchronously
//     routeTo( Branches(), context: context, clearStack: true);
  
  
//   }
//   else{
  
//   }
// }
// catch(e){
//   print(e.toString()+'dhvndvvfvsdnbfv jevbjhgbgb');
// }



//   }

 
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return QaScaffold(
      button: Column(
        children: [
          isLoading
              ? const CircularProgressIndicator()
              : GlobalButton(
                  onTap: ()async {
                    // setState(() {
                    //   isLoading = true;
                    // });

                    if (formKey.currentState!.validate()) {
                       var localUserHandler = locator.get<LocalUser>();
                       
                     await   localUserHandler.signInWithEmailPassword(nameController.text, passwordController.text, context).then((value) {

                      localUserHandler.showSnackBar(context, 'sucessfully login');
                     
                     });

                  //  await   userLogin(nameController.text,passwordController.text).then((value) {
                  //    // setState(() {
                  //    //   isLoading = false;
                  //    // });
                  //    var localUserHandler = locator.get<LocalUser>();
                  //    localUserHandler.showSnackBar(context, 'sucessfully created');

                  //  });
                      // try{
                      //   // setState(() {
                      //   //   isLoading = true;
                      //   // });
                      //   // var authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                      //   await FirebaseAuth.instance.createUserWithEmailAndPassword(email: nameController.text, password: passwordController.text).then((value) {
                      //     print(value);
                      //     Fluttertoast.showToast(msg: 'create user sucessfully ');
                      //   });
                      //
                      //   // if(authResult.user !=null){
                      //   //   Fluttertoast.showToast(msg: 'Successfully logged in');
                      //   //   setState(() {
                      //   //     isLoading = false;
                      //   //   });
                      //   //   routeTo(const QA_walk(), context: context, clearStack: true);
                      //   //
                      //   //
                      //   // }
                      //   // else{
                      //   //   Fluttertoast.showToast(msg: 'wrong emial and password ');
                      //   //
                      //   // }
                      // }catch(e){
                      //   print(e.toString()+'dhvndvvfvsdnbfv jevbjhgbgb');
                      // }
                    }
                  },
                  title: 'Login'),
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
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.only(top: 60),
                child: Image(
                  image: AssetImage(
                    'asset/QA-icon.png',
                  ),
                  height: 150,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 60),
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
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                        hintStyle:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: lGrey),
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
                          hintStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400, color: lGrey),
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
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500, color: kBoldColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
