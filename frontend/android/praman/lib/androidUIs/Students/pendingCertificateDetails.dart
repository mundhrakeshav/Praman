import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:praman/Widgets/Appbar.dart';
import 'package:praman/androidUIs/Students/pendingCertificate.dart';

class PendingCertificateDetailsUi extends StatelessWidget {
  final PendingCertificateDetails pendingCertificate;
  final int index;

  PendingCertificateDetailsUi(
    this.pendingCertificate,
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                background:
                    Image.memory(base64Decode(pendingCertificate.image)),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    pendingCertificate.title,
                    style: GoogleFonts.openSansCondensed(
                        fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      child: Text(
                        "GPA: " + pendingCertificate.gpa,
                        style: GoogleFonts.openSansCondensed(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Text(
                    pendingCertificate.details,
                    style: GoogleFonts.abel(fontSize: 20),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  buttonMinWidth: MediaQuery.of(context).size.width * .3,
                  children: [
                    RaisedButton(
                      onPressed: () {},
                      child: Text("Approve"),
                      color: Colors.blueGrey,
                    ),
                    RaisedButton(
                      onPressed: () {},
                      child: Text("Decline"),
                      color: Colors.red,
                    )
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
