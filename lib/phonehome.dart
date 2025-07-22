import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:basic_login_signup/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneHome extends StatefulWidget {
    const PhoneHome({super.key});

    @override
    State<PhoneHome> createState() => _PhoneHomeState();
}

class _PhoneHomeState extends State<PhoneHome> {
    TextEditingController phonenumber = TextEditingController();

    Future<void> sendCode() async {
        try {
            await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: '+88${phonenumber.text}',
                verificationCompleted: (PhoneAuthCredential credential) {},
                verificationFailed: (FirebaseAuthException e) {
                    Get.snackbar('Error Occured', e.code);
                },

                codeSent: (String vid, int? token) { // vid means verification id (just for short name)
                    Get.to(OtpPage(vid: vid));
                },

                codeAutoRetrievalTimeout: (vid) {},
            );
        } on FirebaseAuthException catch(e) {
            Get.snackbar('Error Occured', e.code);
        } catch(e) {
            Get.snackbar('Error Message', e.toString());
        }
    }

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
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 6),
                        child: Text(
                            'An OTP will be sent to your phone',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                            ),
                        ),
                    ),

                    SizedBox(height: 20),

                    phonetext(),

                    SizedBox(height: 50),

                    button(),
                ],
            ),
        );
    }

    Widget button() {
        return Center(
            child: ElevatedButton(
                onPressed: () {
                    sendCode();
                },

                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16),
                    backgroundColor: Color.fromRGBO(90, 208, 248, 1),
                ),

                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 90),
                    child: Text(
                        'Recieve OTP',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                ),
            ),
        );
    }

    Widget phonetext() {
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: TextField(
                controller: phonenumber,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    prefix: Text('+88 '),
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Enter Phone Number',
                    hintStyle: TextStyle(color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)
                    ),
                ),
            ),
        );
    }
}
