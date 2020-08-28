import 'dart:convert';

import 'package:http/http.dart' as http;

class ContractData {
  static const String contractAddress =
      "0xfe2cfe2a9c29a08f909ce55b718a18f79c8e7f37";
// https://beta-api.ethvigil.com/v1.0/contract/
  static const String ethVigilBaseURL =
      "https://mainnet-api.maticvigil.com/v1.0/contract/" + contractAddress;

  static Future getStudentData(String address) async {
    http.Response response =
        await http.get(ethVigilBaseURL + "/getStudent/" + address);

    Map data = jsonDecode(response.body);
    return data["data"];
  }

  static Future<String> getCertifier(String uid) async {
    http.Response response =
        await http.get(ethVigilBaseURL + "/orgUIDToOrganization/" + uid);

    return response.body;
  }
}
