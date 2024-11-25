// ignore_for_file: must_be_immutable

import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/custom_chat_bubble.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  TextEditingController controller = TextEditingController();
  final _sController = ScrollController();
  ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments.toString();
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogo,
                      height: 50,
                    ),
                    const Text(
                      "Chat App",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context, Login.id,
                          (Route<dynamic> route) =>
                              false, // Remove all previous routes
                        );
                        ;
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 30,
                      ))
                ],
                backgroundColor: kPrimaryColor,
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _sController,
                      itemCount: messagesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return messagesList[index].id == email
                            ? SentChatBubble(
                                message: messagesList[index],
                              )
                            : RecievedChatBubble(message: messagesList[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          'message': data,
                          'createdAt': DateTime.now(),
                          'id': email
                        });
                        controller.clear();
                        _sController.animateTo(
                            _sController.position.minScrollExtent,
                            duration: Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn);
                      },
                      decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: kPrimaryColor))),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Text('Loading');
          }
        });
  }
}
