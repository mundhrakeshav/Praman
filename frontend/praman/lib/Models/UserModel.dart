import 'package:praman/Services/contractData.dart';
import 'package:praman/Services/helper.dart';

class User {
  static String name;
  static String uid;
  static String address;
  static List<AcademicRecord> academicRecords = [];

  static Future getUserData() async {
    academicRecords.clear();
    List response = await ContractData.getStudentData(address);
    List academicRecordTemp = response[0]["academicRecord"];

    for (var element in academicRecordTemp) {
      Map response = await HelperFunctions.getDataFromIpfs(element[2]);
      Map org =
          await HelperFunctions.getCertifierDataServer(element[3].toString());

      academicRecords.add(
        AcademicRecord(
            title: element[0],
            gpa: element[1],
            details: response["details"],
            image: response["image"],
            validatorAddress: org["address"],
            validatorName: org["name"],
            isValidated: element[4]),
      );
    }
  }
}

class AcademicRecord {
  String title;
  String gpa;
  String details;
  String image;
  String validatorName;
  String validatorAddress;

  bool isValidated;

  AcademicRecord({
    this.title,
    this.details,
    this.gpa,
    this.image,
    this.isValidated,
    this.validatorName,
    this.validatorAddress,
  });
}
