// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lu_campus/data/teacher_api.dart';
import 'package:lu_campus/screens/main_page.dart';

import '../usermodels/teacher.dart';

class TeacherUserDetails extends StatefulWidget {
  final User user;

  const TeacherUserDetails({required this.user});

  @override
  _TeacherUserDetailsState createState() => _TeacherUserDetailsState();
}

class _TeacherUserDetailsState extends State<TeacherUserDetails> {
  late User _currentUser;

  // id is auto generated, authId is provided by FirebaseAuth
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtSurname = TextEditingController();
  final TextEditingController txtOffice = TextEditingController();
  final TextEditingController txtMajor = TextEditingController();

  final double fontSize = 18;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // feed this number to local mysql table
    final userUID = _currentUser.uid;
    return Scaffold(
      appBar: AppBar(title: Text("Teacher Details")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Welcome To LuCampus',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextField(
                  controller: txtName,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextField(
                  controller: txtSurname,
                  decoration: InputDecoration(hintText: 'Surname'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextField(
                  controller: txtOffice,
                  decoration: InputDecoration(hintText: 'Office'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextField(
                  controller: txtMajor,
                  decoration: InputDecoration(hintText: 'Major'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                minWidth: 360,
                height: 60,
                onPressed: () {
                  Teacher teacher = Teacher(
                      teacherAuthId: userUID,
                      name: txtName.text,
                      surname: txtSurname.text,
                      office: txtOffice.text,
                      major: txtMajor.text);
                  TeacherApi.saveTeacherDetails(teacher);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => MainPage(user: _currentUser),
                  ));
                },
                color: const Color(0xff0095FF),
                child: const Text('Save and Proceed'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
