import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';
import 'package:praman/Models/UserModel.dart';
import 'package:praman/Services/sharedPref.dart';
import 'package:praman/Services/webSocketsEthVigil.dart';
import 'package:praman/Widgets/Appbar.dart';
import 'package:praman/Widgets/drawerTiles.dart';
import 'package:praman/androidUIs/Profile.dart';

import 'package:provider/provider.dart';

import 'AndroidUi.dart';

class StudentLanding extends StatefulWidget {
//
  @override
  _StudentLandingState createState() => _StudentLandingState();
}

class _StudentLandingState extends State<StudentLanding> {
  int _bottomNavBarselectedIndex = 2;

  void logOut() {
    SharedPref.clearToken();
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => AndroidUi(),
        ));
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

  onTapp() {
    print("qwertyuiop");
  }

  List<Widget> _displays = [
    Text("data"),
    Text("data"),
    ProfilePage(),
  ];

  Widget getDisplay(int index) {
    return _displays.elementAt(index);
  }

  Widget drawer() {
    String rawSvg = Jdenticon.toSvg(User.address);

    return Theme(
        data: ThemeData(canvasColor: Colors.grey[900]),
        child: Drawer(
          child: Column(
            children: [
              Container(
                height: 20,
                color: Colors.black45,
              ),
              UserAccountsDrawerHeader(
                currentAccountPicture: SvgPicture.string(
                  rawSvg,
                  fit: BoxFit.contain,
                  height: 64,
                  width: 64,
                ),
                accountName: Text(User.name),
                accountEmail: Text(
                  User.address,
                  overflow: TextOverflow.fade,
                ),
                decoration: BoxDecoration(color: Colors.black45),
              ),
              getDrawerTile("Add Academics", Icons.book_outlined, onTapp),
              getDrawerTile("Add ResearchPapers", Icons.school, onTapp),
              getDrawerTile("Add Patents", Icons.lightbulb, onTapp),
              getDrawerTile("Add extraCurricular", Icons.sports, onTapp),
              Spacer(),
              getDrawerTile("Log Out", Icons.logout, logOut),
              SizedBox(height: 20)
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    WebSocketsEthVigil wsProvider = Provider.of<WebSocketsEthVigil>(context);

    return Scaffold(
      appBar: getAppbar(),
      drawer: drawer(),
      body: getDisplay(_bottomNavBarselectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomItems,
        currentIndex: _bottomNavBarselectedIndex,
        backgroundColor: Colors.grey[900],
        onTap: _onItemTap,
      ),
    );
  }
}
