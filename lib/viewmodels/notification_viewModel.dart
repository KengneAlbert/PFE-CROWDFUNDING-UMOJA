import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/notification_model.dart';
import 'package:umoja/services/database_service.dart';

class NotificationProjetViewModel extends StateNotifier<List<NotificationModel?>> {
 final DatabaseService databaseService;
  bool _isLoading = false;

  NotificationProjetViewModel({required this.databaseService}):super([]);

  bool get isLoading => _isLoading;

  Future<void> setNotification(String contenu, String statutNotification, String typeNotification, DateTime dateNotification, DateTime createdAt, DateTime updateAt)async{
    _isLoading = true;
    state = [...state];
    try{
        final  notificationMap = { 'contenu' : contenu, 'statutNotification' : statutNotification, 'typeNotification' : typeNotification, 'dateNotification' : dateNotification, 'createdAt' : createdAt, 'updateAt': updateAt};
        await databaseService.update("Notification", notificationMap);
        await fetchAllNotifications();
    }catch (e){
      print(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> fetchAllNotifications() async {
    _isLoading = true;
    state = [...state];
    try {
      final favorisProjets = await databaseService.fetchAll('Notification');
      state = favorisProjets.map((e) => e != null ? NotificationModel.fromMap(e) : null).toList();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }


  Future<void> updateNotification(String id, NotificationModel Favoris) async {
    _isLoading = true;
    state = [...state];
    try {
      await databaseService.update('Notification/$id', Favoris.toMap());
      await fetchAllNotifications();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> deleteNotification(String id) async {
    _isLoading = true;
    state = [...state];
    try {
      await databaseService.delete('Notification/$id');
      await fetchAllNotifications();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }
}