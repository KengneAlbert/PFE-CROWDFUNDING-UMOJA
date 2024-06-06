import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive/hive.dart';
import 'package:umoja/models/projet_model.dart';

class DatabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;
  static const String _boxName = 'projets';

  Future<List<Projet>> fetchProjets() async {
    var box = await Hive.openBox(_boxName);
    var localData = box.values.toList().cast<Map<String, dynamic>>();

    if (localData.isNotEmpty) {
      return localData.map((data) => Projet.fromMap(data)).toList();
    }

    final response = await _supabase.from('projets').select();
    if (response.isNotEmpty) {
      final projets = response.map<Projet>((map) => Projet.fromMap(map)).toList();
      for (var projet in projets) {
        await box.put(projet.id, projet.toMap());
      }
      return projets;
    } else {
      throw Exception('Erreur lors de la récupération des projets : est vide');
    }
  }

  Future<void> addProjet(Projet projet) async {
    final response = await _supabase.from('projets').insert(projet.toMap());
    if (response.error == null) {
      var box = await Hive.openBox(_boxName);
      await box.put(projet.id, projet.toMap());
    } else {
      throw Exception('Erreur lors de l\'ajout du projet : ${response.error!.message}');
    }
  }

  Future<void> syncLocalProjets() async {
    var box = await Hive.openBox(_boxName);
    var localData = box.values.toList().cast<Map<String, dynamic>>();

    for (var data in localData) {
      final projet = Projet.fromMap(data);
      await addProjet(projet);
      await box.delete(projet.id);
    }
  }
}
