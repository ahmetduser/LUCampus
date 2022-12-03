import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lu_campus/screens/settings_screen.dart';
import '../shared/menu_bottom.dart';

class MainPage extends StatefulWidget {
  final User user;

  const MainPage({super.key, required this.user});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late User _currentUser;
  late String _userUID;

  @override
  void initState() {
    _currentUser = widget.user;
    _userUID = _currentUser.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.red[900],
          automaticallyImplyLeading: false,
          shadowColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.fromLTRB(15, 0, 5, 15),
              child: ListTile(
                title: Text(
                  "Home Page",
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
                            builder: (context) => const SettingScreen()));
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: MenuBottom(
        index: 1,
        user: _currentUser,
      ),
      body: Column(
        children: [
          Text(_userUID),
        ],
      ),
    );
  }
}
