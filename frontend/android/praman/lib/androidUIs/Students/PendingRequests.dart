import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:praman/Models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:praman/Services/networkConfig.dart';

class PendingRequest extends StatefulWidget {
  @override
  _PendingRequestState createState() => _PendingRequestState();
}

class _PendingRequestState extends State<PendingRequest> {
  bool _isLoading = true;

  List<dynamic> pendingReqs = [];

  initialise() async {
    Map data = await User.getPendingRequests(User.uid);
    setState(() {
      pendingReqs = data["pendingRequests"];
      _isLoading = false;
    });

    print(pendingReqs);
  }

  @override
  void initState() {
    initialise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Your have got ${pendingReqs.length} Requests to Access your details.",
                      style: GoogleFonts.acme(fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        print(index);
                        return RequestCard(
                          pendingReq: pendingReqs[index],
                          index: index,
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: pendingReqs.length,
                    ),
                  ),
                ],
              ));
  }
}

class RequestCard extends StatelessWidget {
  final Map pendingReq;
  final int index;
  const RequestCard({
    this.pendingReq,
    this.index,
  });

  handleAccessRequest(bool isApproved) async {
    print(this.index);
    print(jsonEncode({"approvinguid": User.uid, "tobeapproveduid": index}));
    await http.post(url + "/handleAccessRequests", body: {
      "approvinguid": User.uid,
      "tobeapproveduid": pendingReq["uid"],
      "reqid": index.toString(),
      "toBeApproved": isApproved.toString()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              pendingReq["name"],
              style: GoogleFonts.abel(fontSize: 20),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              pendingReq["address"],
              style: GoogleFonts.abel(fontSize: 15),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              pendingReq["uid"],
              style: GoogleFonts.abel(fontSize: 20),
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
                  handleAccessRequest(true);
                },
                child: Text("Approve"),
                color: Colors.blueGrey,
              ),
              RaisedButton(
                onPressed: () {
                  handleAccessRequest(false);
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
