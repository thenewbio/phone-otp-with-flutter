import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_otp/screens/home_screen.dart';
import 'package:phone_otp/widgets/button.dart';

import '../constants/color.dart';
import '../widgets/validator.dart';

enum OtpState { showmobileformState, showOtpFormState }

class Loginscreen extends StatefulWidget {
  const Loginscreen({Key? key}) : super(key: key);

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  var currentState = OtpState.showmobileformState;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final otpController = TextEditingController();
  bool passwordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String verificationId;
  bool isLoading = false;

  Widget getMobileFormWidget() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Log in to get started',
            style: TextStyle(
                fontSize: 19, color: lowGrey, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Experience the all new App!',
            style: TextStyle(
                fontSize: 19, color: lowGrey, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 40),
          TextFormField(
            validator: Validators().isEmpty,
            controller: emailController,
            // maxLength: 11,
            decoration: kTextInputForm.copyWith(
              prefixIcon: Image.asset('assets/email.png'),
              hintText: 'deo@gmail.com',
              label: const Text(
                "E-mail ID",
                style: TextStyle(color: lowGrey),
              ),
            ),

            onChanged: (v) {
              setState(() {});
            },
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.black),
            cursorColor: Colors.black,
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            validator: Validators().isEmpty,
            controller: passwordController,
            decoration: kTextInputForm.copyWith(
              prefixIcon: Image.asset('assets/iconno.png'),
              suffixIcon: IconButton(
                icon: Icon(
                  passwordVisible ? Icons.visibility_off : Icons.visibility,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
              hintText: '******',
              label: const Text(
                "Password",
                style: TextStyle(color: lowGrey),
              ),
            ),
            onChanged: (v) {
              setState(() {});
            },
            obscureText: passwordVisible,
            keyboardType: TextInputType.visiblePassword,
            style: const TextStyle(color: Colors.black),
            cursorColor: Colors.black,
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => context.go('/'),
              child: const Text(
                "Use Mobile Number",
                style: TextStyle(color: butColor),
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            child: GeneralButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // _navigationService.navigateTo(bookDeliveryRoute);
                    context.go('/home');
                  }
                },
                buttonText: "Login"),
          )
        ],
      ),
    );
  }

  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: black,
        body: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : getMobileFormWidget()));
  }
}
