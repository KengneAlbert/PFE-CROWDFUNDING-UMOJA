import 'package:flutter/material.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';

import 'create_ping.dart';
import 'profile_test.dart'; // Assurez-vous que votre fichier 'profile_test.dart' est correct

class SelectInterestPage extends StatefulWidget {
  const SelectInterestPage({Key? key}) : super(key: key);

  @override
  _SelectInterestPageState createState() => _SelectInterestPageState();
}

class _SelectInterestPageState extends State<SelectInterestPage> {
  final List<String> _selectedInterests = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Select Your Interest'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Choose your interest to donate. Don\'t worry, you can always change it later.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                padding: const EdgeInsets.all(16.0),
                children: <Widget>[
                  _buildInterestButton(context, Icons.school, 'Education'),
                  _buildInterestButton(context, Icons.eco, 'Environment'),
                  _buildInterestButton(context, Icons.people, 'Social'),
                  _buildInterestButton(context, Icons.child_care, 'Sick child'),
                  _buildInterestButton(context, Icons.medical_services, 'Medical'),
                  _buildInterestButton(context, Icons.apartment, 'Infrastructure'),
                  _buildInterestButton(context, Icons.palette, 'Art'),
                  _buildInterestButton(context, Icons.waves, 'Disaster'),
                  _buildInterestButton(context, Icons.home, 'Orphanage'),
                  _buildInterestButton(context, Icons.accessible, 'Difable'),
                  _buildInterestButton(context, Icons.group, 'Humanity'),
                  _buildInterestButton(context, Icons.card_giftcard, 'Others'),
                ],
              ),
              const SizedBox(height: 32.0),
              CustomBouton(
                label: "Continue",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreatePinPage(
                        // selectedInterests: _selectedInterests, // Passe les intérêts sélectionnés
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInterestButton(BuildContext context, IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedInterests.contains(label)) {
            _selectedInterests.remove(label);
          } else {
            _selectedInterests.add(label);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: _selectedInterests.contains(label)
              ? const Color(0xFF13B156)
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 32.0, color: Colors.black),
            const SizedBox(height: 8.0),
            Text(label, style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}