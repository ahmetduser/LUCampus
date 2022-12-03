import 'package:http/http.dart' as http;
import 'dart:convert';

import '../usermodels/teacher.dart';

class TeacherApi {
  static Future<List<dynamic>> fetchTeacherList() async {
    var result = await http
        .get(Uri.parse('http://10.0.2.2:8082/api/v1/lucampus/teacher'));
    return jsonDecode(result.body);
  }

  static Future<http.Response> saveTeacherDetails(Teacher t) async {
    return http.post(
      Uri.parse('http://10.0.2.2:8082/api/v1/lucampus/teacher/createTeacher'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(t.toJson()),
    );
  }

  static Future<Teacher> findTeacherWithAuthId(String authId) async {
    var result = await http.get(Uri.parse(
        'http://10.0.2.2:8082/api/v1/lucampus/teacher/findTeacher/$authId'));
    return jsonDecode(result.body);
  }
}
