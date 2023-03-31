import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pref extends StatefulWidget {
  const Pref({super.key});

  @override
  State<Pref> createState() => _PrefState();
}

class _PrefState extends State<Pref> {
  SharedPreferences? preferences;
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      preferences = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              preferences?.getString('userName') ?? '',
            ),
            const SizedBox(
              height: 15,
            ),
            Divider(),
            Text(
              preferences?.getString('password') ?? '',
            ),
          ],
        ),
      ),
    );
  }
}
