// TODO Profile of the user
import 'dart:convert';

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:praman/Services/networkConfig.dart';
import 'package:praman/androidUIs/Students/profile-AcademicDocs.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Divider(),
        ListTile(
          tileColor: Colors.white12,
          title: Text("Official Govt. Docs"),
          trailing: Icon(Icons.arrow_right),
        ),
        Divider(),
        ListTile(
          tileColor: Colors.white12,
          title: Text("Academic Docs"),
          trailing: Icon(Icons.arrow_right),
          onTap: () => Navigator.push(context,
              CupertinoPageRoute(builder: (context) => AcademicDocs())),
        ),
        Divider(),
        ListTile(
          tileColor: Colors.white12,
          title: Text("Research Papers"),
          trailing: Icon(Icons.arrow_right),
        ),
        Divider(),
        ListTile(
          tileColor: Colors.white12,
          title: Text("Patents"),
          trailing: Icon(Icons.arrow_right),
        ),
        Divider(),
        ListTile(
          tileColor: Colors.white12,
          title: Text("Extracurricular "),
          trailing: Icon(Icons.arrow_right),
        ),
      ],
    ));
  }
}
