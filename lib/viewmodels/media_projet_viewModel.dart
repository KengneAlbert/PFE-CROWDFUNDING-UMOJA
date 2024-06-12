import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/media_projet_model.dart';
import 'package:umoja/services/database_service.dart';

class MediaProjetViewModel extends StateNotifier<List<MediaProjetModel?>> {
 final DatabaseService databaseService;
 final String projetId;
  bool _isLoading = false;

  MediaProjetViewModel(this.projetId, {required this.databaseService}):super([]);

  bool get isLoading => _isLoading;

  Future<void> setMediaProjet(String typeMedia, String urlMedia)async{
    _isLoading = true;
    state = [...state];
    try{
        final  projetMap = { 'typeMedia' : typeMedia, 'urlMedia' : urlMedia};
        await databaseService.update("Projets/$projetId/MediaProjet", projetMap);
        await fetchAllMediaProjets();
    }catch (e){
      print(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> fetchAllMediaProjets() async {
    _isLoading = true;
    state = [...state];
    try {
      final MediaProjets = await databaseService.fetchAll('Projets/$projetId/MediaProjet');
      state = MediaProjets.map((e) => e != null ? MediaProjetModel.fromMap(e) : null).toList();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }


  Future<void> updateMediaProjet(String id, MediaProjetModel projet) async {
    _isLoading = true;
    state = [...state];
    try {
      await databaseService.update('Projets/$projetId/MediaProjet/$id', projet.toMap());
      await fetchAllMediaProjets();
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
      await databaseService.delete('Projets/$projetId/MediaProjet/$id');
      await fetchAllMediaProjets();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }
}