import 'package:flutter/material.dart';
import 'package:basic_login_signup/home.dart';
import 'package:basic_login_signup/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
    const LoginPage({super.key});

    @override
    State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    bool _obscureText = true; // for password

    TextEditingController gmailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    //* Sign In Function
    signIn() async {
        try {
            // Show loading indicator
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => Center(child: CircularProgressIndicator()),
            );

            // Attempt sign-in
            await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: gmailController.text.trim(), // Trim extra whitespace from email
                password: passwordController.text, // Don't trim passwords
            );
            
            // Close loading dialog
            Navigator.pop(context);

            // Show success message before navigation
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Logged In successfully!'),
                    backgroundColor: Colors.green, // Optional success color
                    duration: Duration(seconds: 2),
                ),
            );
            
            // Navigate to home and clear navigation stack
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomePage()),
                (route) => false,
            );

        } on FirebaseAuthException catch (e) {
            // Close loading dialog first
            Navigator.pop(context);
            
            // Handle specific error codes
            String errorMessage;
            switch (e.code) {
                case 'invalid-email':
                    errorMessage = 'Please enter a valid email address';
                    break;
                case 'user-disabled':
                    errorMessage = 'This account has been disabled';
                    break;
                case 'user-not-found':
                    errorMessage = 'No account found for this email';
                    break;
                case 'wrong-password':
                    errorMessage = 'Incorrect password, please try again';
                    break;
                case 'too-many-requests':
                    errorMessage = 'Too many attempts. Try again later';
                    break;
                case 'network-request-failed':
                    errorMessage = 'Network error. Check your internet connection';
                    break;
                default:
                    errorMessage = 'Login failed: ${e.message}';
            }
            
            // Show error to user
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(errorMessage),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                ),
            );
        } catch (e) {
            // Handle any non-Firebase exceptions
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('An unexpected error occurred'),
                    backgroundColor: Colors.red,
                ),
            );
            
            debugPrint('Login error: ${e.toString()}');
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
                            // crossAxisAlignment: CrossAxisAlignment.center,
                
                            children: [
                                //* Login Label
                                Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                
                                SizedBox(height: 15),
                
                                //* gmail field
                                TextField(
                                    controller: gmailController,
                
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400
                                    ),
                
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            // horizontal: 5,
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
                
                                        hintText: 'Enter Your Password',
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
                
                                SizedBox(height: 20),
                
                                //* Forgot Password
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                
                                    children: [
                                        Text(
                                            'Forgot Password?',
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500
                                            ),
                                        ),
                                    ],
                                ),
                
                                SizedBox(height: 20),
                                
                                //* Sign In button
                                ElevatedButton(
                                    onPressed: (() {
                                        signIn();
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
                                        'Sign In',
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
                                        signIn();
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
                                                'Sign In With Google',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                
                                SizedBox(height: 18),
                
                                //* Don't have an account
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                
                                    children: [
                                        Text(
                                            "Don't have an account?",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                            ),
                                        ),
                                        
                                        SizedBox(width: 12),
                                            
                                        GestureDetector(
                                            onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                                            },
                                                
                                            child: Text(
                                                'Sign up',
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
