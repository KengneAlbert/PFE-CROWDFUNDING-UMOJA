import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/favoris_projet_model.dart';
import 'package:umoja/services/database_service.dart';

class FavorisProjetViewModel extends StateNotifier<List<FavorisProjetModel?>> {
 final DatabaseService databaseService;
  bool _isLoading = false;

  FavorisProjetViewModel({required this.databaseService}):super([]);

  bool get isLoading => _isLoading;

  Future<void> setFavorisProjet(String projetId, String userId, DateTime dateAjout)async{
    _isLoading = true;
    state = [...state];
    try{
        final  projetMap = { 'projetId' : projetId, 'userId' : userId, 'dateAjout' : dateAjout};
        await databaseService.update("Favoris", projetMap);
        await fetchAllFavorisProjets();
    }catch (e){
      print(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> fetchAllFavorisProjets() async {
    _isLoading = true;
    state = [...state];
    try {
      final favorisProjets = await databaseService.fetchAll('Favoris');
      state = favorisProjets.map((e) => e != null ? FavorisProjetModel.fromMap(e) : null).toList();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }


  Future<void> updateAjoutProjet(String id, FavorisProjetModel Favoris) async {
    _isLoading = true;
    state = [...state];
    try {
      await databaseService.update('Favoris/$id', Favoris.toMap());
      await fetchAllFavorisProjets();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> deleteFavorisProjet(String id) async {
    _isLoading = true;
    state = [...state];
    try {
      await databaseService.delete('Favoris/$id');
      await fetchAllFavorisProjets();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }
}