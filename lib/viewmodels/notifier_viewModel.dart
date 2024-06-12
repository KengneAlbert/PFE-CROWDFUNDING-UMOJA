import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/notifier_model.dart';
import 'package:umoja/services/database_service.dart';

class NotifierViewModel extends StateNotifier<List<NotifierModel?>> {
 final DatabaseService databaseService;
  bool _isLoading = false;

  NotifierViewModel({required this.databaseService}):super([]);

  bool get isLoading => _isLoading;

  Future<void> setFavorisProjet(String userId, String notificationId, DateTime dateAjout)async{
    _isLoading = true;
    state = [...state];
    try{
        final  notifierMap = { 'notificationId' : notificationId, 'userId' : userId, 'dateAjout' : dateAjout};
        await databaseService.update("Notifier", notifierMap);
        await fetchAllNotifier();
    }catch (e){
      print(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> fetchAllNotifier() async {
    _isLoading = true;
    state = [...state];
    try {
      final notifier = await databaseService.fetchAll('Notifier');
      state = notifier.map((e) => e != null ? NotifierModel.fromMap(e) : null).toList();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }


  Future<void> updateAjoutProjet(String id, NotifierModel Notifier) async {
    _isLoading = true;
    state = [...state];
    try {
      await databaseService.update('Notifier/$id', Notifier.toMap());
      await fetchAllNotifier();
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
      await databaseService.delete('Notifier/$id');
      await fetchAllNotifier();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }
}