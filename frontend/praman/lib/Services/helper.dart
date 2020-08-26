import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:praman/Services/networkConfig.dart';

class HelperFunctions {
  static Future getDataFromIpfs(String hash) async {
    http.Response response = await http.get(ipfs + hash);
    return jsonDecode(response.body);
  }

  static Future getStudentDataServer(String address) async {
    print(address);
    http.Response response = await http
        .get(url + "/getStudentDetails", headers: {"address": address});

    Map data = jsonDecode(response.body);

    return data;
  }

  static Future getCertifierDataServer(String uid) async {
    http.Response response =
        await http.get(url + "/getOrganizationDetails", headers: {"uid": uid});

    Map data = jsonDecode(response.body);

    return data;
  }
}