import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:opinion/auth/auth.dart';
import 'package:opinion/auth/login_or_register.dart';
import 'package:opinion/pages/login_page.dart';
import 'package:opinion/pages/register_page.dart';
import 'package:opinion/themes/dark_theme.dart';
import 'package:opinion/themes/light_theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: AuthPage(),
    );
  }
}

