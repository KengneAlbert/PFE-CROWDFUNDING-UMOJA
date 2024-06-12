class ProjetModel {
    final int? id;
    final String titre;
    final String description;
    final int montantTotal;
    final DateTime dateDebutCollecte;
    final DateTime dateFinCollecte;
    final String? histoire;
    final int? montantObtenu;
    final int CategorieId;
    final int userId; 
    final DateTime createdAt;

  ProjetModel({
    this.id,
    required this.titre,
    required this.description,
    required this.montantTotal,
    required this.dateDebutCollecte,
    required this.dateFinCollecte,
             this.histoire,
    this.montantObtenu,
    required this.CategorieId,
    required this.userId,
    required this.createdAt,
  });

  factory ProjetModel.fromMap(Map<String, dynamic> map) {
    return ProjetModel(
      id: map['id'],
      titre: map['titre'],
      description: map['description'],
      montantTotal: map['montantTotal'],
      dateDebutCollecte: DateTime.parse(map['dateDebutCollecte']),
      dateFinCollecte: DateTime.parse(map['dateFinCollecte']),
      histoire: map['histoire'],
      montantObtenu: map['montantObtenu'],
      CategorieId: map['CategorieId'],
      userId: map['userId'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titre': titre,
      'description': description,
      'montantTotal': montantTotal,
      'dateDebutCollecte': dateDebutCollecte.toIso8601String(),
      'dateFinCollecte': dateDebutCollecte.toIso8601String(),
      'histoire': histoire,
      'montantObtenu': montantObtenu,
      'CategorieId': CategorieId,
      'userId': userId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}


