import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uiproject/Screen/show_Tweet_Page.dart';
import 'package:uiproject/Screen/upload_page_.dart';
import 'package:uiproject/provider/tabprovider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageState _pageState;

  @override
  void initState() {
    super.initState();
    _pageState = Provider.of<PageState>(context, listen: false);
    _pageState.setSelectedIndex(_pageState.selectedTabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: _pageState.selectedTabIndex,
      length: 2, // Specify the number of tabs
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.circle,
            size: 30,
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 18.0),
            child: Center(child: Text('X')),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.blue,
            tabs: [
              Tab(
                text: 'For you',
              ),
              Tab(
                text: 'Following',
              ),
            ],
          ),
        ),
        body: const Column(
          children: [
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Foryou(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Tweet(),
                ));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blueGrey,
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
