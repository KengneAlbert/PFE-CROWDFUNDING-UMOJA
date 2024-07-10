// import 'package:cloud_firestore/cloud_firestore.dart';

// class ProjetModel {
//   final String id;
//   final String titre;
//   final String description;
//   final int montantTotal;
//   final DateTime dateDebutCollecte;
//   final DateTime dateFinCollecte;
//   final String histoire;
//   final int montantObtenu;
//   final String categorieId;
//   final String userId;
//   final DateTime createdAt;
//   final List<String> imageUrls;
//   final List<String> likes;
//   final List<String>? documents;
//   final List<String>? videos;

//   ProjetModel({
//     required this.id,
//     required this.titre,
//     required this.description,
//     required this.montantTotal,
//     required this.dateDebutCollecte,
//     required this.dateFinCollecte,
//     required this.histoire,
//     required this.montantObtenu,
//     required this.categorieId,
//     required this.userId,
//     required this.createdAt,
//     required this.imageUrls,
//     required this.likes,
//     this.documents,
//     this.videos,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'titre': titre,
//       'description': description,
//       'montant_total': montantTotal,
//       'date_debut_collecte': Timestamp.fromDate(dateDebutCollecte),
//       'date_fin_collecte': Timestamp.fromDate(dateFinCollecte),
//       'histoire': histoire,
//       'montant_obtenu': montantObtenu,
//       'categorie_id': categorieId,
//       'user_id': userId,
//       'created_at': Timestamp.fromDate(createdAt),
//       'imageUrls': imageUrls,
//       'likes': likes,
//       'documents': documents,
//       'videos': videos,
//     };
//   }

//   factory ProjetModel.fromMap(Map<String, dynamic> map, [String? id]) {

    
//     return ProjetModel(
//       id: map['id'],
//       titre: map['titre'] ?? '',
//       description: map['description'] ?? '',
//       montantTotal: map['montant_total'] ?? 0,
//       dateDebutCollecte: (map['date_debut_collecte'] as Timestamp).toDate(),
//       dateFinCollecte: (map['date_fin_collecte'] as Timestamp).toDate(),
//       histoire: map['histoire'] ?? '',
//       montantObtenu: map['montant_obtenu'] ?? 0,
//       categorieId: map['categorie_id'] ?? '',
//       userId: map['user_id'] ?? '',
//       createdAt: (map['created_at'] as Timestamp).toDate(),
//       imageUrls: List<String>.from(map['imageUrls'] ?? []),
//       likes: List<String>.from(map['likes'] ?? []),
//       documents: List<String>.from(map['documents'] ?? []),
//       videos: List<String>.from(map['videos'] ?? []),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class ProjetModel {
  final String id;
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
  final List<String> likes;
  final List<String>? documents;
  final List<String>? videos;
  final String? businessModelDocumentUrl;
  final String? businessPlanDocumentUrl;
  final String? videoUrl;

  ProjetModel({
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
    this.documents,
    this.videos,
    this.businessModelDocumentUrl,
    this.businessPlanDocumentUrl,
    this.videoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titre': titre,
      'description': description,
      'montant_total': montantTotal,
      'date_debut_collecte': Timestamp.fromDate(dateDebutCollecte),
      'date_fin_collecte': Timestamp.fromDate(dateFinCollecte),
      'histoire': histoire,
      'montant_obtenu': montantObtenu,
      'categorie_id': categorieId,
      'user_id': userId,
      'created_at': Timestamp.fromDate(createdAt),
      'imageUrls': imageUrls,
      'likes': likes,
      'documents': documents,
      'videos': videos,
      // 'likes': likes,
      'businessModelDocumentUrl': businessModelDocumentUrl,
      'businessPlanDocumentUrl': businessPlanDocumentUrl,
      'videoUrl': videoUrl,
    };
  }

  factory ProjetModel.fromMap(Map<String, dynamic> map, [String? id]) {

    // Convertir DocumentReference en String pour les champs user_id et categorie_id
    String userId = '';
    if (map['user_id'] is DocumentReference) {
      userId = (map['user_id'] as DocumentReference).id;
    } else {
      userId = map['user_id'];
    }

    String categorieId = '';
    if (map['categorie_id'] is DocumentReference) {
      categorieId = (map['categorie_id'] as DocumentReference).id;
    } else {
      categorieId = map['categorie_id'];
    }

    return ProjetModel(
      id: map['id'],
      titre: map['titre'],
      description: map['description'],
      montantTotal: map['montant_total'],
      dateDebutCollecte: (map['date_debut_collecte'] as Timestamp).toDate(),
      dateFinCollecte:(map['date_fin_collecte'] as Timestamp).toDate(),
      histoire: map['histoire'] ,
      montantObtenu: map['montant_obtenu'],
      categorieId: categorieId,
      userId: userId,
      createdAt: (map['created_at'] as Timestamp).toDate(),
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      likes: (map['likes'] != null) ? List<String>.from(map['likes']) : [],
      documents: (map['documents'] != null) ? List<String>.from(map['documents']) : [],
      videos: (map['videos'] != null) ? List<String>.from(map['videos']) : [],
      businessModelDocumentUrl: map['businessModelDocumentUrl'],
      businessPlanDocumentUrl: map['businessPlanDocumentUrl'],
      videoUrl: map['videoUrl'],
    );
  }

}