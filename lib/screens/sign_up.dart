import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lu_campus/authextraservices/email_verification.dart';
import '../data/fire_auth.dart';
import '../utilities/validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _registerFormKey = GlobalKey<FormState>();

  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final TextEditingController txtConfirmPassword = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusConfirmPassword = FocusNode();

  final double fontSize = 18;

  bool _isProcessing = false;
  bool _hidePassword = true;
  bool _hideconfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
        _focusConfirmPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
          backgroundColor: Color.fromARGB(255, 154, 2, 2),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'Welcome To LU-Campus',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 24,
                    bottom: 10,
                  ),
                  child: Form(
                      key: _registerFormKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: txtEmail,
                            focusNode: _focusEmail,
                            validator: (value) => Validator.validateEmail(
                              email: value!,
                            ),
                            decoration: InputDecoration(
                              /*focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Color.fromARGB(
                                    68, 98, 0, 0), width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),*/
                              prefixIcon: Icon(Icons.mail),
                              labelText: 'Email',
                              helperText: '',
                              hintText: 'myEmail@outlook.com',
                            ),
                          ),
                          SizedBox(height: 12.0),
                          TextFormField(
                            controller: txtPassword,
                            focusNode: _focusPassword,
                            obscureText: _hidePassword,
                            validator: (value) => Validator.validatePassword(
                              password: value!,
                            ),
                            decoration: InputDecoration(
                              /*focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Color.fromARGB(
                                    68, 98, 0, 0), width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),*/
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'Password',
                              helperText: '',
                              hintText: 'My Password',
                              suffixIcon: InkWell(
                                onTap: _passwordView,
                                child: _hidePassword
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          TextFormField(
                            controller: txtConfirmPassword,
                            focusNode: _focusConfirmPassword,
                            obscureText: _hideconfirmPassword,
                            validator: (value) =>
                                Validator.validateConfirmPassword(
                                    confirmPassword: value!,
                                    Password: txtPassword.text),
                            decoration: InputDecoration(
                              /*focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Color.fromARGB(
                                    68, 98, 0, 0), width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),*/
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'Confirm Password',
                              helperText: '',
                              hintText: 'Repeat Password',
                              suffixIcon: InkWell(
                                onTap: _confirmPasswordView,
                                child: _hideconfirmPassword
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          _isProcessing
                              ? CircularProgressIndicator(color:Color.fromARGB(255, 154, 2, 2))
                              : Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (_registerFormKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              _isProcessing = true;
                                            });
                                            User? user = await FireAuth
                                                .registerUsingEmailPassword(
                                              name: 'LuCampus User',
                                              email: txtEmail.text,
                                              password: txtPassword.text,
                                            );

                                            setState(() {
                                              _isProcessing = false;
                                            });

                                            if (user != null) {
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EmailVerification(
                                                          user: user),
                                                ),
                                                ModalRoute.withName('/'),
                                              );
                                            }
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color.fromARGB(255, 154, 2, 2)
                                        ),
                                        child: const Text(
                                          'Sign up',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _passwordView() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  void _confirmPasswordView() {
    setState(() {
      _hideconfirmPassword = !_hideconfirmPassword;
    });
  }
}
