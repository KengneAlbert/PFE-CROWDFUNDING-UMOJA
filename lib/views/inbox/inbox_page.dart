import 'package:flutter/material.dart';
import 'package:umoja/views/inbox/inbox_chat.dart';

// Widget personnalisé pour l'élément de la liste d'inbox
class InboxItem extends StatelessWidget {
  final String name;
  final String message;
  final String? time;
  final int? count;
  final String? amount;
  final String? imageUrl;

  const InboxItem({
    Key? key,
    required this.name,
    required this.message,
    this.time,
    this.count,
    this.amount,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: imageUrl != null
                ? AssetImage(imageUrl!)
                : null,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context) => ChatPage()));
                  },
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  message,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (count != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF13B156),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text(
                    count.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              if (amount != null)
                Text(
                  amount!,
                  style: const TextStyle(fontSize: 14),
                ),
              if (time != null)
                Text(
                  time!,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
            ],
          ),
        ],
      ),
    );
  }
}



class InboxPage extends StatefulWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  int _selectedIndex = 0;

  final List<InboxItem> inboxItems = [
    InboxItem(
      name: 'Kathryn Murphy',
      message: 'I will make a donation...',
      count: 2,
      amount: '20.00',
      imageUrl: 'assets/images/kathryn.jpg',
    ),
    InboxItem(
      name: 'Darrell Steward',
      message: 'perfect!',
      amount: '16.47',
      imageUrl: 'assets/images/darrell.jpg',
    ),
    InboxItem(
      name: 'Jane Cooper',
      message: 'omg, this is amazing',
      count: 1,
      amount: '13.36',
      imageUrl: 'assets/images/jane.jpg',
    ),
    InboxItem(
      name: 'Eleanor Pena',
      message: 'just ideas for next time',
      time: 'Yesterday',
      imageUrl: 'assets/images/eleanor.jpg',
    ),
    InboxItem(
      name: 'Annette Black',
      message: 'Wow, this is really epic',
      time: 'Yesterday',
      imageUrl: 'assets/images/annette.jpg',
    ),
    InboxItem(
      name: 'Guy Hawkins',
      message: 'That\'s awesome!',
      time: '2 days ago',
      imageUrl: 'assets/images/guy.jpg',
    ),
    InboxItem(
      name: 'Jenny Wilson',
      message: 'Thank you for your support!',
      imageUrl: 'assets/images/jenny.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.people,
          color: Color(0xFF13B156),
          size: 32,
        ),
        title: const Text(
          'Inbox',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Color(0xFF13B156)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: inboxItems.length,
                itemBuilder: (context, index) {
                  return inboxItems[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

