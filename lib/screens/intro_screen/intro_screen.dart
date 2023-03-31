import 'package:flutter/material.dart';
import 'package:kfccheck/common/common.dart';
import 'package:kfccheck/components/qa_scaffold.dart';
import 'package:kfccheck/screens/login_screen/login_screen.dart';

import '../../common/const.dart';
import '../../common/local_storage_provider.dart';
import '../../services/services.dart';
import '../choose_login_screen/choose_login_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QaScaffold(
        child: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(image: AssetImage('asset/QAA.png')),
                  Expanded(
                    child: Text(
                      'Quality is a trait that we navigate',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'sofiapro'),
                    ),
                  ),
                ]),
          ),
          Positioned(
            bottom: 0,
            child: Image(
              width: MediaQuery.of(context).size.width,
              image: const AssetImage('asset/rectangle.png'),
              fit: BoxFit.cover,
            ),
          ),
          const Positioned(
            left: 50,
            bottom: 170,
            child: Image(image: AssetImage('asset/Mask_group.png')),
          ),
          Positioned(
            bottom: 70,
            right: 20,
            child: Padding(
              padding: const EdgeInsets.only(left: 200, top: 696),
              child: GestureDetector(
                child: Row(
                  children: const [
                    Text(
                      'Get Started',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: black),
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                ),
                onTap: () async {
                  bool? appInitiated = await locator.get<LocalStorageProvider>().retrieveDataByKey('appInitiated');
                  appInitiated ?? false
                      ? null
                      : await locator.get<LocalStorageProvider>().saveByKey('appInitiated', data: 'true');
                  routeTo(const LoginScreen(), context: context);
                },
              ),
            ),
          )
        ],
      ),
    ));
  }
}
