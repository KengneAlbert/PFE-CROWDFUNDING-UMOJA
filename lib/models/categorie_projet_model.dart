import 'package:cloud_firestore/cloud_firestore.dart';

class Categorie {
  final String id;
  final String titre;

  Categorie({required this.id, required this.titre});

  factory Categorie.fromDocument(DocumentSnapshot doc) {
    return Categorie(
      id: doc.id,
      titre: doc['titre'],
    );
  }
}
