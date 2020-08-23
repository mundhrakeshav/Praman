import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:praman/Models/Organization.dart';
import 'package:praman/Models/UserModel.dart';
import 'package:praman/Services/sharedPref.dart';

import 'networkConfig.dart';

abstract class AuthBase {
  Future loginInstitution();
  Future loginStudent();
  Future registerStudent();
  Future registerInstitution();
}

class Auth implements AuthBase {
  @override
  Future loginStudent({String uid, String password}) async {
    print("loginStudent From auth.dart");
    http.Response response = await http
        .post(url + "/loginStudent", body: {"uid": uid, "password": password});
    Map data = jsonDecode(response.body);
    if (!data["success"]) {
      throw PlatformException(code: "ERROR", message: data["message"]);
    } else {
      print(data);
      User.address = data["address"];
      User.name = data["name"];
      User.uid = data["uid"];
      await SharedPref.setStudentData(
        data["token"],
        data["name"],
        data["uid"],
        data["address"],
      );
    }
  }

  @override
  Future loginInstitution({String uid, String password}) async {
    print("loginOrg From auth.dart");

    http.Response response = await http.post(url + "/loginOrganization", body: {
      "uid": uid,
      "password": password,
    });
    Map data = jsonDecode(response.body);

    if (!data["success"]) {
      throw PlatformException(
        code: "ERROR",
        message: data["message"],
      );
    } else {
      print(data);
      Organization.address = data["address"];
      Organization.name = data["name"];
      Organization.uid = data["uid"];
      Organization.type = data["type"];
      await SharedPref.setOrganizationData(
        data["token"],
        data["name"],
        data["uid"],
        data["address"],
        data["type"],
      );
    }
  }

  @override
  Future registerStudent({String uid, String password, String name}) async {
    print("registerStudent From auth.dart");
    http.Response response = await http.post(url + "/registerStudent", body: {
      "uid": uid,
      "password": password,
      "name": name,
    });
    Map data = jsonDecode(response.body);

    print(data);
    if (!data["success"]) {
      throw PlatformException(code: "ERROR", message: data["message"]);
    } else {}
  }

  @override
  Future registerInstitution(
      {String uid, String password, String type, String name}) async {
    print("registerOrganization From auth.dart");

    http.Response response =
        await http.post(url + "/registerOrganization", body: {
      "uid": uid,
      "password": password,
      "type": type,
      "name": name,
    });
    Map data = jsonDecode(response.body);

    print(data);
    if (!data["success"]) {
      throw PlatformException(code: "ERROR", message: data["message"]);
    } else {}
  }

  Future<bool> logOut() async {
    SharedPref.clearToken();
  }
}
