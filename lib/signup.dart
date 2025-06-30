import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:basic_login_signup/login.dart';
import 'package:basic_login_signup/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatefulWidget {
    const SignupPage({super.key});

    @override
    State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
    bool _obscureText = true; // for password
    // bool _obscureTextConfirm = true; // for confirm password field

    TextEditingController nameController = TextEditingController();
    TextEditingController gmailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    // Signup functionm (This function handles the entire user registration process)
    Future<void> signUp() async {
        // This function handles the entire user registration process
        try {
            // Show a loading dialog to indicate processing
            showDialog(
                context: context, // Uses the current screen context
                barrierDismissible: false, // Prevents closing by tapping outside
                builder: (context) => Center( // Centers the loading indicator
                    child: CircularProgressIndicator(), // Shows spinning progress wheel
                ),
            );

            // Create user account with email and password using Firebase Auth
            final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: gmailController.text.trim(), // Gets email from controller and removes whitespace
                password: passwordController.text, // Gets password from controller
            );

            // Update the user's profile with their name
            await userCredential.user!.updateProfile(
                displayName: nameController.text.trim(), // Sets display name from controller
            );
            
            // Refresh user data to ensure name is immediately available
            await userCredential.user!.reload();

            // Save additional user data to Firestore database
            await FirebaseFirestore.instance // Access Firestore instance
                .collection('users') // Use 'users' collection
                .doc(userCredential.user!.uid) // Create document with user's UID as ID
                .set({ // Set document data:
                    'name': nameController.text.trim(), // Store name
                    'email': gmailController.text.trim(), // Store email
                    'createdAt': FieldValue.serverTimestamp(), // Add server timestamp
                }
            );

            // Show success message using a SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Account created successfully!'), // Success message
                    backgroundColor: Colors.green, // Green background for success
                    duration: Duration(seconds: 2), // Show for 2 seconds
                ),
            );

            // Wait 1 second before navigating to let user see success message
            Future.delayed(Duration(seconds: 1), () {
            // Navigate to wrapper page and clear navigation history
                Get.offAll(() => Wrapper());
            });
        } on FirebaseAuthException catch (e) {
            // Handle specific Firebase authentication errors
            
            // First close any open loading dialog
            Navigator.pop(context);
            
            // Get user-friendly error message based on error code
            String error = _getErrorMessage(e.code);
            
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(error), // Display error message
                    backgroundColor: Colors.red, // Red for errors
                ),
            );
        } catch (e) { // Handle any other unexpected errors
            
            // Close loading dialog
            Navigator.pop(context);
            
            // Show generic error message
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('An error occurred'), 
                    backgroundColor: Colors.red,
                ),
            );
        }
    }

    // Helper function to convert Firebase error codes to user-friendly messages
    String _getErrorMessage(String code) {
        switch(code) {
            case 'email-already-in-use': 
            return 'Email already registered'; // When email exists
            case 'weak-password': 
            return 'Password must be 6+ characters'; // When password is too weak
            default: 
            return 'Signup failed'; // Default error message
        }
    }
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.white,

            body: GestureDetector(
                //* to unfocus textfields when click on screen
                onTap: () {
                    // This unfocuses the currently focused text field
                    FocusScope.of(context).unfocus();
                },
                
                behavior: HitTestBehavior.translucent, // This property controls how a GestureDetector responds to touches/gestures in Flutter
                
                
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                
                            children: [
                                //* Signup Label
                                Text(
                                    'Signup',
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                
                                SizedBox(height: 25),
                                
                                //* name field
                                TextField(
                                    controller: nameController,
                
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400
                                    ),
                
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10,
                                        ),
                
                                        hintText: 'Enter Your Name',
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 17,
                                        ),
                
                                        prefixIcon: Icon(
                                            Icons.account_circle_outlined,
                                            color: Color(0xff7c71b2),
                                            size: 20,
                                        ),
                
                                        // Thick border when not focused
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Color(0xffc8bbdc), // Border color
                                                width: 1.5, // Border thickness
                                            ),
                                        ),
                                            
                                        // Thick border when focused (clicked)
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Color(0xff7c71b2), // Highlighted border
                                                width: 2.5,
                                            ),
                                        ),
                                    ),
                                ),

                                SizedBox(height: 10),
                
                                //* mail field
                                TextField(
                                    controller: gmailController,
                
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400
                                    ),
                
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10,
                                        ),
                
                                        hintText: 'Enter Your Mail',
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 17,
                                        ),
                
                                        prefixIcon: Icon(
                                            Icons.mail_outlined,
                                            color: Color(0xff7c71b2),
                                            size: 20,
                                        ),
                
                                        // Thick border when not focused
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Color(0xffc8bbdc), // Border color
                                                width: 1.5, // Border thickness
                                            ),
                                        ),
                                            
                                        // Thick border when focused (clicked)
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Color(0xff7c71b2), // Highlighted border
                                                width: 2.5,
                                            ),
                                        ),
                                    ),
                                ),
                
                                SizedBox(height: 10),
                
                                //* password field
                                TextField(
                                    controller: passwordController,
                                    obscureText: _obscureText,
                                    obscuringCharacter: '●',
                                    autocorrect: false,
                                    enableSuggestions: false,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    textCapitalization: TextCapitalization.none,
                
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400
                                    ),
                
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10,
                                        ),
                
                                        hintText: 'Create Password',
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 17,
                                        ),
                
                                        prefixIcon: Icon(
                                            Icons.lock_outlined,
                                            color: Color(0xff7c71b2),
                                            size: 20,
                                        ),
                
                                        // Thick border when not focused
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Color(0xffc8bbdc), // Border color
                                                width: 1.5, // Border thickness
                                            ),
                                        ),
                                            
                                        // Thick border when focused (clicked)
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Color(0xff7c71b2), // Highlighted border
                                                width: 2.5,
                                            ),
                                        ),
                
                                        // hide or unhide the password
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                                setState(() {
                                                    _obscureText = !_obscureText;
                                                });
                                            },
                                            
                                            icon: Icon(
                                                _obscureText ? Icons.visibility_off : Icons.visibility,
                                                color: const Color(0xff7c71b2),
                                            ),
                                        ),
                                    ),
                                ),
                
                                SizedBox(height: 10),
                
                                //* confirm password field
                                /*
                                TextField(
                                    controller: confirmPasswordController,
                                    obscureText: _obscureTextConfirm,
                                    obscuringCharacter: '●',
                                    autocorrect: false,
                                    enableSuggestions: false,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    textCapitalization: TextCapitalization.none,
                
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400
                                    ),
                
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10,
                                        ),
                
                                        hintText: 'Confirm Password',
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 17,
                                        ),
                
                                        prefixIcon: Icon(
                                            Icons.lock_outlined,
                                            color: Color(0xff7c71b2),
                                            size: 20,
                                        ),
                
                                        // Thick border when not focused
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Color(0xffc8bbdc), // Border color
                                                width: 1.5, // Border thickness
                                            ),
                                        ),
                                            
                                        // Thick border when focused (clicked)
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Color(0xff7c71b2), // Highlighted border
                                                width: 2.5,
                                            ),
                                        ),
                
                                        // hide or unhide the password
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                                setState(() {
                                                    _obscureTextConfirm = !_obscureTextConfirm;
                                                });
                                            },
                                            
                                            icon: Icon(
                                                _obscureTextConfirm ? Icons.visibility_off : Icons.visibility,
                                                color: const Color(0xff7c71b2),
                                            ),
                                        ),
                                    ),
                                ),
                                */

                                SizedBox(height: 20),
                                
                                //* Sign Up button
                                ElevatedButton(
                                    onPressed: (() {
                                        signUp();
                                    }),
                
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff7c71b2), // Purple color matching your theme
                                        foregroundColor: Colors.white, // Text color
                                        minimumSize: Size(double.infinity, 50), // Full width + height
                                        elevation: 3, // Subtle shadow
                                        shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10), // Rounded corners
                                        ),
                                        padding: EdgeInsets.symmetric(vertical: 12), // Vertical padding
                                    ),
                
                                    child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                        ),
                                    ),
                                ),
                
                                SizedBox(height: 20),
                
                                //* Or Label
                                Text(
                                    'Or',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500
                                    ),
                                ),
                
                                SizedBox(height: 10),
                
                                //* Sign In With Google
                                ElevatedButton(
                                    onPressed: (() {
                                        // signUp();
                                    }),
                
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(vertical: 12), // Vertical padding
                                        backgroundColor: Color(0xff7c71b2), // background color
                                        foregroundColor: Colors.white, // Text color
                                        minimumSize: Size(double.infinity, 50), // Full width + height
                                        elevation: 3, // Subtle shadow
                                        
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10), // Rounded corners
                                        ),
                                    ),
                
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                
                                        children: [
                                            Image.asset(
                                                'asset/images/google.png',
                                                width: 30,
                                                color: Colors.white,
                                                fit: BoxFit.cover,
                                            ),
                                            
                                            SizedBox(width: 10),
                                            
                                            Text(
                                                'Sign Up With Google',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                
                                SizedBox(height: 18),
                
                                //* Already have an account
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                
                                    children: [
                                        Text(
                                            "Already have an account?",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                            ),
                                        ),
                                        
                                        SizedBox(width: 12),
                                            
                                        GestureDetector(
                                            onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                            },
                                                
                                            child: Text(
                                                'Log In',
                                                style: TextStyle(
                                                    color: Color(0xffa193c6),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                ),
                                            ),
                                        ),
                                    ],
                                ),
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}
