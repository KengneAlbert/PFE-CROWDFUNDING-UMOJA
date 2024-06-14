import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/user_model.dart';
import 'package:umoja/viewmodels/registration_notifier.dart';

class UserService {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;

  UserService(this._firestore, this._firebaseStorage);

  Future<void> createUserInFirestore(WidgetRef ref, Map<String, dynamic> registrationData) async {
    try {
      // Assume user has been created in Firebase Auth and you have the UID
      String uid = FirebaseAuth.instance.currentUser!.uid;

      // Upload profile image to Firebase Storage if exists
      if (registrationData.containsKey('profileImage')) {
        File profileImage = registrationData['profileImage'];
        TaskSnapshot snapshot = await _firebaseStorage
            .ref()
            .child('profileImages/$uid')
            .putFile(profileImage);

        String profileImageUrl = await snapshot.ref.getDownloadURL();
        registrationData['profileImageUrl'] = profileImageUrl;
      }

      // Create user model from registrationData
      UserModel userModel = UserModel.fromMap({...registrationData, 'uid': uid});

      // Save userModel to Firestore
      await _firestore
          .collection('users')
          .doc(uid)
          .set(userModel.toMap());

      // Clear registration data
      ref.read(registrationProvider.notifier).clear();
    } catch (e) {
      // Handle error
      print('Error creating user: $e');
    }
  }
}
