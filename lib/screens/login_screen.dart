import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_otp/screens/home_screen.dart';

enum OtpState { showmobileformState, showOtpFormState }

class Loginscreen extends StatefulWidget {
  const Loginscreen({Key? key}) : super(key: key);

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  var currentState = OtpState.showmobileformState;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String verificationId;
  bool isLoading = false;

  Widget getMobileFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: phoneController,
          decoration: InputDecoration(hintText: 'Phone Number'),
        ),
        SizedBox(
          height: 16,
        ),
        TextButton(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              await _auth.verifyPhoneNumber(
                  phoneNumber: phoneController.text,
                  verificationCompleted: (phoneAuthCredential) async {
                    setState(() {
                      isLoading = false;
                    });
                  },
                  verificationFailed: (phoneVerificationFailed) async {
                    setState(() {
                      isLoading = false;
                    });
                    _scaffoldKey.currentState!.showSnackBar(SnackBar(
                        content: Text(phoneVerificationFailed.message!)));
                  },
                  codeSent: (verificationId, resendingToken) async {
                    setState(() {
                      isLoading = false;
                      currentState = OtpState.showOtpFormState;
                      this.verificationId = verificationId;
                    });
                  },
                  codeAutoRetrievalTimeout: (verificationId) async {});
            },
            child: Text('Send')),
        Spacer(),
      ],
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: otpController,
          decoration: InputDecoration(hintText: 'Enter OTP'),
        ),
        SizedBox(
          height: 16,
        ),
        TextButton(
            onPressed: () async {
              final phoneAuthCredential = PhoneAuthProvider.credential(
                  verificationId: verificationId, smsCode: otpController.text);
              signInWithPhone(phoneAuthCredential);
            },
            child: Text('Verify')),
        Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
            padding: EdgeInsets.all(50),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : currentState == OtpState.showmobileformState
                    ? getMobileFormWidget(context)
                    : getOtpFormWidget(context)));
  }

  void signInWithPhone(PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      isLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        isLoading = false;
      });
      if (authCredential.user != null) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      _scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }
}
