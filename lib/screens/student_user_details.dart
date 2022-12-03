// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lu_campus/data/student_api.dart';
import 'package:lu_campus/data/teacher_api.dart';
import 'package:lu_campus/screens/main_page.dart';

import '../usermodels/student.dart';

class StudentUserDetails extends StatefulWidget {
  final User user;

  const StudentUserDetails({required this.user});

  @override
  _StudentUserDetailsState createState() => _StudentUserDetailsState();
}

class _StudentUserDetailsState extends State<StudentUserDetails> {
  late User _currentUser;

  // id is auto generated, authId is provided by FirebaseAuth
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtSurname = TextEditingController();
  final TextEditingController txtMail = TextEditingController();
  final TextEditingController txtMajor = TextEditingController();
  final TextEditingController txtStudentId = TextEditingController();

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
      appBar: AppBar(title: Text("Student Details")),
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
                  controller: txtMail,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextField(
                  controller: txtMajor,
                  decoration: InputDecoration(hintText: 'Major'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextField(
                  controller: txtStudentId,
                  decoration: InputDecoration(hintText: 'StudentId'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                minWidth: 360,
                height: 60,
                onPressed: () {
                  Student student = Student(
                      studentAuthId: userUID,
                      name: txtName.text,
                      surname: txtSurname.text,
                      email: txtMail.text,
                      major: txtMajor.text,
                      studentId: txtStudentId.text);
                  StudentApi.saveStudentDetails(student);
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
