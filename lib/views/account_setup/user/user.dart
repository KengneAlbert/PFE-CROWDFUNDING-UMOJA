// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class UserService with ChangeNotifier {

//   final SupabaseClient _supabase = Supabase.instance.client;

//   Future<void> createUser({
//     required String country,
//     required String name,
//     required String email,
//     required String phone,
//     required String gender,
//     required String city,
//     required List<String> interests,
//     required String pinCode,
//   }) async {
//     final response = await _supabase.from('User').insert({
//       'country': country,
//       'name': name,
//       'email': email,
//       'phone': phone,
//       'gender': gender,
//       'city': city,
//       'interests': interests,
//       'pin_code': pinCode,
//     }).execute();
//     if (response.error != null) {
//       throw response.error!;
//     }
//   }

//   Future<List<Map<String, dynamic>>> getUsers() async {
//     final response = await _supabase.from('User').select().execute();
//     if (response.error != null) {
//       throw response.error!;
//     }
//     return response.data as List<Map<String, dynamic>>;
//   }

//   Future<void> updateUser({
//     required String id,
//     required String country,
//     required String name,
//     required String email,
//     required String phone,
//     required String gender,
//     required String city,
//     required List<String> interests,
//     required String pinCode,
//   }) async {
//     final response = await _supabase.from('User').update({
//       'country': country,
//       'name': name,
//       'email': email,
//       'phone': phone,
//       'gender': gender,
//       'city': city,
//       'interests': interests,
//       'pin_code': pinCode,
//     }).eq('id', id).execute();
//     if (response.error != null) {
//       throw response.error!;
//     }
//   }

//   Future<void> deleteUser(String id) async {
//     final response = await _supabase.from('User').delete().eq('id', id).execute();
//     if (response.error != null) {
//       throw response.error!;
//     }
//   }

// }