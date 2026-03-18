class AiChatMessage {
  final String message;
  final bool isUser;
  final bool isVoice;

  AiChatMessage({
    required this.message,
    required this.isUser,
    this.isVoice = false,
  });
}