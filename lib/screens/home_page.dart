import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lu_campus/screens/sign_up.dart';

import 'log_in.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  // even space distribution
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 9,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/logo.jpeg"))),
                        ),
                        const SizedBox(
                          height: 170,
                        ),
                        const Text(
                          "Welcome",
                          style: TextStyle(
                            color: Color.fromARGB(255, 154, 2, 2),
                            fontWeight: FontWeight.bold,
                            fontSize: 60,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "To LU-Campus ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        // the login button
                        ElevatedButton(
                          style: ButtonStyle(
                              side: MaterialStateProperty.all<BorderSide>(
                                BorderSide(color: Colors.black12),
                              ),
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => LoginPage()));
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        // creating the signup button
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignUp()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 154, 2, 2)
                          ),
                          child: const Text(
                            "Sign up",
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}