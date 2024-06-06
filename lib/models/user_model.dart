import 'package:hive/hive.dart';

// part 'user_profile.g.dart';

@HiveType(typeId: 0)
class UserProfile {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String country;

  @HiveField(5)
  final String gender;

  @HiveField(6)
  final int age;

  @HiveField(7)
  final String location;

  @HiveField(8)
  final String profilePicture;

  @HiveField(9)
  final List<String> interests;

  @HiveField(10)
  final String pinCode;

  UserProfile({
    required this.userId,
    required this.email,
    required this.name,
    required this.phone,
    required this.country,
    required this.gender,
    required this.age,
    required this.location,
    required this.profilePicture,
    required this.interests,
    required this.pinCode,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      userId: map['user_id'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      country: map['country'],
      gender: map['gender'],
      age: map['age'],
      location: map['location'],
      profilePicture: map['profile_picture'],
      interests: List<String>.from(map['interests']),
      pinCode: map['pin_code'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'email': email,
      'name': name,
      'phone': phone,
      'country': country,
      'gender': gender,
      'age': age,
      'location': location,
      'profile_picture': profilePicture,
      'interests': interests,
      'pin_code': pinCode,
    };
  }
}
