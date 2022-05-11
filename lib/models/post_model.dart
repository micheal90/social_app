
class PostModel {
  String uId;
  String name;
  String dateTime;
  String image;
  String text;
  String postId;
  String postImage;
  List<String> likes;
  List<PostComment> comments;
  List<String> tags;
  PostModel({
    required this.uId,
    required this.name,
    required this.dateTime,
    required this.image,
    required this.text,
    required this.postId,
    required this.postImage,
    required this.likes,
    required this.comments,
    required this.tags,
  });

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'dateTime': dateTime,
      'image': image,
      'text': text,
      'postId': postId,
      'postImage': postImage,
      'likes': likes,
      'comments': comments.map((x) => x.toMap()).toList(),
      'tags': tags,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      uId: map['uId'] ?? '',
      name: map['name'] ?? '',
      dateTime: map['dateTime'] ?? '',
      image: map['image'] ?? '',
      text: map['text'] ?? '',
      postId: map['postId'] ?? '',
      postImage: map['postImage'] ?? '',
      likes: List<String>.from(map['likes']),
      comments: List<PostComment>.from(map['comments']?.map((x) => PostComment.fromMap(x))),
      tags: List<String>.from(map['tags']),
    );
  }

  
}

class PostComment {
  String userId;
  String value;
  String name;
  String imageUrl;
  PostComment({
    required this.userId,
    required this.value,
    required this.name,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'value': value,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory PostComment.fromMap(Map<String, dynamic> map) {
    return PostComment(
      userId: map['userId'] ?? '',
      value: map['value'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
