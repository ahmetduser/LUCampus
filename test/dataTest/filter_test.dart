import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:lu_campus/data/filter_api.dart';
import 'package:lu_campus/data/room_api.dart';
import 'package:lu_campus/models/room.dart';

void main() {

  Future<List<dynamic>>? rooms;
  Future<bool>? isAttending;

  group('filter data correctly', () {

    setUp(() =>
        rooms = FilterApi.filterFloor(6)
    );

    setUp(() =>
      isAttending = FilterApi.checkAttendance("M009871", "Startup")
    );

    test('floors should be filtered correctly', () => {           //test fetching rooms on the same floor - testing one floor
      rooms?.then((value) =>
        expect(value.length, 3)
      )
    });

    test('attendance checking should be correct', () => {         //test if attendance check is correct with one student ID nad one event
      isAttending?.then((value) => {
        expect(value, false)
      })
    });

  });

}