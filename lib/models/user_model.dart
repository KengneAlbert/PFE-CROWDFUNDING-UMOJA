import 'dart:io';
import 'package:hive/hive.dart';

// part "user_service.g.dart";


@HiveType(typeId: 0)
class UserProfile  {
  @HiveField(0)
  final String? supabase_id;

  @HiveField(1)
  final String? email;

  @HiveField(2)
  final String? name;

  @HiveField(3)
  final String? phone;

  @HiveField(4)
  final String? country;

  @HiveField(5)
  final String? gender;

  @HiveField(6)
  final int? age;

  @HiveField(7)
  final String? location;

  @HiveField(8)
  final String? profile_picture;

  @HiveField(9)
  final List<String>? interests;

  @HiveField(10)
  final int? pin_code;

  UserProfile({
     this.supabase_id,
     this.email,
     this.name,
     this.phone,
     this.country,
     this.gender,
     this.age,
     this.location,
     this.profile_picture,
     this.interests,
     this.pin_code,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      supabase_id: map['user_id'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      country: map['country'],
      gender: map['gender'],
      age: map['age'],
      location: map['location'],
      profile_picture: map['profile_picture'],
      interests: List<String>.from(map['interests']),
      pin_code: map['pin_code'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'supabase_id': supabase_id,
      'email': email,
      'name': name,
      'phone': phone,
      'country': country,
      'gender': gender,
      'age': age,
      'location': location,
      'profile_picture': profile_picture,
      'interests': interests,
      'pin_code': pin_code,
    };
  }
}

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 0;

  @override
  UserProfile read(BinaryReader reader) {
    final name = reader.read();
    final age = reader.read();
    final supabase_id = reader.read();
    final email = reader.read();
     return UserProfile(supabase_id: supabase_id, email: email, name: name,age: age);
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer.write(obj.supabase_id);
    writer.write(obj.email);
    writer.write(obj.name);
    writer.write(obj.age);
  }
}
