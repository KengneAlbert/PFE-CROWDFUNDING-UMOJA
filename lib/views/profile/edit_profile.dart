import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umoja/main.dart';
import 'package:umoja/viewmodels/registration_notifier.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart' as bouton;
import 'package:umoja/custom_widgets/custom_input.dart' as input;
import 'package:umoja/viewmodels/user_viewModel.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
   static UserService userService = UserService();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _cityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _gender = 'Select Gender';
  File? _profileImage;
  bool _isEditing = false;
  bool _isLoading = false;
  bool _showFullImage = false; // Variable pour afficher l'image en plein écran

  @override
  void initState() {
    super.initState();
    final user = ref.read(authViewModelProvider);
    if (user != null) {
      _fullNameController.text = user.name ?? '';
      _emailController.text = user.email ?? '';
      _phoneNumberController.text = user.phone ?? '';
      _cityController.text = user.location ?? '';
      _gender = user.gender ?? 'Select Gender';
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      ref.read(registrationProvider.notifier).updateData('profileImage', _profileImage);
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      ref.read(registrationProvider.notifier).updateData('name', _fullNameController.text);
      ref.read(registrationProvider.notifier).updateData('email', _emailController.text);
      ref.read(registrationProvider.notifier).updateData('phone', _phoneNumberController.text);
      ref.read(registrationProvider.notifier).updateData('gender', _gender);
      ref.read(registrationProvider.notifier).updateData('location', _cityController.text);
      await userService.createUserInFirestore(ref,  ref.read(registrationProvider));
      // Simuler une mise à jour
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false;
        _isEditing = false;
      });

      // Afficher un message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Your profile has been updated successfully!')),
      );
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Update'),
          content: Text('Do you really want to update your profile information?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
                _updateProfile();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Color(0xFF13B156)),
        ),
        title: Text('Edit Your Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: _isEditing ? Color(0xFF13B156) : Color(0xFFFF1843).withOpacity(0.4)),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showFullImage = !_showFullImage;
                          });
                        },
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: _profileImage != null
                                  ? FileImage(_profileImage!)
                                  : user?.profile_picture != null
                                      ? Image.network(user!.profile_picture!).image
                                      : AssetImage('assets/images/logo_mini.png'),
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
                                  onPressed: _isEditing ? _pickImage : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    input.CustomInput(
                      hintText: user?.name ?? '',
                      label: 'Full Name',
                      controller: _fullNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      enabled: _isEditing,
                    ),
                    input.CustomInput(
                      hintText: user?.email ?? '',
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
                      enabled: _isEditing,
                    ),
                    input.CustomInput(
                      hintText: user?.phone ?? '',
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
                      enabled: _isEditing,
                    ),
                    DropdownButtonFormField<String>(
                      value: _gender,
                      onChanged: _isEditing
                          ? (newValue) {
                              setState(() {
                                _gender = newValue!;
                              });
                            }
                          : null,
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
                      ),
                      validator: (value) {
                        if (value == 'Select Gender') {
                          return 'Please select your gender';
                        }
                        return null;
                      },
                    ),
                    input.CustomInput(
                      hintText: user?.location ?? '',
                      label: 'City',
                      controller: _cityController,
                      icon: Icons.location_on,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your city';
                        }
                        return null;
                      },
                      enabled: _isEditing,
                    ),
                    SizedBox(height: 32),
                    bouton.CustomBouton(
                      label: "Update",
                      onPressed: _isEditing ? _showConfirmationDialog : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (_showFullImage)
            GestureDetector(
              onTap: () {
                setState(() {
                  _showFullImage = false;
                });
              },
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Hero(
                    tag: 'profileImage',
                    child: _profileImage != null
                        ? Image.file(_profileImage!)
                        : user?.profile_picture != null
                            ? Image.network(user!.profile_picture!)
                            : Image.asset('assets/images/logo_mini.png'),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}