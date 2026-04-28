import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/network/api_call.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class SmartCoachService {
  late final GenerativeModel _model;
  late final ChatSession _chat;

  SmartCoachService() {
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: dotenv.env['GEMINI_API_KEY']!,
      systemInstruction: Content.system(
        '''You are a Smart Fitness Coach assistant.
        You ONLY answer questions related to fitness, gym, workouts, nutrition, and healthy lifestyle.
        If the user asks anything unrelated (e.g., programming, Flutter, history, etc.), politely refuse and say:
        "I’m specialized in fitness and gym coaching only. Please ask me something related to that."
        You are motivating, concise, and practical.
        Always give short, actionable advice.''',
      ),
    );
    _chat = _model.startChat();
  }

  Future<BaseResponse<String>> sendMessage(String userMessage) async {
    return apiCall(() async {
      final response = await _chat.sendMessage(Content.text(userMessage));
      return response.text ?? AppTextConstants.smartCoachNoResponse;
    });
  }
}
