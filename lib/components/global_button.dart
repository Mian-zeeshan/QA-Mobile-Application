import 'package:flutter/material.dart';

import '../common/const.dart';

class GlobalButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  const GlobalButton({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: black),
          child: Center(
              child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: yellow))),
        ));
  }
}
