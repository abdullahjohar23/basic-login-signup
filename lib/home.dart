import 'package:flutter/material.dart';
import 'package:basic_login_signup/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
    const HomePage({super.key});

    @override
    State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final user = FirebaseAuth.instance.currentUser;

    signout() async {
        try {
            // Show loading indicator
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => Center(child: CircularProgressIndicator()),
            );

            await FirebaseAuth.instance.signOut();
            
            // Close loading dialog
            Navigator.pop(context);
            
            // Show success message before navigation
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Signed out successfully!'),
                    backgroundColor: Colors.green, // Optional success color
                    duration: Duration(seconds: 2),
                ),
            );
            
            // Navigate after a slight delay to show the message
            Future.delayed(Duration(milliseconds: 100), () { // will be signed out 0.1 second after clicking on sign out button
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                    (route) => false,
                );
            });

        } catch (e) {
            Navigator.pop(context); // Close loading on error
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("Sign out failed: ${e.toString()}"),
                    backgroundColor: Colors.red, // Error color
                ),
            );
        }
    }
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.white,
            
            body: Center(
                child: Text(
                    'This is Home Page',
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
                        signout();
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
