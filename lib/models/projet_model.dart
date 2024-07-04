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
  // final List<String> likes;
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
    // required this.likes,
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
      'date_debut_collecte': dateDebutCollecte.toIso8601String(),
      'date_fin_collecte': dateFinCollecte.toIso8601String(),
      'histoire': histoire,
      'montant_obtenu': montantObtenu,
      'categorie_id': categorieId,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'imageUrls': imageUrls,
      // 'likes': likes,
      'businessModelDocumentUrl': businessModelDocumentUrl,
      'businessPlanDocumentUrl': businessPlanDocumentUrl,
      'videoUrl': videoUrl,
    };
  }

  factory ProjetModel.fromMap(Map<String, dynamic> map) {
    // Ajouter ce log pour vérifier les données
    print('Raw data from Firestore: $map'); 

    // Convertir DocumentReference en String pour les champs user_id et categorie_id
    String userId = '';
    if (map['user_id'] is DocumentReference) {
      userId = (map['user_id'] as DocumentReference).id;
    } else {
      userId = map['user_id'] ?? '';
    }

    String categorieId = '';
    if (map['categorie_id'] is DocumentReference) {
      categorieId = (map['categorie_id'] as DocumentReference).id;
    } else {
      categorieId = map['categorie_id'] ?? '';
    }

    return ProjetModel(
      id: map['id'] ?? '',
      titre: map['titre'] ?? '',
      description: map['description'] ?? '',
      montantTotal: map['montant_total'] ?? 0,
      dateDebutCollecte: (map['date_debut_collecte'] != null)
          ? (map['date_debut_collecte'] as Timestamp).toDate()
          : DateTime.now(), // ou une autre valeur par défaut appropriée
      dateFinCollecte: (map['date_fin_collecte'] != null)
          ? (map['date_fin_collecte'] as Timestamp).toDate()
          : DateTime.now(), // ou une autre valeur par défaut appropriée
      histoire: map['histoire'] ?? '',
      montantObtenu: map['montant_obtenu'] ?? 0,
      categorieId: categorieId,
      userId: userId,
      createdAt: (map['created_at'] != null)
          ? (map['created_at'] as Timestamp).toDate()
          : DateTime.now(), // ou une autre valeur par défaut appropriée
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      // likes: (map['likes'] != null) ? List<String>.from(map['likes']) : [],
      businessModelDocumentUrl: map['businessModelDocumentUrl'],
      businessPlanDocumentUrl: map['businessPlanDocumentUrl'],
      videoUrl: map['videoUrl'],
    );
  }

}

