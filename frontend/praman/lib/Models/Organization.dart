import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:praman/Services/contractData.dart';
import 'package:praman/Services/sharedPref.dart';

import '../Services/helper.dart';
import 'package:http/http.dart' as http;
import 'package:praman/Services/networkConfig.dart';

class Organization extends ChangeNotifier {
  static String name;
  static String uid;
  static String address;
  static String type;
  List<PendingRequest> pendingRequests = [];
  bool isLoading = false;

  getPendingRequests() async {
    isLoading = true;
    http.Response response =
        await http.get(url + "/getPendingReqs", headers: {"address": address});
    List pendingReqs = jsonDecode(response.body);

    for (var element in pendingReqs) {
      Map data = await HelperFunctions.getDataFromIpfs(element["ipfsHash"]);

      Map response =
          await HelperFunctions.getStudentDataServer(element["userAddress"]);

      pendingRequests.add(PendingRequest(
          title: element["title"],
          userAddress: element["userAddress"],
          details: data["details"],
          image: data["image"],
          requestRecordCount: element["requestRecordCount"],
          gpa: element["gpa"],
          requestRecordUID: response["uid"],
          requestingUserName: response["name"]));
    }

    isLoading = false;
    notifyListeners();
  }

  Organization() {
    getPendingRequests();
  }

  Future handleRequest(int index, String userAddress, String isApproved,
      String requestRecordCount) async {
    String token = await SharedPref.getOrganizationToken();
    http.Response response =
        await http.post(url + "/validateAcademicRecord", body: {
      "address": userAddress,
      "index": index.toString(),
      "isApproved": isApproved,
      "token": token,
      "requestRecordCount": requestRecordCount,
    });

    print(index);
  }
}

class PendingRequest {
  String title;
  String details;
  String image;
  String userAddress;
  String requestingUserName;
  String requestRecordCount;
  String requestRecordUID;
  String gpa;

  PendingRequest({
    this.title,
    this.image,
    this.details,
    this.requestRecordUID,
    this.requestRecordCount,
    this.userAddress,
    this.gpa,
    this.requestingUserName,
  });
}

class RequestingUser {
  String name;
}
