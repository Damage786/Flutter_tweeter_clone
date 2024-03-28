import 'package:flutter/material.dart';
import 'package:uiproject/Screen/TabBar_Page.dart';

class ButtomNavbar extends StatefulWidget {
  const ButtomNavbar({super.key});

  @override
  State<ButtomNavbar> createState() => _ButtomNavbarState();
 
}

class _ButtomNavbarState extends State<ButtomNavbar> {
  int _page = 0;

  @override
  void initState() {
    super.initState();

  }

final List <Widget> _screens = [
  const HomePage(),
  const Text('search'),
  Center(child: const Text('grok')),
  const Text('notification'),
  const Text('messages'),

];

  void navigationTapped(int index) {
    setState(() {
      _page = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        onTap: navigationTapped,
         backgroundColor:
            Colors.black, // Set the background color of BottomNavigationBar
        selectedItemColor: Colors.blue, // Customize the selected item color
        unselectedItemColor: Colors.grey, 
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          BottomNavigationBarItem(icon: Icon(Icons.line_axis), label: 'grok'),
          BottomNavigationBarItem(icon: Icon(Icons.notification_add), label: 'notification'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'messages'),
        ],
      ),
    );
  }
}
