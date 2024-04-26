import 'package:flutter/material.dart';
import 'package:hayai_msg/components/custom_padding.dart';
import 'package:hayai_msg/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hayai_msg/screens/chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration';

  const RegistrationScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              //style: TextStyle(color: Colors.black),
              onChanged: (value) {
                email = value;
              },
              decoration: kInputDecoration,
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                password = value;
                //Do something with the user input.
              },
              decoration: kInputDecoration.copyWith(
                hintText: 'Enter your password',
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Custompadding(
              color: Colors.blueAccent,
              title: 'Register',
              callback: () async {
                try {
                  // ignore: unused_local_variable
                  UserCredential? newUser;
                  await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: email, password: password)
                      .then((value) {
                    newUser = value;
                    Navigator.pushNamed(context, ChatScreen.id);
                  }).catchError((e) {
                    newUser = null;
                    SnackBar(content: Text('error occured $e'));
                  });
                } on Exception catch (e) {
                  debugPrint(e.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
