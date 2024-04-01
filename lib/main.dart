// **************بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيم***************

import 'package:flutter/material.dart';
import 'package:hayai_msg/screens/welcome_screen.dart';
import 'package:hayai_msg/screens/login_screen.dart';
import 'package:hayai_msg/screens/registration_screen.dart';
import 'package:hayai_msg/screens/chat_screen.dart';

void main() => runApp(const FlashChat());

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: 'welcome',
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
