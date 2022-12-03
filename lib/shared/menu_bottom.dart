// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lu_campus/screens/event_screen.dart';
import 'package:lu_campus/screens/main_page.dart';
import '../screens/room_screen.dart';

class MenuBottom extends StatefulWidget {
  final int index;
  final User user;

  const MenuBottom({required this.index, required this.user});

  @override
  _MenuBottomState createState() => _MenuBottomState();
}

class _MenuBottomState extends State<MenuBottom> {
  late int _index;
  late User _currentUser;
  late String _userUID;

  @override
  void initState() {
    _index = widget.index;
    _currentUser = widget.user;
    _userUID = _currentUser.uid;
    super.initState();
  }

  Color? getColor(int itemIndex) {
    if (itemIndex == _index) return Colors.red[900];
    return Colors.blueGrey.shade300;
  }

  double getIconSize(int itemIndex) {
    if (itemIndex == _index) return 27;
    return 25;
  }

  double getTextSize(int itemIndex) {
    if (itemIndex == _index) return 13;
    return 10;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.fromLTRB(25, 17, 25, 17),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              if (_index != 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MainPage(user: _currentUser)));
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.home,
                  color: getColor(1),
                  size: getIconSize(1),
                ),
                Text("Home",
                    style:
                        TextStyle(color: getColor(1), fontSize: getTextSize(1)))
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_index != 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => RoomScreen(user: _currentUser)));
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.room, color: getColor(2), size: getIconSize(2)),
                Text("Rooms",
                    style:
                        TextStyle(color: getColor(2), fontSize: getTextSize(2)))
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_index != 3) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => EventScreen(user: _currentUser)));
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.event, color: getColor(3), size: getIconSize(3)),
                Text("Event",
                    style:
                        TextStyle(color: getColor(3), fontSize: getTextSize(3)))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
