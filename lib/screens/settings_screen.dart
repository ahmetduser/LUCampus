import 'package:flutter/material.dart';
import 'package:lu_campus/screens/room_screen.dart';

import '../shared/actions_menu.dart';
import '../shared/menu_bottom.dart';
import 'home_page.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.red[900],
          shadowColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.fromLTRB(5, 0, 20, 15),
              child: ListTile(
                title: Container(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    "Settings",
                    style: TextStyle(
                        color: Colors.grey[200],
                        fontSize:35,
                        letterSpacing: 0.1,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Divider(),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Text("Sign Out"),
          ),
        ],
      ),
    );
  }
}
