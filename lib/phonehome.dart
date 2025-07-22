import 'package:basic_login_signup/wrapper.dart';
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
        // Add phone number validation
        if (phonenumber.text.isEmpty || phonenumber.text.length < 10) {
            Get.snackbar('Error', 'Please enter a valid phone number');
            return;
        }

        // Show loading
        Get.dialog(
            Center(child: CircularProgressIndicator()),
            barrierDismissible: false,
        );

        try {
            String formattedNumber = '+880${phonenumber.text.replaceAll(RegExp(r'^0'), '')}';
            // print('Attempting verification for: $formattedNumber'); // Debug log

            await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: formattedNumber,
                verificationCompleted: (credential) async {
                    await FirebaseAuth.instance.signInWithCredential(credential);
                    Get.back(); // Close loading
                    Get.offAll(Wrapper());
                },
                verificationFailed: (e) {
                    Get.back(); // Close loading
                    Get.snackbar('Verification Failed', e.message ?? e.code, duration: Duration(seconds: 5));
                },
                codeSent: (verificationId, forceResendingToken) {
                    Get.back(); // Close loading
                    Get.to(OtpPage(vid: verificationId));
                },
                codeAutoRetrievalTimeout: (verificationId) {
                    // Handle timeout if needed
                },
                timeout: Duration(seconds: 60),
            );
        } catch (e) {
            Get.back(); // Close loading
            Get.snackbar('Error', e.toString(), duration: Duration(seconds: 5));
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
                    prefix: Text('+880 '),
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
