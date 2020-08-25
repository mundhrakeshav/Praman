import 'dart:convert';

import 'package:http/http.dart' as http;

class ContractData {
  static const String contractAddress =
      "0xa9a7d58501dac00043f55c59849b5ee99a4f7653";

//https://beta-api.ethvigil.com/v1.0/contract/0x50e5743c2b5895bc27d9b99d3fa68dd646c2d013/getStudent/

  static const String ethVigilBaseURL =
      "https://beta-api.ethvigil.com/v1.0/contract/" + contractAddress;

  static Future getUserData(String address) async {
    print(address);

    http.Response response =
        await http.get(ethVigilBaseURL + "/getStudent/" + address);

    Map data = jsonDecode(response.body);
    print(data);
  }

  static Future<String> getCertifier(String uid) async {
    http.Response response =
        await http.get(ethVigilBaseURL + "/orgUIDToOrganization/" + uid);

    return response.body;
  }
}
