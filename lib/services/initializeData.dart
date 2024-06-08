// import 'package:hive/hive.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:umoja/models/user_model.dart';

// class DataInitializer {
//   final SupabaseClient supabase;

//   DataInitializer({required this.supabase});

//   Future<void> initializeData() async {
//     // Initialize Hive Box
//     var box = await Hive.openBox<UserProfile>('userProfileBox');

//     // Check if box is empty before inserting initial data
//     if (box.isEmpty) {
//       // Create initial user profiles
//       List<UserProfile> initialProfiles = _createInitialUserProfiles();

//       // Insert into Hive
//       for (var profile in initialProfiles) {
//         await box.put(profile.supabase_id, profile);
//       }

//       // Insert into Supabase
//       final response = await supabase.from('users_umoja').insert(
//         initialProfiles.map((profile) => profile.toMap()).toList(),
//       );
//       if (response.error != null) {
//         throw Exception('Error inserting initial data: ${response.error!.message}');
//       }
//     }
//   }

//   List<UserProfile> _createInitialUserProfiles() {
//     return [
//       UserProfile(
//         supabase_id: 1,
//         email: 'user1@example.com',
//         name: 'User One',
//         phone: '1234567890',
//         country: 'Country1',
//         gender: 'Male',
//         age: 25,
//         location: 'Location1',
//         profile_picture: 'path/to/profile1.jpg',
//         interests: ['Interest1', 'Interest2'],
//         pin_code: 1111,
//       ),
//       UserProfile(
//         supabase_id: '125-485511',
//         email: 'user2@example.com',
//         name: 'User Two',
//         phone: '0987654321',
//         country: 'Country2',
//         gender: 'Female',
//         age: 30,
//         location: 'Location2',
//         profile_picture: 'path/to/profile2.jpg',
//         interests: ['Interest3', 'Interest4'],
//         pin_code: 2222,
//       ),
//       // Add more profiles as needed
//     ];
//   }
// }
