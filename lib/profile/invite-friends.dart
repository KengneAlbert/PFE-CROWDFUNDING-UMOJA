import 'package:flutter/material.dart';

class InviteFriendsPage extends StatelessWidget {
  const InviteFriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){Navigator.pop(context);}, 
          icon:Icon(Icons.arrow_back, color: Color(0xFF13B156),)
        ),
        title: const Text('Invite Friends')
      ),
      body: ListView(
        children: const [
          _FriendCard(
            name: 'Jane Cooper',
            phoneNumber: '+62-818-5551-61',
          ),
          _FriendCard(
            name: 'Cameron Williamson',
            phoneNumber: '+62-852-5558-77',
          ),
          _FriendCard(
            name: 'Leslie Alexander',
            phoneNumber: '+62-896-5554-32',
          ),
          _FriendCard(
            name: 'Esther Howard',
            phoneNumber: '+62-838-5559-83',
          ),
          _FriendCard(
            name: 'Savannah Nguyen',
            phoneNumber: '+62-818-5551-71',
          ),
          _FriendCard(
            name: 'Kristin Watson',
            phoneNumber: '+62-896-5551-11',
          ),
          _FriendCard(
            name: 'Ralph Edwards',
            phoneNumber: '+62-878-5555-86',
          ),
          _FriendCard(
            name: 'Kathryn Murphy',
            phoneNumber: '+62-838-5555-43',
          ),
        ],
      ),
    );
  }
}

class _FriendCard extends StatelessWidget {
  final String name;
  final String phoneNumber;

  const _FriendCard({
    Key? key,
    required this.name,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage('https://picsum.photos/200/300'), // Placeholder image
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    phoneNumber,
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {}, // Add your invite logic here
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Invite'),
            ),
          ],
        ),
      ),
    );
  }
}