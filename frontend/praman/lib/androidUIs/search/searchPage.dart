import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:praman/Services/helper.dart';
import 'package:praman/Widgets/setSnackBar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchInputController = TextEditingController();

  TextField searchInput(BuildContext context) {
    return TextField(
      controller: _searchInputController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54),
          ),
          labelText: "Search with certifier ID",
          labelStyle: TextStyle(color: Colors.white70),
          suffix: IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              Map data = await HelperFunctions.searchStudent(
                  _searchInputController.text);

              if (data["success"]) {
                print(true);
              } else {
                if (data["errorCode"] == 0) {
                  Scaffold.of(context).showBottomSheet((context) => BottomSheet(
                        onClosing: () {},
                        builder: (context) =>
                            ErrBottomSheet(data, _searchInputController.text),
                      ));
                  print("object");
                } else {
                  Scaffold.of(context)
                      .showSnackBar(setSnackBar(data["message"]));
                }
              }
            },
          )),
      maxLength: 12,
      style: TextStyle(fontSize: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            searchInput(context),
          ],
        ),
      ),
    );
  }
}

class ErrBottomSheet extends StatelessWidget {
  final Map data;
  final String uid;
  ErrBottomSheet(this.data, this.uid);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      color: Colors.black38,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            data["message"],
            style: GoogleFonts.montaga(fontSize: 20),
          ),
          RaisedButton(
            onPressed: () {},
            color: Colors.white30,
            child: Text("Request Access"),
          )
        ],
      ),
    );
  }
}
