import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:lu_campus/data/room_api.dart';
import 'package:lu_campus/models/room.dart';

void main() {

  late Future<Room> room;
  late Future<dynamic> allRooms;
  List<Room> rooms = [
    Room(id: 1, roomNumber: '123', capacity: 24, floor: 6),
    Room(id: 4, roomNumber: '712', capacity: 89, floor: 1),
    Room(id: 5, roomNumber: '112', capacity: 12, floor: 1),
    Room(id: 8, roomNumber: '743', capacity: 12, floor: 7)];

  var indexes = [1, 4, 5, 8];

  group('fetching rooms correctly', () {

    setUp(() {
      allRooms = RoomApi.fetchRooms();
    });

    test('rooms should be fetched correctly', () {    //test fetching of 4 random rooms correctly
      for(int i=0; i< 4; i++){
        room = RoomApi.getRoom(indexes[i]);
        room.then((value) {
          expect(value, rooms[i]);
        });
      }
    });

    test('all rooms should be fetched', () => {       //test fetching of all rooms
      allRooms.then((value) => {
        expect(value.length, 9)
      })
    });

  });


}