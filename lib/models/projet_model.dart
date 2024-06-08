import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Projet {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String Titre;
  @HiveField(2)
  final String Description;
  @HiveField(3)
  final int Montant_Total;
  @HiveField(4)
  final DateTime Date_debut_collecte;
  @HiveField(5)
  final DateTime Date_fin_collecte;
  @HiveField(6)
  final String? Histoire;
  @HiveField(7)
  final int Montant_Obtenu;
  @HiveField(8)
  final int Categorie_id;
  @HiveField(9)
  final int User_id;
  @HiveField(10)
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

class ProjetAdapter extends TypeAdapter<Projet> {
  @override
  final int typeId = 1;

  @override
  Projet read(BinaryReader reader) {
    return Projet(
      id: reader.read(),
      Titre: reader.read(),
      Description: reader.read(),
      Montant_Total: reader.read(),
      Date_debut_collecte: DateTime.parse(reader.read()),
      Date_fin_collecte: DateTime.parse(reader.read()),
      Histoire: reader.read(),
      Montant_Obtenu: reader.read(),
      Categorie_id: reader.read(),
      User_id: reader.read(),
      createdAt: DateTime.parse(reader.read()),
    );
  }

  @override
  void write(BinaryWriter writer, Projet obj) {
    writer.write(obj.id);
    writer.write(obj.Titre);
    writer.write(obj.Description);
    writer.write(obj.Montant_Total);
    writer.write(obj.Date_debut_collecte.toIso8601String());
    writer.write(obj.Date_fin_collecte.toIso8601String());
    writer.write(obj.Histoire);
    writer.write(obj.Montant_Obtenu);
    writer.write(obj.Categorie_id);
    writer.write(obj.User_id);
    writer.write(obj.createdAt.toIso8601String());
  }
}
