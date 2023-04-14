// import 'package:flutter/material.dart';
// import 'package:kfccheck/common/common.dart';
// import 'package:kfccheck/common/const.dart';
// import 'package:kfccheck/components/qa_scaffold.dart';
// import 'package:kfccheck/screens/login_screen/login_screen.dart';

// class ChooseLogin extends StatefulWidget {
//   const ChooseLogin({Key? key}) : super(key: key);

//   @override
//   State<ChooseLogin> createState() => _ChooseLoginState();
// }

// class _ChooseLoginState extends State<ChooseLogin> {
//   @override
//   Widget build(BuildContext context) {
//     return QaScaffold(
//         child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Center(
//           child: Padding(
//             padding: EdgeInsets.all(50.0),
//             child: Image(
//               image: AssetImage(
//                 'asset/QA-icon.png',
//               ),
//               height: 150,
//               width: 200,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.only(top: 50, left: 17),
//           child: Text(
//             'Welcome Back!',
//             style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: kBoldColor),
//             textAlign: TextAlign.start,
//           ),
//         ),
//         const SizedBox(
//           height: 50,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 17),
//           child: GestureDetector(
//             onTap: (() {
//               routeTo(const LoginScreen(role: 'Admin'), context: context, clearStack: false);
//             }),
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: 50,
//               decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.all(Radius.circular(3)),
//                   color: white,
//                   border: Border.all(color: lGrey)),
//               child: Row(
//                 children: const [
//                   Padding(
//                     padding: EdgeInsets.only(left: 10),
//                     child: Image(image: AssetImage('asset/admin img.png')),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     'Log In as Admin',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: DBlack),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 17),
//           child: GestureDetector(
//             onTap: (() {
//               routeTo(const LoginScreen(role: 'Team Member'), context: context, clearStack: false);
//             }),
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: 50,
//               decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.all(Radius.circular(3)),
//                   color: white,
//                   border: Border.all(color: lGrey)),
//               child: Row(
//                 children: const [
//                   Padding(
//                     padding: EdgeInsets.only(left: 10),
//                     child: Image(image: AssetImage('asset/team member img.png')),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     'Log In as Team Member',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: DBlack),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     ));
//   }
// }
