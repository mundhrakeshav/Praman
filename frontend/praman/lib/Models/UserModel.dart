import 'package:praman/Services/contractData.dart';

class User {
  static String name;
  static String uid;
  static String address;

  static Future getUserData() async {
    await ContractData.getUserData(address);
  }
}
