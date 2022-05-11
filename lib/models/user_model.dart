

class UserModel {
  String name;
  String uId;
  String email;
  String phone;
  String bio;
  String imageUrl;
  String cover;
  bool isVerified;
  String messageToken;

  UserModel({
    required this.name,
    required this.uId,
    required this.email,
    required this.phone,
    required this.bio,
    required this.imageUrl,
    required this.cover,
    this.isVerified = false,
    required this.messageToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'email': email,
      'phone': phone,
      'bio': bio,
      'imageUrl': imageUrl,
      'cover': cover,
      'isVerified': isVerified,
      'messageToken': messageToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      uId: map['uId'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      bio: map['bio'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      cover: map['cover'] ?? '',
      isVerified: map['isVerified'] ?? false,
      messageToken: map['messageToken'] ?? '',
    );
  }

  
}
