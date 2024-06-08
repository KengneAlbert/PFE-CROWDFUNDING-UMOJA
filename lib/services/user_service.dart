import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:umoja/models/user_model.dart';

class UserService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  static const String _boxName = 'users_umoja';
  

  Future<UserProfile> saveUserProfile(UserProfile userProfile) async {
    final box = Hive.box<UserProfile>('userProfileBox');
    await box.put(userProfile.supabase_id, userProfile);
    print('goooooooooooooooooooooooooooooooooooooooooooooooooooooooooo');
    final response = await _supabase
        .from('users_umoja')
        .upsert(userProfile.toMap());
    if (response.error != null) {
      throw Exception('Erreur lors de la sauvegarde du profil utilisateur : ${response.error!.message}');
    }
    return response;
  }

  Future<UserProfile> fetchUserProfile(String supabase_id) async {
      // Fetch from local Hive database first
      final box = Hive.box<UserProfile>('userProfileBox');
      UserProfile? userProfile = box.get(supabase_id);

      if (userProfile == null) {
        // Fetch from Supabase if not found locally
        final response = await _supabase
            .from('users_umoja')
            .select()
            .eq('id', supabase_id)
            .single();

        // if (response.error != null) {
        //   throw Exception('Erreur lors de la récupération du profil utilisateur : ${response.error!.message}');
        // }

        userProfile = UserProfile.fromMap(response.entries as Map<String, dynamic>);
        await box.put(supabase_id, userProfile);
      }
      return userProfile;
  }

  // Future<void> updateUserProfile(UserProfile userProfile) async {
  //   final box = Hive.box<UserProfile>('userProfileBox');
  //   await box.put(userProfile.supabase_id, userProfile);

  //   final response = await _supabase
  //       .from('users_umoja')
  //       .update(userProfile.toMap())
  //       .eq('supabase_id', userProfile.supabase_id);
  //   if (response.error != null) {
  //     throw Exception('Erreur lors de la mise à jour du profil utilisateur : ${response.error!.message}');
  //   }
  // }

  Future<void> deleteUserProfile(String supabase_id) async {
    final box = Hive.box<UserProfile>('userProfileBox');
    await box.delete(supabase_id);

    final response = await _supabase
        .from('users_umoja')
        .delete()
        .eq('id', supabase_id);
    if (response.error != null) {
      throw Exception('Erreur lors de la suppression du profil utilisateur : ${response.error!.message}');
    }
  }

}
