import 'package:flutter/material.dart';

class NaviPage extends StatefulWidget {

  int currentIndex = 0;

  @override
  State<NaviPage> createState() => _NaviPageState();
}

class _NaviPageState extends State<NaviPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
      bottomNavigationBar:  BottomNavigationBar(
        currentIndex: 0,
        onTap: (index){
          setState(() {

          });
        }, items: [],
      ),
    );
  }
}
