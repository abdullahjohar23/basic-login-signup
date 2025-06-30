import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:basic_login_signup/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:basic_login_signup/firebase_options.dart';

Future<void> main() async {
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
        return GetMaterialApp( // to use 'get', we need to change 'MaterialApp' to 'GetMaterialApp'
            debugShowCheckedModeBanner: false,
            home: LoginPage(),
        );
    }
}
