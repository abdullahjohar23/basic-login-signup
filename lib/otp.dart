import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:basic_login_signup/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpPage extends StatefulWidget {
    final String vid;
    const OtpPage({
        super.key,
        required this.vid,
    });

    @override
    State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
    var code = '';

    Future<void> signIn() async {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: widget.vid,
            smsCode: code,
        );

        try {
            await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
                Get.offAll(Wrapper());
            }); 
        } on FirebaseAuthException catch (e) {
            Get.snackbar('Error Occured', e.code);
        } catch (e) {
            Get.snackbar('Error Occured', e.toString());
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.white,

            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
                child: ListView(
                    shrinkWrap: true,

                    children: [
                        Image.asset('asset/images/enterotpcellphone.png', height: 300, width: 300),

                        Center(
                            child: Text(
                                'OTP Verification',
                                style: TextStyle(
                                    fontSize: 30,
                                ),
                            ),
                        ),

                        Padding(
                            padding: EdgeInsetsGeometry.symmetric(horizontal: 25, vertical: 6),
                            child: Text('Enter OTP sent to +88 01705336048', textAlign: TextAlign.center,),
                        ),

                        SizedBox(height: 30,),

                        // textCode(),

                        SizedBox(height: 80,),

                        button(),
                    ],
                ),
            ),
        );
    }

    Widget button() {
        return Center(
            child: ElevatedButton(
                onPressed: () {
                    signIn();
                },

                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16),
                    backgroundColor: Color.fromRGBO(140, 178, 241, 1),
                ),

                child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 90),
                    child: Text(
                        'Verify & Proceed',
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

    Widget textcode() {
        return Center(
            child: Padding(
                padding: EdgeInsetsGeometry.all(6),
                child: Pinput(
                    length: 6,
                    onChanged: (value) {
                        setState(() {
                            code = value;
                        });
                    },
                ),
            ),
        );
    }
}
