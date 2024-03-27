import 'dart:ui';
import 'package:flutter_application_1/login_screen.dart';
import 'package:flutter_application_1/screens/create_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/homepage.dart';

void main() {
  runApp(const LoginAccount());
}

class LoginAccount extends StatelessWidget {
  const LoginAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "E-MARISTA",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ToLoginPage(),
    );
  }
}

class ToLoginPage extends StatefulWidget {
  const ToLoginPage({Key? key}) : super(key: key);

  @override
  LoginPage createState() => LoginPage();
}
