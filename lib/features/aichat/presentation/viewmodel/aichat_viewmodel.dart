import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/aichat_message.dart';
import '../../domain/repository/aichat_repository.dart';

class AiChatState {
  final List<AiChatMessage> messages;
  final bool isLoading;

  const AiChatState({
    this.messages = const [],
    this.isLoading = false,
  });

  AiChatState copyWith({
    List<AiChatMessage>? messages,
    bool? isLoading,
  }) {
    return AiChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AiChatViewModel extends StateNotifier<AiChatState> {
  final AiChatRepository repository;
  int _generation = 0;

  AiChatViewModel(this.repository) : super(const AiChatState());

  Future<void> sendMessage(String text, {bool isVoice = false}) async {
    if (text.trim().isEmpty) return;
    if (state.isLoading) return;

    final myGen = _generation;

    state = state.copyWith(
      messages: [
        ...state.messages,
        AiChatMessage(message: text, isUser: true, isVoice: isVoice),
      ],
      isLoading: true,
    );

    try {
      final response = await repository.sendMessage(text);
      if (_generation != myGen) return;

      state = state.copyWith(
        messages: [
          ...state.messages,
          AiChatMessage(message: '', isUser: false),
        ],
        isLoading: false,
      );


      String temp = '';
      for (int i = 0; i < response.length; i++) {
        if (_generation != myGen) return;

        temp += response[i];

        if (i % 3 == 0 || i == response.length - 1) {
          await Future.delayed(const Duration(milliseconds: 20));
          if (_generation != myGen) return;

          final updated = [...state.messages];
          updated[updated.length - 1] =
              AiChatMessage(message: temp, isUser: false);
          state = state.copyWith(messages: updated);
        }
      }
    } catch (e) {
      if (_generation != myGen) return;
      debugPrint('Chat error: $e');
      final errorText = e.toString().replaceFirst('Exception: ', '');
      state = state.copyWith(
        messages: [
          ...state.messages,
          AiChatMessage(message: '⚠️ $errorText', isUser: false),
        ],
        isLoading: false,
      );
    }
  }

  void deleteMessage(int index) {
    final list = [...state.messages];
    if (index >= 0 && index < list.length) {
      list.removeAt(index);
      state = state.copyWith(messages: list);
    }
  }

  void clearChat() {
    _generation++;
    state = const AiChatState();
  }
}