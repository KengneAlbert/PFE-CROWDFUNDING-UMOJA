import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/document_projet_model.dart';
import 'package:umoja/services/database_service.dart';

class DocumentProjetViewModel extends StateNotifier<List<DocumentProjetModel?>> {
 final DatabaseService databaseService;
 final String projetId;
  bool _isLoading = false;

  DocumentProjetViewModel(this.projetId, {required this.databaseService}):super([]);

  bool get isLoading => _isLoading;

  Future<void> setDocumentProjet(String typeDocument, String urlDocument)async{
    _isLoading = true;
    state = [...state];
    try{
        final  projetMap = { 'typeDocument' : typeDocument, 'urlDocument' : urlDocument};
        await databaseService.update("Projets/$projetId/DocumentProjet", projetMap);
        await fetchAllDocumentProjets();
    }catch (e){
      print(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> fetchAllDocumentProjets() async {
    _isLoading = true;
    state = [...state];
    try {
      final documentProjets = await databaseService.fetchAll('Projets/$projetId/DocumentProjet');
      state = documentProjets.map((e) => e != null ? DocumentProjetModel.fromMap(e) : null).toList();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }


  Future<void> updateDocumentProjet(String id, DocumentProjetModel projet) async {
    _isLoading = true;
    state = [...state];
    try {
      await databaseService.update('Projets/$projetId/DocumentProjet/$id', projet.toMap());
      await fetchAllDocumentProjets();
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
      await databaseService.delete('Projets/$projetId/DocumentProjet/$id');
      await fetchAllDocumentProjets();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }
}