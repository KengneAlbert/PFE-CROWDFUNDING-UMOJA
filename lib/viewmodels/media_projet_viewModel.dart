import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/main.dart';
import 'package:umoja/models/media_projet_model.dart';
import 'package:umoja/services/database_service.dart';

class MediaProjetViewModel extends StateNotifier<List<MediaProjetModel?>> {
  final DatabaseService databaseService;
  final String projetId;
  bool _isLoading = false;

  MediaProjetViewModel(this.projetId, {required this.databaseService}) : super([]);

  bool get isLoading => _isLoading;

  // Function to add media to a project
  Future<void> setMediaProjet(String typeMedia, List<String> urlMedia) async {
    _isLoading = true;
    state = [...state];
    try {
      for (final url in urlMedia) {
        await databaseService.create('Projets/$projetId/MediaProjet', {'typeMedia': typeMedia, 'urlMedia': url});
      }
      await fetchAllMediaProjets();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }

  // Function to fetch all media for a project
  Future<void> fetchAllMediaProjets() async {
    _isLoading = true;
    state = [...state];
    try {
      final mediaProjets = await databaseService.fetchAll('Projets/$projetId/MediaProjet');
      state = mediaProjets.map((e) => e != null ? MediaProjetModel.fromMap(e) : null).toList();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }

  // Function to update media for a project
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

  // Function to delete media from a project
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

final mediaProjetViewModelProvider = StateNotifierProvider.family<MediaProjetViewModel, List<MediaProjetModel?>, String>(
  (ref, projetId) => MediaProjetViewModel(projetId, databaseService: ref.watch(databaseServiceProvider)),
);
