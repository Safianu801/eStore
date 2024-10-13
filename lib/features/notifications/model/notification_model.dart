import 'dart:convert';

class NotificationModel {
  final String nID;
  final String title;
  final String message;
  final String image;
  final String recipient;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationModel({
    required this.nID,
    required this.title,
    required this.message,
    required this.image,
    required this.recipient,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      nID: map['nID'] ?? '',
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      image: map['image'] ?? '',
      recipient: map['recipient'] ?? '',
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(map['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nID': nID,
      'title': title,
      'message': message,
      'image': image,
      'recipient': recipient,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));
}
