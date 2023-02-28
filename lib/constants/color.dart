import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

const Color primaryColor = Color(0xfffffff);
const Color lowGrey = Color(0xFF7C7C7C);
const Color butColor = Color.fromRGBO(255, 178, 54, 1);
const Color black = Color(0xFF000000);
const kTextInputForm = InputDecoration(
  hintText: '',
  label: Text(
    "",
    style: TextStyle(color: lowGrey),
  ),
  hintStyle: TextStyle(
    color: lowGrey,
  ),
  labelStyle: TextStyle(color: black),
);
