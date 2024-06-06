import 'package:flutter/material.dart';
import 'package:umoja/models/projet_model.dart';
import 'package:umoja/services/projet_service.dart';

class ProjetViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Projet> _projets = [];
  bool _isLoading = false;

  List<Projet> get projets => _projets;
  bool get isLoading => _isLoading;

  Future<void> fetchProjets() async {
    _isLoading = true;
    notifyListeners();

    try {
      _projets = await _databaseService.fetchProjets();
    } catch (e) {
      print('Erreur lors de la récupération des projets : $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addProjet(Projet projet) async {
    try {
      await _databaseService.addProjet(projet);
      _projets.add(projet);
      notifyListeners();
    } catch (e) {
      print('Erreur lors de l\'ajout du projet : $e');
    }
  }
}
