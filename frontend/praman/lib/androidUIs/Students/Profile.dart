// TODO Profile of the user
import 'dart:convert';
// import 'dart:html';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:praman/Models/UserModel.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Uint8List image;

  getData() async {
    http.Response resp = await http.get(
        "https://ipfs.io/ipfs/QmPGwr3cf7QBAkcz6JcTJREgTnofME1fhehCgnQ7MroSuQ");
    setState(() {
      image = base64Decode(json.decode(resp.body)["image"]);
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: image != null ? Image.memory(image) : Text("data"),
    ));
  }
}
