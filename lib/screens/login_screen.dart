import 'package:flutter/material.dart';
import 'package:hayai_msg/components/custom_padding.dart';
import 'package:hayai_msg/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hayai_msg/screens/chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login';

  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  bool isLoading = false; // Add loading state

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
              onChanged: (value) {
                //Do something with the user input.
                email = value;
              },
              decoration: kInputDecoration,
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                //Do something with the user input.
                password = value;
              },
              decoration:
                  kInputDecoration.copyWith(hintText: 'Enter your password'),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Custompadding(
                  color: Colors.lightBlueAccent,
                  title: 'Log In',
                  callback: () async {
                    //dismiss the keyboard
                    FocusScope.of(context).unfocus();

                    setState(() {
                      isLoading = true; // Set loading state to true
                    });

                    try {
                      // ignore: unused_local_variable
                      UserCredential? newUser;
                      await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email, password: password)
                          .then((value) {
                        newUser = value;
                        Navigator.pushNamed(context, ChatScreen.id);
                      }).catchError((e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erreur survenue : $e')),
                        );
                      });
                    } on Exception catch (e) {
                      // TODO
                      debugPrint('Hey I catched this ${e.toString()}');
                    } finally {
                      setState(() {
                        isLoading = false; // Set loading state to false
                      });
                    }
                  },
                ),
                if (isLoading)
                  CircularProgressIndicator(), // Show CircularProgressIndicator if isLoading is true
              ],
            ),
          ],
        ),
      ),
    );
  }
}
