import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

import '../models/room.dart';

class RoomApi {
  static Future<Room> getRoom(int i) async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8070/api/v1/lucampus/room/findRoom/$i'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Room.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load room');
    }
  }

  static Future<List<dynamic>> fetchRooms() async {
    var result =
        await http.get(Uri.parse('http://10.0.2.2:8070/api/v1/lucampus/room'));
    return jsonDecode(result.body);
  }
}
