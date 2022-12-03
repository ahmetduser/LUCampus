import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

import '../models/event.dart';

class EventApi {
  static Future<Event> getEvent(int i) async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8072/api/v1/lucampus/event/findEvent/$i'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Event.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load event');
    }
  }

  static Future<http.Response> joinEvent(String studentId, String eventName) {
    return http.post(
      Uri.parse(
          'http://10.0.2.2:8076/api/v1/lucampus/attendance/addAttendance/$eventName'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'studentId': studentId,
      }),
    );
  }

  static Future<http.Response> leaveEvent(String studentId, String eventName) {
    return http.delete(
      Uri.parse(
          'http://10.0.2.2:8076/api/v1/lucampus/attendance/removeAttendance/$eventName'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'studentId': studentId,
      }),
    );
  }

  static Future<List<dynamic>> fetchAttendingEvents(String studentId) async {
    var result = await http.get(Uri.parse(
        'http://10.0.2.2:8076/api/v1/lucampus/attendance/getAttendingEvents/$studentId'));
    return jsonDecode(result.body);
  }

  static Future<int> getAttendanceCount(String eventName) async {
    var result = await http.get(Uri.parse(
        'http://10.0.2.2:8076/api/v1/lucampus/attendance/getNumberOfAttendance/$eventName'));
    return jsonDecode(result.body);
  }

  static Future<List<dynamic>> fetchEvents() async {
    var result =
        await http.get(Uri.parse('http://10.0.2.2:8072/api/v1/lucampus/event'));
    return jsonDecode(result.body);
  }
}
