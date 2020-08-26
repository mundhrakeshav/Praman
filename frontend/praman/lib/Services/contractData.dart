import 'dart:convert';

import 'package:http/http.dart' as http;

class ContractData {
  static const String contractAddress =
      "0x45143d7258e5652bc9a85c0db202a8700f642cd7";

  static const String ethVigilBaseURL =
      "https://beta-api.ethvigil.com/v1.0/contract/" + contractAddress;

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
