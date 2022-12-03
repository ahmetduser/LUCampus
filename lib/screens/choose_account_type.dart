import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lu_campus/screens/student_user_details.dart';
import 'package:lu_campus/screens/teacher_user_details.dart';

class ChooseAccount extends StatefulWidget {
  final User user;

  const ChooseAccount({Key? key, required this.user});

  @override
  State<ChooseAccount> createState() => _ChooseAccountState();
}

class _ChooseAccountState extends State<ChooseAccount> {
  late User _currentUser;
  final double fontSize = 18;
  bool isStudent = true;
  bool isTeacher = false;

  late List<bool> isSelected;

  @override
  void initState() {
    _currentUser = widget.user;
    isSelected = [isStudent, isTeacher];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Account"),
      ),
      body: Center(
        // allows scrolling when does not fit in the screen
        child: Stack(
          children: [
            Align(
              child: ToggleButtons(
                  borderRadius: BorderRadius.circular(50),
                  fillColor: Colors.lightBlue,
                  selectedColor: Colors.white,
                  textStyle: TextStyle(
                      fontSize: fontSize, fontWeight: FontWeight.w600),
                  isSelected: isSelected,
                  onPressed: toggleMeasure,
                  children: const [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                      child: Text("Student"),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                      child: Text("Teacher"),
                    )
                  ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 45, vertical: 200),
                child: ElevatedButton(
                  child: const Text('Proceed'),
                  onPressed: () {
                    if (isStudent == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  StudentUserDetails(user: _currentUser)));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  TeacherUserDetails(user: _currentUser)));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toggleMeasure(value) {
    if (value == 0) {
      isStudent = true;
      isTeacher = false;
    } else {
      isStudent = false;
      isTeacher = true;
    }
    setState(() {
      isSelected = [isStudent, isTeacher];
    });
  }
}
