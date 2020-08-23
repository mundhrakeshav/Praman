// TODO Profile of the user

import 'package:flutter/material.dart';
import 'package:praman/Models/UserModel.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(User.name),
      ),
    );
  }
}
