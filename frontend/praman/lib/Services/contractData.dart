import 'dart:convert';

import 'package:http/http.dart' as http;

class ContractData {
  static const String contractAddress =
      "0xdb7585f2771037eb8c561cca74b95206463f6416";

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
}
