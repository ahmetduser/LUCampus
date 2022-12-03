import 'package:http/http.dart' as http;
import 'dart:convert';

import '../usermodels/student.dart';

class StudentApi {
  static Future<List<dynamic>> fetchStudentList() async {
    var result = await http
        .get(Uri.parse('http://10.0.2.2:8084/api/v1/lucampus/student'));
    return jsonDecode(result.body);
  }

  static Future<http.Response> saveStudentDetails(Student s) async {
    return http.post(
      Uri.parse('http://10.0.2.2:8084/api/v1/lucampus/student/createStudent'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(s.toJson()),
    );
  }

  static Future<Student> findStudentWithAuthId(String authId) async {
    var result = await http.get(Uri.parse(
        'http://10.0.2.2:8084/api/v1/lucampus/student/findStudent/$authId'));
    return jsonDecode(result.body);
  }
}
