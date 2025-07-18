import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:basic_login_signup/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
    const HomePage({super.key});

    @override
    State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final userInfo = FirebaseAuth.instance.currentUser;

    // SignOut function
    Future<void> signOut() async {
        try {
            // Show loading indicator (GetX version)
            Get.dialog(
                Center(child: CircularProgressIndicator()),
                barrierDismissible: false,
            );

            await GoogleSignIn().signOut(); // This will show up Google Account list after logging out
            await FirebaseAuth.instance.signOut(); // But this won't show the Google Account list after logging out. Instead, it will directly sign in to the last google account that was used to sign in
            
            // Close loading dialog
            Get.back();
            
            // Show success message (Get.snackbar)
            Get.snackbar(
                'Success',
                'Signed out successfully!',
                colorText: Colors.white,
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
                snackPosition: SnackPosition.BOTTOM,
                icon: const Icon(Icons.check_circle, color: Colors.white),
            );
            
            // Navigate after delay (GetX navigation)
            Future.delayed(const Duration(milliseconds: 100), () {
                Get.offAll(() => LoginPage()); // Clear all routes
            });

        } catch (e) {
            // Close loading on error
            if (Get.isDialogOpen!) Get.back();
            
            // Show error message (Get.snackbar)
            Get.snackbar(
                'Error',
                'Log out failed: ${e.toString().replaceFirst('Exception: ', '')}',
                colorText: Colors.white,
                backgroundColor: Colors.red,
                snackPosition: SnackPosition.BOTTOM,
                icon: const Icon(Icons.error_outline, color: Colors.white),
                duration: const Duration(seconds: 4), // Longer for errors
            );
        }
    }
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.white,
            
            body: Center(
                child: Text(
                    'Hello, ${userInfo!.email ?? 'User'} 🎉',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                    ),
                ),
            ),

            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 30, right: 20),
                child: FloatingActionButton(
                    onPressed: (() {
                        signOut();
                    }),
                    
                    child: Icon(
                        Icons.login_rounded,
                        color: Color(0xff7c71b2),
                        size: 30,
                    ),
                ),
            ),
        );
    }
}
