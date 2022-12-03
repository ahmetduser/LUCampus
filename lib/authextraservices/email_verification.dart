import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lu_campus/screens/choose_account_type.dart';

import '../data/fire_auth.dart';
import '../screens/teacher_user_details.dart';

class EmailVerification extends StatefulWidget {
  final User user;

  const EmailVerification({super.key, required this.user});

  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool _isSendingVerification = false;

  bool isVerified = false;

  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NAME: ${_currentUser.displayName}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 16.0),
            Text(
              'EMAIL: ${_currentUser.email}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 16.0),
            _currentUser.emailVerified
                ? Text(
                    'Email verified',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.green),
                  )
                : Text(
                    'Email not verified',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.red),
                  ),
            const SizedBox(height: 16.0),
            _isSendingVerification
                ? const CircularProgressIndicator()
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            fixedSize:
                                MaterialStateProperty.all<Size>(Size(140, 40))),
                        onPressed: () async {
                          setState(() {
                            _isSendingVerification = true;
                          });
                          await _currentUser.sendEmailVerification();
                          setState(() {
                            _isSendingVerification = false;
                          });
                        },
                        child: Text('Verify email'),
                      ),
                      SizedBox(width: 8.0),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () async {
                          User? user = await FireAuth.refreshUser(_currentUser);

                          if (user != null) {
                            setState(() {
                              _currentUser = user;
                            });
                          }
                        },
                      ),
                    ],
                  ),
            const SizedBox(height: 16.0),
            MaterialButton(
              minWidth: 360,
              height: 60,
              onPressed: () {
                if (_currentUser.emailVerified == true) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ChooseAccount(user: _currentUser)));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Email is not verified')));
                }
              },
              color: const Color(0xff0095FF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: const Text(
                'Proceed To Enter Details',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
