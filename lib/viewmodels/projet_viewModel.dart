import 'package:flutter/material.dart';
import 'package:umoja/models/projet_model.dart';
import 'package:umoja/services/projet_service.dart';

class ProjetViewModel extends ChangeNotifier {
  final ProjetService projetService;

  ProjetViewModel({required this.projetService});
  List<Projet> _projets = [];
  bool _isLoading = false;

  List<Projet> get projets => _projets;
  bool get isLoading => _isLoading;

  // Future<void> fetchProjets() async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     _projets = await _projetService.fetchProjets();
  //   } catch (e) {
  //     print('Erreur lors de la récupération des projets : $e');
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> addProjet(Projet projet) async {
    try {
      await projetService.addProjet(projet);
      _projets.add(projet);
      notifyListeners();
    } catch (e) {
      print('Erreur lors de l\'ajout du projet : $e');
    }
  }

   Future<void> updateProjet(Projet projet) async {
    await projetService.updateProjet(projet);
    final index = _projets.indexWhere((p) => p.id == projet.id);
    if (index != -1) {
      _projets[index] = projet;
    }
    notifyListeners();
  }

  Future<void> deleteProjet(String projetId) async {
    await projetService.deleteProjet(projetId);
    _projets.removeWhere((projet) => projet.id == projetId);
    notifyListeners();
  }
}
