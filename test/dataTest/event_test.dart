import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:lu_campus/data/event_api.dart';
import 'package:lu_campus/data/filter_api.dart';
import 'package:lu_campus/data/room_api.dart';
import 'package:lu_campus/models/event.dart';
import 'package:http/http.dart' as http;

void main() {

  late Future<List<dynamic>>? allEvents;
  late Future<Event> getEvent;
  late Future<http.Response> leaveEvent;
  late Future<http.Response> joinEvent;

  group('testing events fetching', () {

    setUp(() =>
    allEvents = EventApi.fetchEvents()
    );

    setUp(() =>
        getEvent = EventApi.getEvent(3)
    );

    setUp(() =>
      joinEvent =EventApi.joinEvent('M098761', "Startup")
    );
    
    setUp(() => 
        leaveEvent =EventApi.leaveEvent('M098761', "Startup")
    );

    test('events should all be fetched', () => {            //test fetching all events
      allEvents?.then((value) => {
        expect(value.length, 3)
      })
    });

    test('events should be filtered correctly', () => {     //test filtering events based on ID
      getEvent.then((value) => {
        expect(value.name, 'Startup')
      })
    });

    test('student should be able to join events', () => {     //test joining event
      joinEvent.then((value) => {
        expect(value.statusCode, 200)
      })
    });

    test('student should be able to leave events', () => {     //test leaving event 
      leaveEvent.then((value) => {
        expect(value.statusCode, 200)
      })
    });

  });

}