import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
    const ForgotPasswordPage({super.key});

    @override
    State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
    bool _obscureText = true;
    bool _obscureTextConfirm = true;

    TextEditingController gmailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    resetPassword() async {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: gmailController.text);
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
                        // crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
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

                            //* create new password field
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

                            //* confirm password field
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