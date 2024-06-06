class Projet {
  final int id;
  final String Titre;
  final String Description;
  final int Montant_Total;
  final DateTime Date_debut_collecte;
  final DateTime Date_fin_collecte;
  final String? Histoire;
  final int Total_Obtenu;
  final DateTime createdAt;

  Projet({
    required this.id,
    required this.Titre,
    required this.Description,
    required this.Montant_Total,
    required this.Date_debut_collecte,
    required this.Date_fin_collecte,
             this.Histoire,
    required this.Total_Obtenu,
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
      Total_Obtenu: map['Total_Obtenu'],
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
      'Total_Obtenu': Total_Obtenu,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
