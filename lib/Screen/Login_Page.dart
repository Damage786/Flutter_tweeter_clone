
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uiproject/OAUTH/google.dart';
import 'package:uiproject/Screen/TabBar_Page.dart';
import 'package:uiproject/models/authentication.dart';
import 'package:uiproject/utils/Button.dart';
import 'package:uiproject/utils/input_filds.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailcon = TextEditingController();
    final TextEditingController _passcon = TextEditingController();
    final AuthService _auth = AuthService();
      final GoogleAuth _googleAuth = GoogleAuth();

    bool _isLoading = false;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20)),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: const Text(
            'Log in',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          
          // mainAxisAlignment:MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(flex: 1,child:Container()),
           const  Text('Login with the following',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,letterSpacing: 2),),
           const SizedBox(height: 25,),
             Padding(
               padding: const EdgeInsets.all(16.0),
               child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          'assets/apple.png',
                          color: Colors.white,
                          height: 50,
                          width: 50,
                        )),
             ),
                      const SizedBox(height: 1,),
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
                    ? CircularProgressIndicator()
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
            const SizedBox(height: 1,),
            
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFieldInput(hintText: 'email',textEditingController: _emailcon,textInputType: TextInputType.emailAddress,isPass: false,),
            ),
            const SizedBox(height: 0.1,),
            
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFieldInput(hintText: 'password',textEditingController: _passcon,textInputType: TextInputType.text,isPass: true,),
            ),
            const SizedBox(height: 0.1,),


             Button(button: 'Log In',onTap: () async {
              String email = _emailcon.text.trim();
              String password = _passcon.text.trim();

              if(email.isEmpty || password.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fill the all input'),
                  ),
                );
              
              } else {
                _auth.signInWithEmailAndPassword(_emailcon.text,_passcon.text);
                 Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>  HomePage(),
                    )
                 );
              }
              
            },),
            const SizedBox(height: 20,),

            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/registration');
              },
              child: Container(
                child: const Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('have account'),
                       SizedBox(width: 10,),
                      Text('SignUP',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 140,),
            
             
          ],
        ));
  }
}
