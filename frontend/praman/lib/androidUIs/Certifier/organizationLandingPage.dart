import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:praman/Models/Organization.dart';
import 'package:praman/Services/sharedPref.dart';
import 'package:praman/Services/webSocketsEthVigil.dart';
import 'package:praman/Widgets/Appbar.dart';
import '../AndroidUi.dart';
import 'package:provider/provider.dart';

class Organizationlanding extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    WebSocketsEthVigil wsProvider = Provider.of<WebSocketsEthVigil>(context);

    return Scaffold(
      appBar: getAppbar(actions: actions(context)),
      body: Container(
        child: Column(
          children: [
            Text(Organization.name),
            Text(Organization.address),
          ],
        ),
      ),
    );
  }
}
