import 'package:flutter/material.dart';
import 'package:hayai_msg/screens/login_screen.dart';
import 'package:hayai_msg/screens/registration_screen.dart';
import 'package:hayai_msg/components/custom_padding.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome';

  const WelcomeScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation tweenAnimation;
  // late Animation curvedAnimation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    controller.forward();

    // curvedAnimation =
    //     CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    // curvedAnimation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) controller.reverse(from: 1);
    //   if (status == AnimationStatus.dismissed) controller.forward();
    // });
    tweenAnimation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.addListener(() {
      setState(() {});
      debugPrint('$controller');
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tweenAnimation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 60.0 * controller.value,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                const Text(
                  'Hayai Chat',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            Custompadding(
              color: Colors.lightBlueAccent,
              title: 'Log In',
              callback: () => Navigator.pushNamed(context, LoginScreen.id),
            ),
            Custompadding(
              color: Colors.blueAccent,
              callback: () =>
                  Navigator.pushNamed(context, RegistrationScreen.id),
              title: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
