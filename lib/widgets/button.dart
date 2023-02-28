import 'package:flutter/material.dart';
import '../constants/color.dart';

class GeneralButton extends StatelessWidget {
  final Function onPressed;
  final BorderRadius borderRadius;
  final Color borderColor;
  final Color splashColor;
  final String buttonText;
  final Color buttonTextColor;
  final bool active;
  GeneralButton(
      {required this.onPressed,
      this.borderRadius = const BorderRadius.all(Radius.circular(10)),
      this.splashColor = butColor,
      required this.buttonText,
      this.buttonTextColor = Colors.white,
      this.borderColor = Colors.transparent,
      this.active = true});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
        //padding: EdgeInsets.all(20),
        height: 50,
        width: deviceWidth,
        child: ElevatedButton(
            child: Text(
              buttonText,
              style: TextStyle(color: buttonTextColor, fontSize: 20),
            ),
            onPressed: () {
              onPressed();
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(butColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: borderRadius,
                    side: BorderSide(color: borderColor),
                  ),
                ))));
  }
}
