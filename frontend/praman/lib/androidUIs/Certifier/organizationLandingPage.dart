import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';
import 'package:praman/Models/Organization.dart';
import 'package:praman/Services/sharedPref.dart';
import 'package:praman/Widgets/Appbar.dart';
import 'package:praman/Widgets/drawerTiles.dart';
import 'package:praman/androidUIs/Certifier/addCertificate.dart';
import 'package:praman/androidUIs/search/searchPage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../AndroidUi.dart';

import 'PendingRequestsPage.dart';

class Organizationlanding extends StatefulWidget {
  @override
  _OrganizationlandingState createState() => _OrganizationlandingState();
}

class _OrganizationlandingState extends State<Organizationlanding> {
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
      title: Text('Pending Req'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('Profile'),
    ),
  ];

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

  List<Widget> _displays = [
    Text("1"),
    SearchPage(),
    PendingRequests(),
    Text("4"),
  ];

  Widget getDisplay(int index) {
    return _displays.elementAt(index);
  }

  Widget drawer(BuildContext context) {
    String rawSvg = Jdenticon.toSvg(Organization.address);

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
                      "https://goerli.etherscan.io/address/" +
                          Organization.address,
                      enableJavaScript: true,
                      forceWebView: true,
                      statusBarBrightness: Brightness.dark);
                },
                accountName: Text(Organization.name),
                accountEmail: Text(
                  Organization.address,
                  overflow: TextOverflow.fade,
                ),
                decoration: BoxDecoration(color: Colors.black45),
              ),
              getDrawerTile("Send a Certificate ", Icons.send, () {
                print("object");
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddCertificate(),
                ));
              }),
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
