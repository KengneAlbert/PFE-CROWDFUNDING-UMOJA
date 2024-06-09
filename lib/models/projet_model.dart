class Projet {
    final int id;
    final String Titre;
    final String Description;
    final int Montant_Total;
    final DateTime Date_debut_collecte;
    final DateTime Date_fin_collecte;
    final String? Histoire;
    final int Montant_Obtenu;
    final int Categorie_id;
    final int User_id;
  
  final DateTime createdAt;

  Projet({
    required this.id,
    required this.Titre,
    required this.Description,
    required this.Montant_Total,
    required this.Date_debut_collecte,
    required this.Date_fin_collecte,
             this.Histoire,
    required this.Montant_Obtenu,
    required this.Categorie_id,
    required this.User_id,
    required this.createdAt,
  });

  factory Projet.fromMap(Map<String, dynamic> map) {
    return Projet(
      id: map['id'],
      Titre: map['Titre'],
      Description: map['Description'],
      Montant_Total: map['Montant_Total'],
      Date_debut_collecte: DateTime.parse(map['Date_debut_collecte']),
      Date_fin_collecte: DateTime.parse(map['Date_fin_collecte']),
      Histoire: map['Histoire'],
      Montant_Obtenu: map['Montant_Obtenu'],
      Categorie_id: map['Categorie_id'],
      User_id: map['User_id'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Titre': Titre,
      'Description': Description,
      'Montant_Total': Montant_Total,
      'Date_debut_collecte': Date_debut_collecte.toIso8601String(),
      'Date_fin_collecte': Date_debut_collecte.toIso8601String(),
      'Histoire': Histoire,
      'Montant_Obtenu': Montant_Obtenu,
      'Categorie_id': Categorie_id,
      'User_id': User_id,
      'created_at': createdAt.toIso8601String(),
    };
  }
}


