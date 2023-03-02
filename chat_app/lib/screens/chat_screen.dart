import 'package:chat_app/widgets/chat/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../widgets/chat/messages.dart';

@pragma('vm:entry-point')
Future<void> backgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final RemoteMessage? firstMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (firstMessage != null) {
    print('Received FCM Background Message from terminated state: ${message.data}');
  } else {
    print('Received FCM Background Message: ${message.data}');
  }
}

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          DropdownButton(
              underline: Container(),
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              items: [
                DropdownMenuItem(
                    value: 'logout',
                    child: Container(
                        child: Row(
                      children: [const Icon(Icons.exit_to_app), const SizedBox(width: 8), const Text('Logout')],
                    )))
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(child: Messages()),
          NewMessage(),
        ],
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    print('### Initializing state and FCM plugs');
    final fb = FirebaseMessaging.instance;
    fb.requestPermission();
    FirebaseMessaging.onMessage.listen((message) {
      print('Received FCM Foreground Message: ${message.data}');
    });
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
    print('### Done!');
    fb.subscribeToTopic('chat');
  }
}
