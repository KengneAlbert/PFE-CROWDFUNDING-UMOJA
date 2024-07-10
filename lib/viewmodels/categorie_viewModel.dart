// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:umoja/models/categorie_projet_model.dart';

// final categorieProvider = FutureProvider<List<Categorie>>((ref) async {
//   final firestore = FirebaseFirestore.instance;
//   final snapshot = await firestore.collection('Categorie').get();
//   return snapshot.docs.map((doc) => Categorie.fromDocument(doc)).toList();
// });
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:umoja/models/categorie_projet_model.dart';

final categorieProvider = FutureProvider<List<Categorie>>((ref) async {
  final firestore = FirebaseFirestore.instance;
  final snapshot = await firestore.collection('Categorie').get();
  return snapshot.docs.map((doc) => Categorie.fromDocument(doc)).toList();
});