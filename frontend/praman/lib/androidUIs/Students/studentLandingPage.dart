import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';
import 'package:praman/Models/UserModel.dart';
import 'package:praman/Services/sharedPref.dart';
import 'package:praman/Services/webSocketsEthVigil.dart';
import 'package:praman/Widgets/Appbar.dart';
import 'package:praman/Widgets/drawerTiles.dart';
import 'package:praman/androidUIs/Students/PendingRequests.dart';
import 'package:praman/androidUIs/search/searchPage.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../AndroidUi.dart';
import 'AddAcademics.dart';
import 'AddResearchPaper.dart';
import 'Profile.dart';

class StudentLanding extends StatefulWidget {
//
  @override
  _StudentLandingState createState() => _StudentLandingState();
}

class _StudentLandingState extends State<StudentLanding> {
  int _bottomNavBarselectedIndex = 3;

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
      icon: Icon(Icons.hourglass_empty),
      title: Text('Pending Reqs'),
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
    SearchPage(),
    PendingRequest(),
    ProfilePage(),
  ];

  Widget getDisplay(int index) {
    return _displays.elementAt(index);
  }

  Widget drawer(BuildContext context) {
    String rawSvg = Jdenticon.toSvg(User.address);

    return Theme(
        data: ThemeData(canvasColor: Colors.grey[900]),
        child: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                margin: EdgeInsets.all(20),
                currentAccountPicture: SvgPicture.string(
                  rawSvg,
                  fit: BoxFit.contain,
                  height: 64,
                  width: 64,
                ),
                onDetailsPressed: () async {
                  await launch(
                      "https://goerli.etherscan.io/address/" + User.address,
                      enableJavaScript: true,
                      forceWebView: true,
                      statusBarBrightness: Brightness.dark);
                },
                accountName: Text(User.name),
                accountEmail: Text(
                  User.address,
                  overflow: TextOverflow.fade,
                ),
                decoration: BoxDecoration(color: Colors.black45),
              ),
              getDrawerTile("Add Academics", Icons.book_outlined, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddAcademics(),
                  ),
                );
              }),
              getDrawerTile("Add ResearchPapers", Icons.school, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddResearchPaper(),
                  ),
                );
              }),
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
    // WebSocketsEthVigil wsProvider = Provider.of<WebSocketsEthVigil>(context);

    return Scaffold(
      appBar: getAppbar(),
      drawer: drawer(context),
      body: getDisplay(_bottomNavBarselectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _bottomItems,
        currentIndex: _bottomNavBarselectedIndex,
        backgroundColor: Colors.grey[900],
        onTap: _onItemTap,
      ),
    );
  }
}
