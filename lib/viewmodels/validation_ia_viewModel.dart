import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/validation_ia_model.dart';
import 'package:umoja/services/database_service.dart';

class ValidationIaProjetViewModel extends StateNotifier<List<ValidationIAProjetModel?>> {
 final DatabaseService databaseService;
 final String projetId;
  bool _isLoading = false;

  ValidationIaProjetViewModel(this.projetId, {required this.databaseService}):super([]);

  bool get isLoading => _isLoading;

  Future<void> setValidationIaProjet(String typeValidationIa, String urlValidationIa)async{
    _isLoading = true;
    state = [...state];
    try{
        final  projetMap = { 'typeValidationIa' : typeValidationIa, 'urlValidationIa' : urlValidationIa};
        await databaseService.update("Projets/$projetId/ValidationIaProjet", projetMap);
        await fetchAllValidationIaProjets();
    }catch (e){
      print(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> fetchAllValidationIaProjets() async {
    _isLoading = true;
    state = [...state];
    try {
      final ValidationIaProjets = await databaseService.fetchAll('Projets/$projetId/ValidationIaProjet');
      state = ValidationIaProjets.map((e) => e != null ? ValidationIAProjetModel.fromMap(e) : null).toList();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }


  Future<void> updateValidationIaProjet(String id, ValidationIAProjetModel projet) async {
    _isLoading = true;
    state = [...state];
    try {
      await databaseService.update('Projets/$projetId/ValidationIaProjet/$id', projet.toMap());
      await fetchAllValidationIaProjets();
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
      await databaseService.delete('Projets/$projetId/ValidationIaProjet/$id');
      await fetchAllValidationIaProjets();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }
}