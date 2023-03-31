import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kfccheck/provider/branch_provider.dart';
import 'package:kfccheck/provider/customer_provider.dart';
import 'package:kfccheck/provider/globel_provider.dart';
import 'package:kfccheck/provider/login_provider.dart';
import 'package:kfccheck/services/services.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen/splash_screen.dart';

List<CameraDescription>? cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initServices();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GlobelProvider(),
        ),
ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
ChangeNotifierProvider(
          create: (context) => BranchProvider(),
        ),
ChangeNotifierProvider(
          create: (context) => CustomerProvider(),
        ),

      ],
      //create: (context) => InspectionBloc(),
      child: MaterialApp(
        title: 'KFC Inspection',
        theme: ThemeData(
          fontFamily: 'SofiaPro',
          primarySwatch: Colors.red,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
