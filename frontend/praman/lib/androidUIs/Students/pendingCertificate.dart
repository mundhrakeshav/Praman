import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:praman/Models/UserModel.dart';
import 'package:praman/Services/helper.dart';
import 'package:praman/Services/networkConfig.dart';
import 'package:praman/Widgets/Appbar.dart';
import 'package:http/http.dart' as http;
import 'package:praman/androidUIs/Students/pendingCertificateDetails.dart';

class PendingCertificate extends StatefulWidget {
  @override
  _PendingCertificateState createState() => _PendingCertificateState();
}

class _PendingCertificateState extends State<PendingCertificate> {
  List<PendingCertificateDetails> pendingRequest = [];
  bool isLoading = true;
  getPendingRequest() async {
    pendingRequest.clear();
    setState(() {
      isLoading = true;
    });
    http.Response response =
        await http.get(url + "/getPendingRequest", headers: {"uid": User.uid});

    List data = jsonDecode(response.body)["pendingCertificates"];

    print(data);

    for (var item in data) {
      Map dataIpfs = await HelperFunctions.getDataFromIpfs(item["ipfsHash"]);

      print(dataIpfs);

      pendingRequest.add(PendingCertificateDetails(
        title: item["title"],
        details: dataIpfs["details"],
        image: dataIpfs["image"],
        gpa: item["gpa"],
        type: item["type"],
        sendersAddress: item["sendersAddress"],
      ));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getPendingRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : pendingRequest.isEmpty
              ? Center(child: Text("No pending certificates"))
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ListView.separated(
                      itemBuilder: (context, index) => PendingCertificateCard(
                            pendingRequest: pendingRequest[index],
                            index: index,
                            reloadWindow: () {
                              getPendingRequest();
                            },
                          ),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: pendingRequest.length),
                ),
    );
  }
}

class PendingCertificateCard extends StatelessWidget {
  final PendingCertificateDetails pendingRequest;
  final int index;
  final Function reloadWindow;
  const PendingCertificateCard({
    this.reloadWindow,
    this.pendingRequest,
    this.index,
  });

  handleCertificate(bool isAccepted) async {
    await http.post(url + "/acceptCertificate", body: {
      "uid": User.uid,
      "index": index.toString(),
      "isAccepted": isAccepted.toString(),
      "sendersaddress": pendingRequest.sendersAddress,
      "useraddress": User.address
    });
    reloadWindow();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PendingCertificateDetailsUi(pendingRequest, index),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              pendingRequest.title,
              style: GoogleFonts.abel(fontSize: 25),
              textAlign: TextAlign.left,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "GPA - " + pendingRequest.gpa,
                  style: GoogleFonts.abel(fontSize: 25),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  pendingRequest.type,
                  style: GoogleFonts.abel(fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              pendingRequest.details,
              style: GoogleFonts.abel(fontSize: 15),
              textAlign: TextAlign.left,
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            buttonMinWidth: MediaQuery.of(context).size.width * .3,
            children: [
              RaisedButton(
                onPressed: () {
                  handleCertificate(true);
                },
                child: Text("Accept"),
                color: Colors.blueGrey,
              ),
              RaisedButton(
                onPressed: () {
                  handleCertificate(false);
                },
                child: Text("Decline"),
                color: Colors.red,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class PendingCertificateDetails {
  String title;
  String type;
  String image;
  String details;
  String gpa;
  String sendersAddress;
  PendingCertificateDetails(
      {this.title,
      this.details,
      this.image,
      this.gpa,
      this.type,
      this.sendersAddress});
}
