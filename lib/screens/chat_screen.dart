import 'package:flutter/material.dart';
import 'package:hayai_msg/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hayai_msg/screens/login_screen.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat';

  const ChatScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // information to differentiate currentuser from other users
  bool iscurrentUser = true;
  List<Widget> historyOfMessages = [];
  final _auth = FirebaseAuth.instance;
  //current logged in user
  late final User? loggedInUser;
  final _firestore = FirebaseFirestore.instance;
  String message = '';

  final TextEditingController _controller = TextEditingController();
//get data from database once added
  void getStreams() {
    _firestore.collection('messages').snapshots().listen((snapshot) {
      for (var message in snapshot.docs) {
        final data = message.data();
        final sender = data['user'];
        final messageContent = data['content'];
        debugPrint('sender: $sender\nmessage: $messageContent');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loggedInUser = _auth.currentUser;
    debugPrint(loggedInUser!.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pushNamed(context, LoginScreen.id);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: _firestore
                    .collection('messages')
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return centerCirc;
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData) {
                    return const Center(
                      child: Text('No messages available'),
                    );
                  } else {
                    final messages = snapshot.data!.docs.reversed;
                    List<Widget> messageWidgets = [];

                    for (var message in messages) {
                      final sender = message['user'];
                      final messageContent = message['content'];
                      messageWidgets.add(
                        Text(
                          '$messageContent from $sender',
                          style: const TextStyle(fontSize: 15),
                        ),
                      );
                    }

                    return ListView(
                      reverse: true,
                      children: messages.map((message) {
                        final sender = message['user'];
                        final messageContent = message['content'];
                        iscurrentUser = (sender == loggedInUser!.email);

                        return ListTile(
                          title: Align(
                            alignment: iscurrentUser
                                ? Alignment.topRight
                                : Alignment.topLeft,
                            child: Container(
                              decoration: iscurrentUser
                                  ? currentuserboxDecoration
                                  : otherusersboxDecoration,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  textAlign: iscurrentUser
                                      ? TextAlign.end
                                      : TextAlign.start,
                                  ' $messageContent',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                          subtitle: Text(
                            textAlign:
                                iscurrentUser ? TextAlign.end : TextAlign.start,
                            ' $sender',
                            style: const TextStyle(fontSize: 8),
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) {
                        //Do something with the user input.
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      _firestore.collection('messages').add({
                        'user': loggedInUser!.email,
                        'content': message,
                        'time': DateTime.now()
                      });
                      getStreams();
                      //clear the message already written
                      _controller.clear();
                      //dismiss the keyboard
                      FocusScope.of(context).unfocus();
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
