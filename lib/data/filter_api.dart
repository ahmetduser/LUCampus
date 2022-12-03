import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

import '../models/event.dart';
import '../models/room.dart';

class FilterApi {
  // static Future<Room> getRoom(int i) async {
  //   final response = await http.get(
  //       Uri.parse('http://10.0.2.2:8090/api/v1/lucampus/filter/filterRoomFloor/$i'));
  //
  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     return Room.fromJson(jsonDecode(response.body));
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load room');
  //   }
  // }

  static Future<List<dynamic>> filterFloor(int i) async {
    var result = await http.get(Uri.parse(
        'http://10.0.2.2:8074/api/v1/lucampus/filter/filterRoomFloor/$i'));
    return jsonDecode(result.body);
  }

  static Future<bool> checkAttendance(String studentId, String event) async {
    var result = await http.get(Uri.parse(
        'http://10.0.2.2:8074/api/v1/lucampus/filter/filterAttendingEvent/$event/$studentId'));
    return jsonDecode(result.body);

  }
}
