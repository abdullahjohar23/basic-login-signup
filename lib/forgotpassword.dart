import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
    const ForgotPasswordPage({super.key});

    @override
    State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
    // bool _obscureText = true;
    // bool _obscureTextConfirm = true;

    TextEditingController gmailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    Future<void> resetPassword() async {
        try {
            // Show loading indicator
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => Center(child: CircularProgressIndicator()),
            );

            // Send password reset email
            await FirebaseAuth.instance.sendPasswordResetEmail(
                email: gmailController.text.trim(),
            );

            // Close loading dialog
            Navigator.pop(context);

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Password reset link sent to ${gmailController.text.trim()}'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 4),
                ),
            );

        } on FirebaseAuthException catch (e) {
            // Close loading dialog first
            Navigator.pop(context);

            // Handle specific errors
            String errorMessage;
            switch (e.code) {
                case 'invalid-email':
                    errorMessage = 'Please enter a valid email address';
                    break;
                case 'user-not-found':
                    errorMessage = 'No account found with this email';
                    break;
                default:
                    errorMessage = 'Failed to send reset link: ${e.message}';
            }

            // Show error
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(errorMessage),
                    backgroundColor: Colors.red,
                ),
            );
        } catch (e) {
            // Handle any other errors
            Navigator.pop(context);
            
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('An unexpected error occurred'),
                    backgroundColor: Colors.red,
                ),
            );
            
            debugPrint('Reset password error: $e');
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.white,

            body: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                            //* Icon
                            Icon(
                                Icons.privacy_tip_outlined,
                                size: 55,
                                color: Color(0xff7c71b2),
                            ),

                            SizedBox(height: 25),

                            //* Reset Password Label
                            Text(
                                'Reset Password',
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),

                            SizedBox(height: 15),

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

                            /*
                            // create new password field
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

                                    hintText: 'Create New Password',
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

                            // confirm password field
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

                            SizedBox(height: 30),
                            
                            //* Sign Up button
                            ElevatedButton(
                                onPressed: (() {
                                    resetPassword();
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
                                    'Send Reset Link',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}