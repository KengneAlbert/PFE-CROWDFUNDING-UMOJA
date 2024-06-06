import 'package:flutter/material.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  _SecurityPageState createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  bool _faceIDEnabled = false;
  bool _rememberMeEnabled = true;
  bool _touchIDEnabled = true;

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
        title: const Text('Security'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SecuritySetting(
              title: 'Face ID',
              isEnabled: _faceIDEnabled,
              onChanged: (value) {
                setState(() {
                  _faceIDEnabled = value;
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
            SecuritySetting(
              title: 'Remember me',
              isEnabled: _rememberMeEnabled,
              onChanged: (value) {
                setState(() {
                  _rememberMeEnabled = value;
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
            SecuritySetting(
              title: 'Touch ID',
              isEnabled: _touchIDEnabled,
              onChanged: (value) {
                setState(() {
                  _touchIDEnabled = value;
                });
              },
            ),
            const SizedBox(height: 32),
            CustomBouton(
              label: "Change Password",
              onPressed: () {
                
              },
              ),
            const SizedBox(height: 16),
            CustomBouton(
              label: "Change PIN",
              onPressed: () {
                
              },
              ),
          ],
        ),
      ),
    );
  }
}

class SecuritySetting extends StatelessWidget {
  final String title;
  final bool isEnabled;
  final void Function(bool) onChanged;

  const SecuritySetting({
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