import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phone_otp/screens/home_screen.dart';
import 'package:phone_otp/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phone OTP',
      theme: ThemeData(primarySwatch: Colors.pink, accentColor: Colors.purple),
      home: const Loginscreen(),
    );
  }
}

class Initial extends StatefulWidget {
  const Initial({Key? key}) : super(key: key);

  @override
  State<Initial> createState() => _InitialState();
}

class _InitialState extends State<Initial> {
  late FirebaseAuth _auth;
  late User _user;
  bool isLoading = true;
  @override
  void initState() {
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser!;
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : _user == null
            ? Loginscreen()
            : HomeScreen();
  }
}
