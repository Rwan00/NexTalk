import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageindex = 0;
  final List<Widget> _pages = [
    Container(color: Colors.red),
    Container(color: Colors.green),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageindex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        currentIndex: _currentPageindex,
        onTap: (index) {
          setState(() {
            _currentPageindex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_sharp),
            label: "Users",
          ),
        ],
      ),
    );
  }
}
