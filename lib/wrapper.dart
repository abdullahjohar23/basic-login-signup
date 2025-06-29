import 'package:flutter/material.dart';
import 'package:basic_login_signup/login.dart';
import 'package:basic_login_signup/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatefulWidget {
    const Wrapper({super.key});

    @override
    State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
    @override
    Widget build(BuildContext context) {
        return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
                if (snapshot.hasData) {
                    return HomePage();
                } else {
                    return LoginPage();
                }
            }
        );
    }
}
