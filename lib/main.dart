import 'package:flutter/material.dart';
import 'package:recycle_me/admin/admin_approval.dart';
import 'package:recycle_me/admin/admin_login.dart';
import 'package:recycle_me/admin/admin_reedem.dart';
import 'package:recycle_me/pages/bottomnav.dart';
import 'package:recycle_me/pages/home.dart';
import 'package:recycle_me/pages/login.dart';
import 'package:recycle_me/pages/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recycle_me/pages/upload_item.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LogIn(),
    );
  }
}

