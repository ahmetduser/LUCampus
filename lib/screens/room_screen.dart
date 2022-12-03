import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lu_campus/data/room_api.dart';
import 'package:lu_campus/screens/settings_screen.dart';
import 'package:lu_campus/screens/navigation_screen.dart';
import '../data/filter_api.dart';
import '../shared/actions_menu.dart';
import '../shared/menu_bottom.dart';

class RoomScreen extends StatefulWidget {
  late User user;

  RoomScreen({super.key, required this.user});

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  late Future<List<dynamic>> response;
  late User _currentUser;
  late String _userUID;

  int _value = 0;
  String _roomNumber = "111";

  @override
  void initState() {
    _currentUser = widget.user;
    _userUID = _currentUser.uid;
    super.initState();
    response = RoomApi.fetchRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red[900],
          shadowColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.fromLTRB(15, 0, 5, 15),
              child: ListTile(
                title: Text(
                  "Rooms",
                  style: TextStyle(
                      color: Colors.grey[200],
                      fontSize: 35,
                      letterSpacing: 0.1,
                      fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.settings, color: Colors.grey[200]),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingScreen()));
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: MenuBottom(index: 2, user: _currentUser),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(12, 5, 5, 5),
                margin: EdgeInsets.only(top: 20),
                child: DropdownButton(
                    style: const TextStyle(
                      color: Color.fromRGBO(48, 62, 86, 1),
                      fontSize: 15,
                      letterSpacing: 0.1,
                    ),
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Colors.red.shade50,
                    ),
                    focusColor: Colors.red[900],
                    value: _value,
                    items: const [
                      DropdownMenuItem(
                        value: 0,
                        child: Text("Select Floor"),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text("Floor 1"),
                      ),
                      DropdownMenuItem(
                        value: 6,
                        child: Text("Floor 6"),
                      ),
                      DropdownMenuItem(
                        value: 7,
                        child: Text("Floor 7"),
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        if (value == 0) {
                          response = RoomApi.fetchRooms();
                          _value = value!;
                        } else {
                          response = FilterApi.filterFloor(value!);
                          _value = value;
                        }
                      });
                    }),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: FutureBuilder(
                  future: response,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            margin: EdgeInsets.zero,
                            child: Column(
                              children: [
                                Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]!))),
                                  padding: EdgeInsets.only(top: 4),
                                  child: ListTile(
                                    horizontalTitleGap: 10,
                                    tileColor: Colors.white,
                                    hoverColor: Colors.deepPurple[50],
                                    title: Text(
                                        "Room Number: ${snapshot.data[index]['roomNumber']}",
                                        style: TextStyle(
                                            color: Colors.blueGrey.shade400,
                                            wordSpacing: 0.001,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                    trailing: Text(
                                        "Capacity: ${snapshot.data[index]['capacity']}"),
                                    subtitle: Text(
                                        "Floor: ${snapshot.data[index]['floor']}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            wordSpacing: 0.001,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17)),
                                    onTap: () {
                                      _roomNumber =
                                          snapshot.data[index]['roomNumber'];
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            _buildPopupDialog(
                                                context, _roomNumber),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context, String roomNumber) {
    return AlertDialog(
      title: Text("Go To Room: $roomNumber"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        /*children: <Widget>[
          Image.asset("assets/images/$roomNumber.png"),
        ],*/
      ),
      actions: <Widget>[
        CloseButton(onPressed: () {
          Navigator.of(context).pop();
        }),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
          child: FloatingActionButton.extended(
            label: Text("Go"),
            backgroundColor: Colors.red[900],
            hoverColor: Colors.red[900],
            onPressed: () {
              // take to the navigation
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NavigationScreen(
                            roomNumber: roomNumber,
                            user: _currentUser,
                          )));
            },
          ),
        ),
      ],
    );
  }
}
