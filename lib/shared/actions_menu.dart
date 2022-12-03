import 'package:flutter/material.dart';
import '../screens/settings_screen.dart';

class ActionsMenu extends StatefulWidget {
  const ActionsMenu();

  @override
  _ActionsMenuState createState() => _ActionsMenuState();
}

class _ActionsMenuState extends State<ActionsMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingScreen()));
      },
    );
  }
}
