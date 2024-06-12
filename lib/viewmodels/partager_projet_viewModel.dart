import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/services/database_service.dart';

import '../models/partage_model.dart';

class PartageProjetViewModel extends StateNotifier<List<PartageProjetModel?>> {
 final DatabaseService databaseService;
 final String projetId;
  bool _isLoading = false;

  PartageProjetViewModel(this.projetId, {required this.databaseService}):super([]);

  bool get isLoading => _isLoading;

  Future<void> setPartageProjet(String typePartage, String urlPartage)async{
    _isLoading = true;
    state = [...state];
    try{
        final  projetMap = { 'typePartage' : typePartage, 'urlPartage' : urlPartage};
        await databaseService.update("Projets/$projetId/PartageProjet", projetMap);
        await fetchAllPartageProjets();
    }catch (e){
      print(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> fetchAllPartageProjets() async {
    _isLoading = true;
    state = [...state];
    try {
      final PartageProjets = await databaseService.fetchAll('Projets/$projetId/PartageProjet');
      state = PartageProjets.map((e) => e != null ? PartageProjetModel.fromMap(e) : null).toList();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }


  Future<void> updatePartageProjet(String id, PartageProjetModel projet) async {
    _isLoading = true;
    state = [...state];
    try {
      await databaseService.update('Projets/$projetId/PartageProjet/$id', projet.toMap());
      await fetchAllPartageProjets();
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
      await databaseService.delete('Projets/$projetId/PartageProjet/$id');
      await fetchAllPartageProjets();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }
}