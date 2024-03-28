import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:jikan_api/jikan_api.dart';
import 'package:uiproject/Screen/TabBar_Page.dart';
import 'package:uiproject/Screen/buttomNavbar.dart';
import 'package:uiproject/Screen/registration_page.dart';
import 'package:uiproject/firebase_options.dart';
import 'package:uiproject/provider/tabprovider.dart';
import 'package:uiproject/utils/colors.dart';

import 'Screen/Login_Page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

   runApp(ChangeNotifierProvider<PageState>(
    create: (context) => PageState(),
    child: MyApp(),
     ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
       theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      
      home:  ButtomNavbar(),
      routes: {
        '/login':(context) => const LoginPage(),
        '/registration':(context) => const SignUP(),
        
      },
    );
  }
}
  