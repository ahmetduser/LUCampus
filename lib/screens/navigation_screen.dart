import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'map_screen.dart';
import '../shared/actions_menu.dart';
import '../shared/menu_bottom.dart';
import 'location_coordinate.dart';

class NavigationScreen extends StatefulWidget {
  final String roomNumber;
  final User user;

  const NavigationScreen(
      {super.key, required this.roomNumber, required this.user});

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late String _currentRoom;
  late User _currentUser;
  late String _userUID;

  @override
  void initState() {
    _currentUser = widget.user;
    _userUID = _currentUser.uid;
    _currentRoom = widget.roomNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "LU Campus",
          style: TextStyle(color: Colors.grey[200]),
        ),
        backgroundColor: Colors.red[900],
      ),
      bottomNavigationBar: MenuBottom(
        index: 1,
        user: _currentUser,
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(top: 250),
            child: Column(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red[900])),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const CampusMap()));
                  },
                  child: const Text(
                    "Map",
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red[900])),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const LocationApp()));
                  },
                  child: const Text(
                    "Location",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
