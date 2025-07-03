import 'package:basic_login_signup/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Verifymail extends StatefulWidget {
    const Verifymail({super.key});

    @override
    State<Verifymail> createState() => _VerifymailState();
}

class _VerifymailState extends State<Verifymail> {
    @override
    void initState() {
        sendVerifyLink();
        super.initState();
    }

    sendVerifyLink() async {
        final user = FirebaseAuth.instance.currentUser!;
        await user.sendEmailVerification().then((value) {
            Get.snackbar(
                'Link Sent', // Title
                'A link has been sent to your gmail', // Message
                margin: EdgeInsets.all(30),
                snackPosition: SnackPosition.BOTTOM,
            );
        });
    }

    reload() async {
        await FirebaseAuth.instance.currentUser!.reload().then((value) {
            Get.offAll(Wrapper());
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Padding(
                padding: EdgeInsets.all(28),

                child: Center(
                    child: Text(
                        // https://mail.google.com/mail/u/0/#inbox
                        'Open your mail and click the link provided to verify mail and reload this page',
                        style: TextStyle(
                            color: Color(0xff7c71b2),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                ),
            ),

            floatingActionButton: Padding(
              padding: const EdgeInsets.only(right: 15, bottom: 25),
                child: FloatingActionButton(
                    onPressed: (() => reload()),
                    child: Icon(Icons.restart_alt_rounded),
                ),
            ),
        );
    }
}
