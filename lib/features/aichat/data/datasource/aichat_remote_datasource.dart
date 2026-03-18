import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';

class AiChatRemoteDataSource {
  final ApiClient apiClient;

  AiChatRemoteDataSource(this.apiClient);

  static const String _model = 'gemini-2.5-flash';

  Future<String> sendMessage(String message) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'];

    debugPrint('GEMINI API KEY: "$apiKey"');

    if (apiKey == null || apiKey.trim().isEmpty) {
      throw Exception('Gemini API key not found in .env file.');
    }

    final dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      validateStatus: (status) => status != null && status < 600,
    ));

    for (int attempt = 1; attempt <= 3; attempt++) {
      try {
        final url =
            'https://generativelanguage.googleapis.com/v1beta/models/$_model:generateContent?key=${apiKey.trim()}';
        final requestData = {
          'contents': [
            {
              'parts': [
                {
                  'text':
                  'You are PlantBot 🌿, a friendly and expert plant care assistant. '
                      'Help users with plant diseases, watering schedules, soil types, '
                      'pest control, propagation, and general plant care. '
                      'Keep answers clear, practical and concise.\n\nUser: $message',
                }
              ]
            }
          ],
          'generationConfig': {
            'temperature': 0.7,
            'maxOutputTokens': 1024,
          },
          'safetySettings': [
            {
              'category': 'HARM_CATEGORY_HARASSMENT',
              'threshold': 'BLOCK_NONE',
            },
            {
              'category': 'HARM_CATEGORY_HATE_SPEECH',
              'threshold': 'BLOCK_NONE',
            },
            {
              'category': 'HARM_CATEGORY_SEXUALLY_EXPLICIT',
              'threshold': 'BLOCK_NONE',
            },
            {
              'category': 'HARM_CATEGORY_DANGEROUS_CONTENT',
              'threshold': 'BLOCK_NONE',
            },
          ],
        };

        final response = await dio.post(
          url,
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
          data: requestData,
        );

        debugPrint('GEMINI STATUS: ${response.statusCode}');
        debugPrint('GEMINI RESPONSE: ${response.data}');

        final data = response.data;

        if (data == null) {
          if (attempt < 3) {
            await Future.delayed(Duration(seconds: attempt));
            continue;
          }
          throw Exception('Empty response from server.');
        }

        if (data['error'] != null) {
          final code = data['error']['code'];
          final msg = data['error']['message'] ?? 'Unknown API error';
          debugPrint('GEMINI API ERROR: $code - $msg');

          if (code == 401 || code == 403) {
            throw Exception('Invalid Gemini API key.');
          }
          if (code == 429) {
            if (attempt < 3) {
              await Future.delayed(Duration(seconds: attempt * 3));
              continue;
            }
            throw Exception('Rate limit reached. Try again shortly.');
          }
          if (attempt < 3) {
            await Future.delayed(Duration(seconds: attempt));
            continue;
          }
          throw Exception(msg);
        }

        final blocked = data['promptFeedback']?['blockReason'];
        if (blocked != null) {
          throw Exception('Request blocked by safety filter: $blocked');
        }

        final candidates = data['candidates'];
        if (candidates == null || candidates is! List || candidates.isEmpty) {
          if (attempt < 3) {
            await Future.delayed(Duration(seconds: attempt));
            continue;
          }
          throw Exception('No response from AI. Please try again.');
        }

        final finishReason = candidates[0]['finishReason'];
        debugPrint('FINISH REASON: $finishReason');
        if (finishReason == 'SAFETY') {
          throw Exception('Response blocked. Please rephrase your question.');
        }

        final text = candidates[0]['content']?['parts']?[0]?['text'];

        if (text == null || text.toString().trim().isEmpty) {
          if (attempt < 3) {
            await Future.delayed(Duration(seconds: attempt));
            continue;
          }
          throw Exception('Empty response. Please try again.');
        }

        return text.toString().trim();

      } on DioException catch (e) {
        debugPrint('DIO ERROR TYPE: ${e.type}');
        debugPrint('DIO ERROR MSG: ${e.message}');
        debugPrint('DIO ERROR RESPONSE: ${e.response?.data}');
        debugPrint('DIO STATUS: ${e.response?.statusCode}');

        final status = e.response?.statusCode;

        if (attempt < 3 &&
            (status == 503 ||
                status == 429 ||
                e.type == DioExceptionType.connectionTimeout ||
                e.type == DioExceptionType.receiveTimeout)) {
          await Future.delayed(Duration(seconds: attempt * 2));
          continue;
        }

        if (status == 401 || status == 403) {
          throw Exception('Invalid Gemini API key.');
        }
        if (status == 429) {
          throw Exception('Rate limit reached. Try again shortly.');
        }
        if (e.type == DioExceptionType.connectionError) {
          throw Exception('No internet connection. Please check your network.');
        }
        throw Exception('Network error: ${e.message}');
      }
    }

    throw Exception('Failed after 3 attempts. Please try again.');
  }
}