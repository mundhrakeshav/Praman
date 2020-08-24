import 'package:praman/Services/networkConfig.dart';
import 'package:praman/Services/sharedPref.dart';
import 'package:http/http.dart' as http;

abstract class AddRecordsBase {
  addAcademicRecords({
    String title,
    String details,
    String organizationID,
    String gpa,
    String image,
  });
}

class AddRecords implements AddRecordsBase {
  addAcademicRecords({
    String title,
    String details,
    String organizationID,
    String gpa,
    String image,
  }) async {
    print("object");
    String token = await SharedPref.getStudentToken();

    http.Response resp = await http.post(url + "/addAcademicRecord", body: {
      "token": token,
      "title": title,
      "details": details,
      "orgainzationID": organizationID,
      "gpa": gpa,
      "image": image,
    });

    print(resp.body);
  }
}
