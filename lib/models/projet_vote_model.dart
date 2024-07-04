import 'package:cloud_firestore/cloud_firestore.dart';

class ProjetVoteModel{
  final String id;
  final String titre;
  final String description;
  final int montantTotal;
  final DateTime dateFinCollecte;
  final String histoire;
  final int montantObtenu;
  final String categorieId;
  final DateTime dateDebutCollecte;
  final String userId;
  final DateTime createdAt;
  final List<String> imageUrls;
  final List<String> likes;
  //final String? proposalDocumentUrl;
  //final String? medicalDocumentUrl;

  ProjetVoteModel({
    required this.id,
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
    required this.likes,
    //this.proposalDocumentUrl,
    //this.medicalDocumentUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'titre': titre,
      'description': description,
      'montant_total': montantTotal,
      //'date_debut_collecte': Timestamp.fromDate(dateDebutCollecte),
      'date_fin_collecte': Timestamp.fromDate(dateFinCollecte),
      'histoire': histoire,
      'montant_obtenu': montantObtenu,
      'categorie_id': categorieId,
      'user_id': userId,
      'created_at': Timestamp.fromDate(createdAt),
      'imageUrls': imageUrls,
      'likes': likes,
      //'proposalDocumentUrl': proposalDocumentUrl,
      //'medicalDocumentUrl': medicalDocumentUrl,
      'date_debut_collecte': Timestamp.fromDate(dateDebutCollecte), // Conversion DateTime -> Timestamp
    };
  }

  factory ProjetVoteModel.fromMap(String id, Map<String, dynamic> map) {
    return ProjetVoteModel(
      id: id,
      titre: map['titre'],
      description: map['description'],
      montantTotal: map['montant_total'],
      //dateDebutCollecte: (map['date_debut_collecte'] as Timestamp).toDate(),
      //dateFinCollecte: (map['date_fin_collecte'] as Timestamp).toDate(),
      histoire: map['histoire'],
      montantObtenu: map['montant_obtenu'],
      categorieId: map['categorie_id'],
      userId: map['user_id'],
      createdAt: (map['created_at'] as Timestamp).toDate(),
      imageUrls: (map['imageUrls'] != null) ? List<String>.from(map['imageUrls']) : [],
      likes: (map['likes'] != null) ? List<String>.from(map['likes']) : [],
      //proposalDocumentUrl: map['proposalDocumentUrl'],
      //medicalDocumentUrl: map['medicalDocumentUrl'],
      dateDebutCollecte: (map['date_debut_collecte'] as Timestamp).toDate(), // Conversion Timestamp -> DateTime
      dateFinCollecte: (map['date_fin_collecte'] as Timestamp).toDate(),
    );
  }
}
