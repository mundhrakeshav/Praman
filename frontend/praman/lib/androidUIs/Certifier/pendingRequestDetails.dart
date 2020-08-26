import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:praman/Models/Organization.dart';
import 'package:provider/provider.dart';

class PendingRequestDetailed extends StatelessWidget {
  final PendingRequest request;
  final int index;

  PendingRequestDetailed(this.request, this.index);

  @override
  Widget build(BuildContext context) {
    Organization orgProvider = Provider.of<Organization>(context);

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.memory(base64Decode(request.image)),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    request.title,
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
                        "GPA: " + request.gpa,
                        style: GoogleFonts.openSansCondensed(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              request.requestingUserName,
                              style: GoogleFonts.openSansCondensed(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            child: Text(
                              request.requestRecordUID,
                              style: GoogleFonts.openSansCondensed(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Text(
                    request.details,
                    style: GoogleFonts.abel(fontSize: 20),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  buttonMinWidth: MediaQuery.of(context).size.width * .3,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        orgProvider.handleRequest(index, request.userAddress,
                            "true", request.requestRecordCount);
                      },
                      child: Text("Approve"),
                      color: Colors.blueGrey,
                    ),
                    RaisedButton(
                      onPressed: () {
                        orgProvider.handleRequest(index, request.userAddress,
                            "false", request.requestRecordCount);
                      },
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
