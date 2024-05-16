import 'package:flutter/material.dart';
import 'package:umoja/inbox/block_user_pop_up.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            
          },
        ),
        title: Text('Kathryn Murphy', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.block, color: Colors.green),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder:(context) => BlockUserPopup()));
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      textStyle: TextStyle(fontSize: 14, color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Today'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 6, // Replace with your actual message count
              itemBuilder: (context, index) {
                if (index == 2) {
                  // Second message is from the user
                  return MessageBubble(
                    text: 'Hi, good morning. Donations will be distributed to flood victims in Surabaya. You can see detailed information in my post',
                    isMe: true,
                    time: '09:41',
                  );
                } else {
                  // All other messages are from the other user
                  return MessageBubble(
                    text: index == 0
                        ? 'Hello, good morning! 😊'
                        : index == 1
                            ? 'I am interested in making a donation. May I know who the donation program you have just published is for?'
                            : index == 3
                                ? 'Great, thanks a lot for the information 😊'
                                : index == 4
                                    ? 'I will make a donation as soon as possible after this'
                                    : 'You\'re welcome. Thank you for the donations that will be given.',
                    isMe: false,
                    time: '09:41',
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.send, color: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String time;

  const MessageBubble({
    Key? key,
    required this.text,
    required this.isMe,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Align(
        alignment: isMe ? Alignment.bottomRight : Alignment.bottomLeft,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: isMe ? Colors.green : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: isMe ? Radius.circular(20) : Radius.circular(0),
              topRight: isMe ? Radius.circular(0) : Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(color: isMe ? Colors.white : Colors.black),
              ),
              SizedBox(height: 4),
              Text(
                time,
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}