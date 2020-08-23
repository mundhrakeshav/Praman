import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar getAppbar({String title = "प्रमाण", List<Widget> actions = const []}) {
  return AppBar(
    title: FlatButton(
      onPressed: () {},
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 30),
      ),
    ),
    actions: actions,
    centerTitle: actions.length == 0 && !kIsWeb,
  );
}
