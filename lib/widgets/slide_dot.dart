import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots(this.isActive, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 15 : 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.brown : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
