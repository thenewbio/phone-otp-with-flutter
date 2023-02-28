import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/color.dart';
import '../widgets/button.dart';
import '../widgets/validator.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen();

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  late String fcmToken;

  late bool active = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
            child: SizedBox(
          // padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            margin: const EdgeInsets.only(top: 50),
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Register in to get started',
                        style: TextStyle(
                            fontSize: 19,
                            color: lowGrey,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Experience the all new App!',
                        style: TextStyle(
                            fontSize: 19,
                            color: lowGrey,
                            fontWeight: FontWeight.w500),
                      ),
                    ]),
                Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            // validator: Validators().isEmpty,
                            controller: fullNameController,
                            maxLength: 11,
                            decoration: kTextInputForm.copyWith(
                              prefixIcon: Image.asset('assets/person.png'),
                              hintText: 'John',
                              label: const Text(
                                "Name",
                                style: TextStyle(color: lowGrey),
                              ),
                            ),

                            onChanged: (v) {
                              setState(() {});
                            },
                            keyboardType: TextInputType.name,
                            style: const TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
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
                            height: 20,
                          ),
                          TextFormField(
                            validator: Validators().isEmpty,
                            controller: tagController,
                            // maxLength: 11,
                            decoration: kTextInputForm.copyWith(
                              prefixIcon: Image.asset('assets/phone.png'),
                              hintText: '+91',
                              label: const Text(
                                "Mobile Number",
                                style: TextStyle(color: lowGrey),
                              ),
                            ),

                            onChanged: (v) {
                              setState(() {});
                            },
                            keyboardType: TextInputType.name,
                            style: const TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: Validators().isEmpty,
                            controller: passwordController,
                            decoration: kTextInputForm.copyWith(
                              prefixIcon: Image.asset('assets/iconno.png'),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
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
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: Validators().isEmpty,
                            controller: confirmPasswordController,
                            decoration: kTextInputForm.copyWith(
                              prefixIcon: Image.asset('assets/iconno.png'),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  confirmPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    confirmPasswordVisible =
                                        !confirmPasswordVisible;
                                  });
                                },
                              ),
                              hintText: '******',
                              label: const Text(
                                "Confirm Password",
                                style: TextStyle(color: lowGrey),
                              ),
                            ),
                            onChanged: (v) {
                              setState(() {});
                            },
                            obscureText: confirmPasswordVisible,
                            keyboardType: TextInputType.visiblePassword,
                            style: const TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ])),
                const SizedBox(
                  height: 34,
                ),
                Container(
                    // padding: const EdgeInsets.all(20),
                    child: GeneralButton(
                  active: emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty
                      ? true
                      : false,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // _navigationService.navigateTo(bookDeliveryRoute);
                      print('success');
                    }
                  },
                  buttonText: 'REGISTER',
                  splashColor: primaryColor,
                )),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: InkWell(
                      onTap: () => context.go('/login'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Already a member? ',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 15,
                                color: black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )));
  }
}
