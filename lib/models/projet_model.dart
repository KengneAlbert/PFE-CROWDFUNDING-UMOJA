import 'package:cloud_firestore/cloud_firestore.dart';

class ProjetModel {
  final String titre;
  final String description;
  final int montantTotal;
  final DateTime dateDebutCollecte;
  final DateTime dateFinCollecte;
  final String histoire;
  final int montantObtenu;
  final String categorieId;
  final String userId;
  final DateTime createdAt;
  final List<String> imageUrls;
  final String? proposalDocumentUrl;
  final String? medicalDocumentUrl;

  ProjetModel({
    required this.titre,
    required this.description,
    required this.montantTotal,
    required this.dateDebutCollecte,
    required this.dateFinCollecte,
    required this.histoire,
    required this.montantObtenu,
    required this.categorieId,
    required this.userId,
    required this.createdAt,
    required this.imageUrls,
    this.proposalDocumentUrl,
    this.medicalDocumentUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'titre': titre,
      'description': description,
      'montant_total': montantTotal,
      'date_debut_collecte': dateDebutCollecte,
      'date_fin_collecte': dateFinCollecte,
      'histoire': histoire,
      'montant_obtenu': montantObtenu,
      'categorie_id': categorieId,
      'user_id': userId,
      'created_at': createdAt,
      'imageUrls': imageUrls,
      'proposalDocumentUrl': proposalDocumentUrl,
      'medicalDocumentUrl': medicalDocumentUrl,
    };
  }

  factory ProjetModel.fromMap(Map<String, dynamic> map) {
    return ProjetModel(
      titre: map['titre'],
      description: map['description'],
      montantTotal: map['montant_total'],
      dateDebutCollecte: (map['date_debut_collecte'] as Timestamp).toDate(),
      dateFinCollecte: (map['date_fin_collecte'] as Timestamp).toDate(),
      histoire: map['histoire'],
      montantObtenu: map['montant_obtenu'],
      categorieId: map['categorie_id'],
      userId: map['user_id'],
      createdAt: (map['created_at'] as Timestamp).toDate(),
      imageUrls: List<String>.from(map['imageUrls']),
      proposalDocumentUrl: map['proposalDocumentUrl'],
      medicalDocumentUrl: map['medicalDocumentUrl'],
    );
  }
}
