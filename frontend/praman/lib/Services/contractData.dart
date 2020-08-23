import 'dart:convert';

import 'package:http/http.dart' as http;

class ContractData {
  static const String contractAddress =
      "0x50e5743c2b5895bc27d9b99d3fa68dd646c2d013";
  static const String ethVigilBaseURL =
      "https://beta-api.ethvigil.com/v0.1/contract/$contractAddress";

  static Future getUserData(String address) async {
    http.Response response =
        await http.get("$ethVigilBaseURL​/addressToOrganization​/$address");

    Map data = jsonDecode(response.statusCode.toString());
    print(response.statusCode.toString());
  }
}
