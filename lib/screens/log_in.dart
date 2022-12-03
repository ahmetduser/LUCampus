import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lu_campus/screens/main_page.dart';
import 'package:lu_campus/screens/sign_up.dart';

import '../data/fire_auth.dart';
import '../utilities/validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String message = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign In'), backgroundColor: Color.fromARGB(255, 154, 2, 2),),
        body: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: ListView(
            children: [
              SizedBox(height: 170,),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10)
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: emailController,
                        focusNode: _focusEmail,
                        validator: (value) => Validator.validateEmail(
                          email: value!,
                        ),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Email',
                          helperText: '',
                          hintText: 'myEmail@outlook.com',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        controller: passwordController,
                        focusNode: _focusPassword,
                        obscureText: hidePassword,
                        validator: (value) => Validator.validatePassword(
                          password: value!,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Password',
                          helperText: '',
                          hintText: 'My Password',
                          suffixIcon: InkWell(
                            onTap: _passwordView,
                            child: hidePassword
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                        ),
                      ),
                    ),
                    _isProcessing
                        ? CircularProgressIndicator(color:Color.fromARGB(255, 154, 2, 2))
                        : Column(
                            children: <Widget>[
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    _focusEmail.unfocus();
                                    _focusPassword.unfocus();

                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _isProcessing = true;
                                      });

                                      User? user = await FireAuth
                                          .signInUsingEmailPassword(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );

                                      setState(() {
                                        _isProcessing = false;
                                      });
                                      if (FireAuth.message ==
                                          'user-not-found') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text('user not found')));
                                      }

                                      if (FireAuth.message ==
                                          'wrong-password') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text('wrong password')));
                                      }

                                      checkUserLogedIn(user, context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 154, 2, 2)),
                                  child: const Text(
                                    'Log In',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(height: 24.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text('Don\'t have an account?'),
                                  TextButton(
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 154, 2, 2)),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => SignUp()));
                                    },
                                  )
                                ],
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkUserLogedIn(User? user, BuildContext context) {
    if (user != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainPage(user: user)));
    }
  }

  void _passwordView() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }
}
