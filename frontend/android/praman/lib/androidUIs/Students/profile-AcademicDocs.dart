import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:praman/Models/UserModel.dart';
import 'package:praman/Widgets/Appbar.dart';

class AcademicDocs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: ListView.separated(
          itemBuilder: (context, index) =>
              AcademicRecordCard(User.academicRecords[index]),
          separatorBuilder: (context, index) => Divider(),
          itemCount: User.academicRecords.length),
    );
  }
}

class AcademicRecordCard extends StatelessWidget {
  final AcademicRecord academicRecord;
  AcademicRecordCard(this.academicRecord);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AcademicRecordDetailed(academicRecord),
            ));
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 7),
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    academicRecord.title,
                    style: GoogleFonts.actor(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "GPA: " + academicRecord.gpa,
                    style: GoogleFonts.actor(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(height: 20),
              AutoSizeText(
                academicRecord.details,
                maxFontSize: 18,
                minFontSize: 15,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  CircleAvatar(
                    radius: 7,
                    backgroundColor:
                        academicRecord.isValidated ? Colors.green : Colors.red,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    academicRecord.isValidated
                        ? "Verified by ${academicRecord.validatorName}"
                        : "Not Verified",
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AcademicRecordDetailed extends StatelessWidget {
  final AcademicRecord academicRecord;

  AcademicRecordDetailed(this.academicRecord);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.memory(base64Decode(academicRecord.image)),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    academicRecord.title,
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
                        "GPA: " + academicRecord.gpa,
                        style: GoogleFonts.openSansCondensed(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 7,
                              backgroundColor: academicRecord.isValidated
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              academicRecord.isValidated
                                  ? "Verified by ${academicRecord.validatorName}"
                                  : "Not Verified",
                            )
                          ],
                        )),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Text(
                    academicRecord.details,
                    style: GoogleFonts.abel(fontSize: 20),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
