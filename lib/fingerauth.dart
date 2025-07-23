import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:basic_login_signup/fingerhome.dart';

class FingerAuth extends StatefulWidget {
    const FingerAuth({super.key});

    @override
    State<FingerAuth> createState() => _FingerAuthState();
}

class _FingerAuthState extends State<FingerAuth> {
    final LocalAuthentication auth = LocalAuthentication();

    Future<void> checkAuth() async {
        bool isAvailable = await auth.canCheckBiometrics;
        print(isAvailable);

        if (isAvailable) {
            bool result =await auth.authenticate(
                localizedReason: 'Scan your fingerprint to proceed',
                options: AuthenticationOptions(biometricOnly: true), // by default, you can also use pattern lock. setting biometricOnly as true will let you only use fingerprint
            );

            if (result) {
                Get.to(FingerHome());
            } else {
                print('Permission denied');
            }
        } else {
            print('No! Biometric sensor detected');
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    SizedBox(height: 50),

                    Center(
                        child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lora',
                            ),
                        ),
                    ),

                    SizedBox(height: 50),

                    Icon(Icons.fingerprint_outlined, size: 75, color: Color.fromRGBO(117, 201, 253, 1)),

                    SizedBox(height: 30),

                    Center(
                        child: Text(
                            'Fingerprint Authentication',
                            style: TextStyle(
                                color: Color.fromRGBO(105, 136, 187, 1),
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lora',
                            ),
                        ),
                    ),

                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 5),

                        child: Center(
                            child: Text(
                                'Authentication using fingerprint to proceed in application',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                ),
                            ),
                        ),
                    ),

                    SizedBox(height: 100),

                    ElevatedButton(
                        onPressed: () {},

                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(117, 201, 253, 1),
                        ),

                        child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                                'Authenticate',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                ),
                            ),
                        ),
                    ),
                ],
            ),
        );
    }
}