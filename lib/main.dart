// **************بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيم***************

import 'package:flutter/material.dart';
import 'package:hayai_msg/screens/welcome_screen.dart';
import 'package:hayai_msg/screens/login_screen.dart';
import 'package:hayai_msg/screens/registration_screen.dart';
import 'package:hayai_msg/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  initializeFireBase();
  runApp(const FlashChat());
}

void initializeFireBase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyBZW_Wt_ZTxQ8ZZ6gU537SJoib0aM16VEY",
    appId: "hayai_msg",
    messagingSenderId: "1:456406698581:android:52918a8ea4d90e7bd262dc",
    projectId: "hayai-chat",
    storageBucket: "hayai-chat.appspot.com",
  ));
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          ChatScreen.id: (context) => const ChatScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          RegistrationScreen.id: (context) => const RegistrationScreen(),
        },
        theme: ThemeData(
          textTheme: const TextTheme(
            titleMedium: TextStyle(
                color: Colors.black,
                fontSize: 20), // default TextField input style
          ),
        )
        //home: WelcomeScreen(),
        );
  }
}
