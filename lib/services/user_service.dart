import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:umoja/models/user_model.dart';

Future<void> saveUserProfile(UserProfile userProfile) async {
  final box = Hive.box<UserProfile>('userProfileBox');
  await box.put(userProfile.userId, userProfile);

  final response = await Supabase.instance.client
      .from('user_profiles')
      .upsert(userProfile.toMap());
  if (response.error != null) {
    throw Exception('Erreur lors de la sauvegarde du profil utilisateur : ${response.error!.message}');
  }
}

Future<UserProfile> fetchUserProfile(String userId) async {
    // Fetch from local Hive database first
    final box = Hive.box<UserProfile>('userProfileBox');
    UserProfile? userProfile = box.get(userId);

    if (userProfile == null) {
      // Fetch from Supabase if not found locally
      final response = await Supabase.instance.client
          .from('users')
          .select()
          .eq('id', userId)
          .single();

      // if (response.error != null) {
      //   throw Exception('Erreur lors de la récupération du profil utilisateur : ${response.error!.message}');
      // }

      userProfile = UserProfile.fromMap(response.entries as Map<String, dynamic>);
      await box.put(userId, userProfile);
    }
    return userProfile;
}

Future<void> updateUserProfile(UserProfile userProfile) async {
  final box = Hive.box<UserProfile>('userProfileBox');
  await box.put(userProfile.userId, userProfile);

  final response = await Supabase.instance.client
      .from('user_profiles')
      .update(userProfile.toMap())
      .eq('user_id', userProfile.userId);
  if (response.error != null) {
    throw Exception('Erreur lors de la mise à jour du profil utilisateur : ${response.error!.message}');
  }
}

Future<void> deleteUserProfile(String userId) async {
  final box = Hive.box<UserProfile>('userProfileBox');
  await box.delete(userId);

  final response = await Supabase.instance.client
      .from('user_profiles')
      .delete()
      .eq('user_id', userId);
  if (response.error != null) {
    throw Exception('Erreur lors de la suppression du profil utilisateur : ${response.error!.message}');
  }
}
