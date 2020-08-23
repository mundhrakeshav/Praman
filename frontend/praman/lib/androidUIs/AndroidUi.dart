import 'package:flutter/material.dart';
import 'package:praman/Services/sharedPref.dart';
import 'organizationLandingPage.dart';
import 'studentLandingPage.dart';
import 'studentLoginOrSIgnUp.dart';

class AndroidUi extends StatefulWidget {
  @override
  _AndroidUiState createState() => _AndroidUiState();
}

class _AndroidUiState extends State<AndroidUi> {
  bool isLoading = true;
  bool studentToken;
  bool organizationToken;

  getToken() async {
    studentToken = await SharedPref.isStudentTokenPresent();

    organizationToken = await SharedPref.isOrganizationTokenPresent();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (studentToken) {
      print("StudentToken");

      SharedPref.initialiseStudent();
      return StudentLanding();
    } else if (organizationToken) {
      print("organizationToken");
      SharedPref.initialiseOrganization();
      return Organizationlanding();
    } else {
      return StudentLoginOrSignupPage();
    }

    // return FutureBuilder(
    //     future: SharedPref.isTokenPresent(),
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData)
    //         return Center(child: CircularProgressIndicator());
    //       else {
    //         if (snapshot.data) {
    //           SharedPref.initialise();
    //           return StudentLanding();
    //         }

    //         if (!snapshot.data) return StudentLoginOrSignupPage();
    //       }
    //     });
  }
}
