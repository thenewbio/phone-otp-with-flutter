import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_otp/provider/auth_provider.dart';
import 'package:phone_otp/screens/home_screen.dart';
import 'package:phone_otp/screens/login_screen.dart';
import 'package:phone_otp/screens/register_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyD-sPNOLZ3Eq19o9MxTTlX4wklPmlD_rNo",
            authDomain: "otp-verify-5a3f1.firebaseapp.com",
            projectId: "otp-verify-5a3f1",
            storageBucket: "otp-verify-5a3f1.appspot.com",
            messagingSenderId: "267236222449",
            appId: "1:267236222449:web:41a50189b6d713d98a9050"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return RegisterScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const Loginscreen();
          },
        ),
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Phone OTP',
        theme:
            ThemeData(primarySwatch: Colors.pink, accentColor: Colors.purple),
        routerConfig: _router,
      ),
    );
  }
}
