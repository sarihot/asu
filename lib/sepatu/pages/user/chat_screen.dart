
import 'package:asu/sepatu/pages/user/live_chat.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Support"),
      ),
      body: Center(
        child: Text("Welcome to Live Chat Support",
        style: TextStyle(
          color: Colors.teal, fontSize: 24
        ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          Navigator.push(context, 
          MaterialPageRoute(builder: (context)=>LiveChat()));
        }),
        backgroundColor: Colors.teal[800],
        child: Icon(Icons.chat_rounded),
      ),
    );
  }
}