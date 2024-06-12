import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:umoja/models/projet_model.dart';

class ProjetService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Future<List<Projet>> fetchProjets() async {
  //
  //   final List<Projet> localProjets = box.values.toList().cast<Projet>();
  //   try{
  //     final response = await _supabase.from('projets').select();
  //   }catch (error){
  //     throw Exception('Erreur lors de la récupération des projets : ${error}');
  //   }
    
  //   final List<Projet> remoteProjets = (response.data as List)
  //       .map((data) => Projet.fromMap(data as Map<String, dynamic>))
  //       .toList();

  //   await box.putAll({for (var projet in remoteProjets) projet.id: projet});

  //   return remoteProjets;
  // }

  // Future<List<Projet>> fetchProjets() async {
  //   var box = await Hive.openBox(_boxName);
  //   var localData = box.values.toList().cast<Map<String, dynamic>>();

  //   if (localData.isNotEmpty) {
  //     return localData.map((data) => Projet.fromMap(data)).toList();
  //   }

  //   final response = await _supabase.from('projets').select();
  //   if (response.isNotEmpty) {
  //     final projets = response.map<Projet>((map) => Projet.fromMap(map)).toList();
  //     for (var projet in projets) {
  //       await box.put(projet.id, projet.toMap());
  //     }
  //     return projets;
  //   } else {
  //     throw Exception('Erreur lors de la récupération des projets : est vide');
  //   }
  // }

  // Future<void> addProjet(Projet projet) async {
  //   final response = await _supabase.from('projets').insert(projet.toMap());
  //   if (response.error == null) {
  //   } else {
  //     throw Exception('Erreur lors de la création du projet : ${response.error!.message}');
  //   }
  // }

  // Future<Projet> updateProjet(Projet projet) async {

  //   final response = await _supabase
  //       .from('projets')
  //       .update(projet.toMap())
  //       .eq('id', projet.id);
  //   if (response.error != null) {
  //     throw Exception('Erreur lors de la mise à jour du projet : ${response.error!.message}');
  //   }
  //   return projet;
  // }

  //  Future<void> deleteProjet(String projetId) async {
  //   final response = await _supabase.from('projects').delete().eq('id', projetId);
  //   if (response.error != null) {
  //     throw Exception('Erreur lors de la suppression du projet : ${response.error!.message}');
  //   }
  // }
}
