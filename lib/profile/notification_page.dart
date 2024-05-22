import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _soundEnabled = false;
  bool _vibrateEnabled = true;
  bool _newTipsEnabled = false;
  bool _newServiceEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Color(0xFF13B156),),
        ),
        title: const Text('Notification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationSetting(
              title: 'Sound',
              isEnabled: _soundEnabled,
              onChanged: (value) {
                setState(() {
                  _soundEnabled = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Divider(
                thickness: 1,
                color: Colors.grey[300],
              ),
            ),
            NotificationSetting(
              title: 'Vibrate',
              isEnabled: _vibrateEnabled,
              onChanged: (value) {
                setState(() {
                  _vibrateEnabled = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Divider(
                thickness: 1,
                color: Colors.grey[300],
              ),
            ),
            NotificationSetting(
              title: 'New tips available',
              isEnabled: _newTipsEnabled,
              onChanged: (value) {
                setState(() {
                  _newTipsEnabled = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Divider(
                thickness: 1,
                color: Colors.grey[300],
              ),
            ),
            NotificationSetting(
              title: 'New service available',
              isEnabled: _newServiceEnabled,
              onChanged: (value) {
                setState(() {
                  _newServiceEnabled = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationSetting extends StatelessWidget {
  final String title;
  final bool isEnabled;
  final void Function(bool) onChanged;

  const NotificationSetting({
    Key? key,
    required this.title,
    required this.isEnabled,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          Switch(
            activeColor: Color(0xFF13B156),
            value: isEnabled,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}