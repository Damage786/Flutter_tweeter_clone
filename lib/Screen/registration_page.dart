import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uiproject/OAUTH/google.dart';
import 'package:uiproject/Screen/TabBar_Page.dart';
import 'package:uiproject/Screen/Login_Page.dart';
import 'package:uiproject/models/authentication.dart';
import 'package:uiproject/utils/Button.dart';
import 'package:uiproject/utils/input_filds.dart';

class SignUP extends StatefulWidget {
  const SignUP({Key? key}) : super(key: key);

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  final TextEditingController _emailcon = TextEditingController();
  final TextEditingController _passcon = TextEditingController();
  final TextEditingController _Confirmpasscon = TextEditingController();

  final GoogleAuth _googleAuth = GoogleAuth();
  final AuthService _auth = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcon.dispose();
    _passcon.dispose();
    _Confirmpasscon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'SignUp',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Container(),
          ),
          const Text(
            'SignUp with the following',
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                'assets/apple.png',
                color: Colors.white,
                height: 50,
                width: 50,
              ),
            ),
          ),
          const SizedBox(height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  _isLoading = true;
                });
                // Initiate Google OAuth process
                User? user = await _googleAuth.signInWithGoogle();
                setState(() {
                  _isLoading =
                      false; // Hide the progress indicator regardless of the outcome
                });
                if (user != null) {
                  // Handle successful sign-in
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>  HomePage(),
                    ),
                  );
                } else {
                  // Handle sign-in failure
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sign-in failed. Please try again.'),
                    ),
                  );
                }
              },
              child: Center(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          'assets/google.png',
                          height: 50,
                          width: 50,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 1),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFieldInput(
                hintText: 'email',
                textEditingController: _emailcon,
                textInputType: TextInputType.emailAddress,
                isPass: false),
          ),
          const SizedBox(height: 0.1),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFieldInput(
                hintText: 'password',
                textEditingController: _passcon,
                textInputType: TextInputType.text,
                isPass: true),
          ),
          const SizedBox(height: 0.1),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFieldInput(
                hintText: 'confirm password',
                textEditingController: _Confirmpasscon,
                textInputType: TextInputType.text,
                isPass: true),
          ),
          const SizedBox(height: 0.1),
          Button(
            button: 'Sign up',
            onTap: () async {
              String email = _emailcon.text.trim();
              String password = _passcon.text.trim();
              String confirmPassword = _Confirmpasscon.text.trim();

              if (email.isEmpty ||
                  password.isEmpty ||
                  confirmPassword.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill in all fields.'),
                  ),
                );
              } else if (password != confirmPassword ) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Passwords do not match. Please try again.'),
                  ),
                );
                
              } 
                          else if (_passcon.text.length < 6 || _Confirmpasscon.text.length < 6) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password should be at least 6 characters long.'),
                ),
              );
}
        
              else {
                try {
                  await _auth.registerWithEmailAndPassword(email, password);
                 
                  // Handle successful sign-in
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>  HomePage(),
                    ),
                  );
                  // Registration successful, navigate to the next screen
                } catch (e) {
                  if (e is FirebaseAuthException &&
                      e.code == 'email-already-in-use') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Email is already in use. Please use a different email.'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('An error occurred. Please try again later.'),
                      ),
                    );
                  }
                }
              }
            },
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            ),
            child: Container(
              child: const Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('no account'),
                    SizedBox(width: 5),
                    Text(
                      'LogIn',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 140),
        ],
      ),
    );
  }
}
