import 'package:flutter/material.dart';
import 'package:fitst_app/home_page.dart';
import 'package:fitst_app/login_page.dart';
import 'package:fitst_app/sign_up_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/sign_up': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
