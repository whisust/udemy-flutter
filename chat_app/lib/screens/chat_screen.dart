import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          DropdownButton(
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
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: StreamBuilder(
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final messages = snapshot.data.docs;
              return ListView.builder(
                itemBuilder: (ctx, index) {
                  return Container(padding: const EdgeInsets.all(8), child: Text(messages[index].data()['text']));
                },
                itemCount: messages.length,
              );
            }
          },
          stream: FirebaseFirestore.instance.collection('chats/MfBFLhnmf8RsqtzYYj5v/messages').snapshots()),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance.collection('chats/MfBFLhnmf8RsqtzYYj5v/messages').add({'text': 'Kek'});
          }),
    );
  }
}
