import 'dart:convert';

class UserModel {
  String name;

  String email;
  String phone;
  String bio;
  String imageUrl;
  String cover;
  bool isVerified;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.bio,
    required this.imageUrl,
    required this.cover,
    this.isVerified = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'bio': bio,
      'imageUrl': imageUrl,
      'cover': cover,
      'isVerified': isVerified,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      bio: map['bio'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      cover: map['cover'] ?? '',
      isVerified: map['isVerified'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
