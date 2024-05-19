import 'package:flutter/material.dart';
import 'package:umoja/account_setup/select_interest.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';

import '../custom_widgets/custom_input.dart';

class FillProfilePage extends StatefulWidget {
  @override
  _FillProfilePageState createState() => _FillProfilePageState();
}

class _FillProfilePageState extends State<FillProfilePage> {
  // Contrôleurs pour les champs de texte
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _cityController = TextEditingController();

  // Clé pour le formulaire
  final _formKey = GlobalKey<FormState>();

  // Valeur par défaut pour le genre
  String _gender = 'Select Gender';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fill Your Profile'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Avatar
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/images/logo_mini.png'), // Remplacez par l'image par défaut souhaitée
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF13B156),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.edit, color: Colors.white),
                            onPressed: () {
                              // Logique pour changer l'image d'avatar
                              // Par exemple, ouvrir une galerie d'images ou prendre une photo
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
        
                // Champ Nom Complet
                InputWidget(
                  label: 'Full Name',
                  controller: _fullNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
        
                // Champ Email
                InputWidget(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
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
        
                // Champ Numéro de Téléphone
                InputWidget(
                  label: 'Phone Number',
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  icon: Icons.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
        
                // Menu déroulant pour le genre
                DropdownButtonFormField<String>(
                  value: _gender,
                  onChanged: (newValue) {
                    setState(() {
                      _gender = newValue!;
                    });
                  },
                  items: <String>['Select Gender', 'Male', 'Female', 'Other']
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    // border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == 'Select Gender') {
                      return 'Please select your gender';
                    }
                    return null;
                  },
                ),
        
                // Champ Ville
                InputWidget(
                  label: 'City',
                  controller: _cityController,
                  icon: Icons.location_on,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32),
        
                // Bouton Continuer
                CustomBouton(
                  label: "Continue",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Traitement des données du formulaire
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SelectInterestPage()));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

