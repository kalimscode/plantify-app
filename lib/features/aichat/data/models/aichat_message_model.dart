
import '../../domain/entities/aichat_message.dart';

class AiChatMessageModel extends AiChatMessage {
  AiChatMessageModel({
    required super.message,
    required super.isUser,
  });

  factory AiChatMessageModel.fromJson(Map<String, dynamic> json) {
    return AiChatMessageModel(
      message: json['message'],
      isUser: json['isUser'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'isUser': isUser,
    };
  }
}