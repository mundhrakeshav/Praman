import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:praman/Models/UserModel.dart';
import 'package:praman/Services/sharedPref.dart';
import 'package:praman/Services/webSocketsEthVigil.dart';
import 'package:praman/Widgets/Appbar.dart';

import 'package:provider/provider.dart';

import 'AndroidUi.dart';

class StudentLanding extends StatefulWidget {
//
  @override
  _StudentLandingState createState() => _StudentLandingState();
}

class _StudentLandingState extends State<StudentLanding> {
  int _bottomNavBarselectedIndex = 2;

  List<Widget> actions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            SharedPref.clearToken();
            Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => AndroidUi(),
                ));
          })
    ];
  }

  _onItemTap(int index) {
    setState(() {
      _bottomNavBarselectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> _bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      title: Text('Home'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      title: Text('Search'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('Profile'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    WebSocketsEthVigil wsProvider = Provider.of<WebSocketsEthVigil>(context);
    return Scaffold(
      appBar: getAppbar(actions: actions(context)),
      body: Container(
        child: Column(
          children: [
            Text(User.name),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomItems,
        currentIndex: _bottomNavBarselectedIndex,
        backgroundColor: Colors.grey[900],
        onTap: _onItemTap,
      ),
    );
  }
}
