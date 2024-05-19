import 'package:flutter/material.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';

class FillProfilePage extends StatefulWidget {
  @override
  _FillProfilePageState createState() => _FillProfilePageState();
}

class _FillProfilePageState extends State<FillProfilePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fill Your Profile'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person, size: 50),
              ),
              SizedBox(height: 32),
              InputWidget(
                label: 'Full Name',
                hintText: 'Full Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              InputWidget(
                label: 'Email',
                hintText: 'Email',
                icon: Icons.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              InputWidget(
                label: 'Phone Number',
                hintText: 'Phone Number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              InputWidget(
                label: 'Gender',
                hintText: 'Gender',
                icon: Icons.arrow_drop_down,
                isDropdown: true,
                items: ['Male', 'Female', 'Other'],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              InputWidget(
                label: 'City',
                hintText: 'City',
                icon: Icons.location_on,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),

              CustomBouton(
                label: "Continue",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data
                  }
                },
                )
            ],
          ),
        ),
      ),
    );
  }
}

class InputWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool isDropdown;
  final List<String>? items;
  final String? Function(String?)? validator;

  InputWidget({
    required this.label,
    required this.hintText,
    this.icon,
    this.keyboardType,
    this.isDropdown = false,
    this.items,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        suffixIcon: Icon(icon),
      ),
      keyboardType: keyboardType,
      validator: validator,
      onChanged: (value) {
        // Optional: Handle changes to the input
      },
      onTap: () {
        if (isDropdown) {
          // Show dropdown
        }
      },
    );
  }
}