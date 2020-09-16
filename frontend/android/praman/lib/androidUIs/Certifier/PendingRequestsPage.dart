import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:praman/Models/Organization.dart';
import 'package:praman/androidUIs/Certifier/pendingRequestDetails.dart';
import 'package:provider/provider.dart';

class PendingRequests extends StatelessWidget {
  Card pendingCard(PendingRequest request) {
    return Card(
      child: Container(
        height: 40,
        child: Text(
          "data",
          style: GoogleFonts.actor(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Organization orgProvider = Provider.of<Organization>(context);

    return Scaffold(
      body: Center(
        child: orgProvider.isLoading
            ? CircularProgressIndicator()
            : orgProvider.pendingRequests.isEmpty
                ? Center(
                    child: Text("No Pending Requests"),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) => PendingRequestCard(
                        orgProvider.pendingRequests[index], index),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: orgProvider.pendingRequests.length,
                  ),
      ),
    );
  }
}

class PendingRequestCard extends StatelessWidget {
  final PendingRequest request;
  final int index;
  PendingRequestCard(this.request, this.index);

  @override
  Widget build(BuildContext context) {
    Organization orgProvider = Provider.of<Organization>(context);

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PendingRequestDetailed(request, index),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 7),
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.title,
                  style: GoogleFonts.actor(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20),
                AutoSizeText(
                  request.details,
                  maxFontSize: 18,
                  minFontSize: 15,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          request.requestingUserName,
                          style: GoogleFonts.actor(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          request.requestRecordUID,
                          style: GoogleFonts.actor(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Text(
                      "GPA: " + request.gpa,
                      style: GoogleFonts.actor(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  buttonMinWidth: MediaQuery.of(context).size.width * .3,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        print(request.requestRecordCount);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
