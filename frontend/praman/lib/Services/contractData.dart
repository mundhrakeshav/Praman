import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:praman/Services/networkConfig.dart';

class ContractData {
  static const String contractAddress =
      "0xa97419d988114574a05a7981246aba7dfe666005";

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
