import 'package:basic_login_signup/login.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
    const SignupPage({super.key});

    @override
    State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
    bool _obscureText = true; // for password
    bool _obscureTextConfirm = true; // for confirm password field

    TextEditingController nameController = TextEditingController();
    TextEditingController gmailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    
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
                            //* Signup Label
                            Text(
                                'Signup',
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),

                            SizedBox(height: 15),
                            
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

                                    hintText: 'Enter Your Password',
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 17,
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

                            SizedBox(height: 20),
                            
                            //* Sign Up button
                            ElevatedButton(
                                onPressed: (() {
                                    // signIn();
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
                                    // signIn();
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
        );
    }
}
