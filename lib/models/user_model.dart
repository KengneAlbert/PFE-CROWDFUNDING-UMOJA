
class UserModel {
  final String uid;
  final String email;
  final String? name;
  final String? phone;
  final String? country;
  final String? gender;
  final int? age;
  final String? location;
  final String? profile_picture;
  final List<String>? interests;
  final int? pin_code;
 
  

  UserModel({
    required this.uid,
    required this.email,
    this.name, 
    this.phone, 
    this.country, 
    this.gender, 
    this.age, 
    this.location, 
    this.profile_picture, 
    this.interests = const [], 
    this.pin_code, 
    
  });

    factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      country: map['country'],
      gender: map['gender'],
      age: map['age'],
      location: map['location'],
      profile_picture: map['profile_picture'],
      interests: map.containsKey('interests')? map['interests'].map<String>((value) => value.toString()).toList() : <String>[],
      pin_code: map['pin_code'],
    );
  }

  get favory => null;

  get state => null;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
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




