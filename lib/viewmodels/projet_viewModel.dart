import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/projet_model.dart';
import 'package:umoja/services/database_service.dart';

class ProjetViewModel extends StateNotifier<List<ProjetModel?>>{
  final DatabaseService projetService;
  bool _isLoading = false;

  ProjetViewModel({required this.projetService}):super([]);
  
  bool get isLoading => _isLoading;

  Future<void> setProjet(String titre, String description, int montantTotal, DateTime dateDebutCollecte, DateTime dateFinCollecte, String? histoire, int montantObtenu, int CategorieId, int userId, DateTime createdAt)async{
    _isLoading = true;
    state = [...state];
    try{
        final ProjetModel projetModel = ProjetModel(titre: titre, description: description, montantTotal: montantTotal, dateDebutCollecte: dateDebutCollecte, dateFinCollecte: dateFinCollecte, montantObtenu: montantObtenu, CategorieId: CategorieId, userId: userId, createdAt: createdAt);
        await projetService.update("Projets", projetModel.toMap());
        await fetchAllProjets();
    }catch (e){
      print(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> fetchAllProjets() async {
    _isLoading = true;
    state = [...state];
    try {
      final projets = await projetService.fetchAll('Projets');
      state = projets.map((e) => e != null ? ProjetModel.fromMap(e) : null ).toList();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }


  Future<void> fetchProjetsByCategorie(int categorieId) async {
    _isLoading = true;
    state = [...state];
    try {
      final projets = await projetService.fetchByCategorie('Projets', categorieId);
      state = projets.map((e) => e != null ? ProjetModel.fromMap(e) : null).toList();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }


  Future<void> updateProjet(String id, ProjetModel projet) async {
    _isLoading = true;
    state = [...state];
    try {
      await projetService.update('Projets/$id', projet.toMap());
      await fetchAllProjets();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> deleteProjet(String id) async {
    _isLoading = true;
    state = [...state];
    try {
      await projetService.delete('Projets/$id');
      await fetchAllProjets();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }

}
