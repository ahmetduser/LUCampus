import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:lu_campus/data/event_api.dart';
import 'package:lu_campus/screens/settings_screen.dart';
import '../data/filter_api.dart';
import '../shared/menu_bottom.dart';
import 'navigation_screen.dart';

class EventScreen extends StatefulWidget {
  final User user;

  const EventScreen({super.key, required this.user});

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late Future<List<dynamic>> response;
  late Future<List<dynamic>> attendingEvents;
  String _eventName = "null";
  String _roomNumber = "111";
  final _studentId = "M008172";
  String button = "Join";
  int numberOfAttendance = 0;

  late User _currentUser;
  late String _userUID;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
    _userUID = _currentUser.uid;
    attendingEvents = EventApi.fetchAttendingEvents(_studentId);
    response = EventApi.fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red[900],
          shadowColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Column(children: [
              Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.fromLTRB(15, 0, 5, 15),
                child: ListTile(
                  title: Text(
                    "Events",
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
              TabBar(indicatorColor: Colors.white, tabs: [
                Tab(icon: Icon(Icons.join_full, color: Colors.grey[200])),
                Tab(icon: Icon(Icons.cancel, color: Colors.grey[200])),
              ]),
            ]),
          ),
        ),
        bottomNavigationBar: MenuBottom(
          index: 3,
          user: _currentUser,
        ),
        body: TabBarView(children: [
          FutureBuilder(
            future: response,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      margin: EdgeInsets.zero,
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[200]!))),
                            padding: EdgeInsets.only(top: 4),
                            child: ListTile(
                              title: Text("${snapshot.data[index]['name']}"),
                              trailing: Text(
                                  "Subject: ${snapshot.data[index]['subject']} \n"
                                  "Slots: ${snapshot.data[index]['attending']} / ${snapshot.data[index]['slots']}"),
                              subtitle: Text(
                                  "Room Number: ${snapshot.data[index]['roomNumber']}"),
                              onTap: () async {
                                _eventName = snapshot.data[index]['name'];
                                _roomNumber =
                                    snapshot.data[index]['roomNumber'];
                                if (await isAttending(_studentId, _eventName)) {
                                  print("He is attending");
                                  button = "Leave";
                                } else {
                                  button = "Join";
                                }
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildPopupDialog(
                                          context,
                                          _roomNumber,
                                          _eventName,
                                          isAttending(_studentId, _eventName)),
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
          FutureBuilder(
            future: attendingEvents,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                print("Checkpoint: attending events snapshot is not empty");
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    print("Checkpoint: building ListView.builder");
                    return Card(
                      margin: EdgeInsets.zero,
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[200]!))),
                            padding: EdgeInsets.only(top: 4),
                            child: ListTile(
                              title: Text("${snapshot.data[index]['name']}"),
                              trailing: Text(
                                  "Subject: ${snapshot.data[index]['subject']} \n"
                                  "Slots: ${snapshot.data[index]['attending']} / ${snapshot.data[index]['slots']}"),
                              subtitle: Text(
                                  "Room Number: ${snapshot.data[index]['roomNumber']}"),
                              onTap: () async {
                                _eventName = snapshot.data[index]['name'];
                                _roomNumber =
                                    snapshot.data[index]['roomNumber'];
                                if (await isAttending(_studentId, _eventName)) {
                                  button = "Leave";
                                } else {
                                  button = "Join";
                                }
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildPopupDialog(
                                          context,
                                          _roomNumber,
                                          _eventName,
                                          isAttending(_studentId, _eventName)),
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
        ]),
      ),
    );
  }

  Future<bool> isAttending(String studentId, String eventName) {
    print("Checkpoint: isAttending is called: ");
    return FilterApi.checkAttendance(studentId, eventName);
  }

  int getNumberOfAttendance(String eventName) {
    late int res = 0;
    EventApi.getAttendanceCount(eventName).then((value) {
      res = value;
    });
    return res;
  }

  Widget _buildPopupDialog(BuildContext context, String roomNumber, String name,
      Future<bool> isAttending) {
    return AlertDialog(
      title: Text("Welcome To $name"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                child: InkWell(
                  child: Text("It is in room $roomNumber"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigationScreen(
                            roomNumber: roomNumber,
                            user: _currentUser,
                          ),
                        ));
                  },
                ),
              )
            ],
          ),
        ],
      ),
      actions: <Widget>[
        CloseButton(onPressed: () {
          Navigator.of(context).pop();
        }),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
          child: FloatingActionButton.extended(
            label: Text(button),
            backgroundColor: Colors.red[900],
            hoverColor: Colors.red[900],
            // not implemented
            onPressed: () {
              if (button == "Join") {
                EventApi.joinEvent(_studentId, _eventName);
                Navigator.of(context, rootNavigator: true).pop();
                _showToast(name, context, true);
              } else {
                EventApi.leaveEvent(_studentId, _eventName);
                Navigator.of(context, rootNavigator: true).pop();
                _showToast(name, context, false);
              }
            },
          ),
        ),
      ],
    );
  }

  _showToast(String name, BuildContext context, bool joined) {
    if (joined) {
      Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.green[200],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check),
            const SizedBox(
              width: 12.0,
            ),
            Flexible(child: Text("Successfully joined $name")),
          ],
        ),
      );

      FToast().init(context).showToast(
            child: toast,
            gravity: ToastGravity.TOP,
            toastDuration: Duration(seconds: 2),
            /*positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 16.0,
            left: 16.0,
          );}*/
          );
    } else {
      Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.red[100],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.close),
            const SizedBox(
              width: 12.0,
            ),
            Flexible(child: Text("No longer attending $name")),
          ],
        ),
      );

      FToast().init(context).showToast(
            child: toast,
            gravity: ToastGravity.TOP,
            toastDuration: Duration(seconds: 2),
            /*positionedToastBuilder: (context, child) {
              return Positioned(
                child: child,
                top: 16.0,
                left: 16.0,
              );}*/
          );
    }
  }
}
