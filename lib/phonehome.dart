import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class PhoneHome extends StatefulWidget {
    const PhoneHome({super.key});

    @override
    State<PhoneHome> createState() => _PhoneHomeState();
}

class _PhoneHomeState extends State<PhoneHome> {
    TextEditingController phonenumber = TextEditingController();

    // sendCode() async {
    //     try {
    //         await FirebaseAuth.instance.verifyPhoneNumber(
    //             verificationCompleted: verificationCompleted,
    //             verificationFailed: verificationFailed,
    //             codeSent: codeSent,
    //             codeAutoRetrievalTimeout: codeAutoRetrievalTimeout
    //         );
    //     }
    // }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.white,

            body: ListView(
                shrinkWrap: true,
                children: [
                    Image.asset(
                        'asset/images/cellphone.jpg',
                    ),

                    Center(
                        child: Text(
                            'Phone Number',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lora',
                            ),
                        ),
                    ),

                    Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 25, vertical: 6),
                        child: Text(
                            'An OTP will be sent to your phone',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                            ),
                        ),
                    ),

                    SizedBox(height: 20),

                    // phonetext(),

                    SizedBox(height: 20),

                    // button(),
                ],
            ),
        );
    }
}
