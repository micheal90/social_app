import 'dart:convert';

class MessageModel {
  String value;
  String senderId;
  String recieverId;
  String dateTime;
  String senderMessageToken;
  String recieverMessageToken;
  String senderName;
  String reciverName;
  MessageModel({
    required this.value,
    required this.senderId,
    required this.recieverId,
    required this.dateTime,
    required this.senderMessageToken,
    required this.recieverMessageToken,
    required this.senderName,
    required this.reciverName,
  });

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'senderId': senderId,
      'recieverId': recieverId,
      'dateTime': dateTime,
      'senderMessageToken': senderMessageToken,
      'recieverMessageToken': recieverMessageToken,
      'senderName': senderName,
      'reciverName': reciverName,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      value: map['value'] ?? '',
      senderId: map['senderId'] ?? '',
      recieverId: map['recieverId'] ?? '',
      dateTime: map['dateTime'] ?? '',
      senderMessageToken: map['senderMessageToken'] ?? '',
      recieverMessageToken: map['recieverMessageToken'] ?? '',
      senderName: map['senderName'] ?? '',
      reciverName: map['reciverName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source));
}
