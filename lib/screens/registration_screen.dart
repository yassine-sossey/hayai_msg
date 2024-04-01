import 'package:flutter/material.dart';
import 'package:hayai_msg/components/custom_padding.dart';
import 'package:hayai_msg/constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration';

  const RegistrationScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
              //style: TextStyle(color: Colors.black),
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kInputDecoration,
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
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
              callback: () {},
            ),
          ],
        ),
      ),
    );
  }
}
