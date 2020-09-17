import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar getBasicAppbar({String title = "प्रमाण", List<Widget> actions}) {
  return AppBar(
    title: Text(
      title,
      style: GoogleFonts.poppins(fontSize: 30),
    ),
    centerTitle: actions == null,
    actions: actions == null ? <Widget>[] : actions,
  );
}
