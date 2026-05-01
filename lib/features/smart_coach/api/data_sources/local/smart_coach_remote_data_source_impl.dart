import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/network/api_call.dart';
import 'package:fitness_app/core/constants/ai_model_constants.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/smart_coach/data/datasources/remote/smart_coach_remote_data_source.dart';
import 'package:fitness_app/features/smart_coach/data/models/session_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SmartCoachRemoteDataSource)
class SmartCoachRemoteDataSourceImpl implements SmartCoachRemoteDataSource {
  final GenerativeModel _model;
  late final ChatSession _chat;
  SmartCoachRemoteDataSourceImpl(this._model) {
    _chat = _model.startChat();
  }
  @override
  Future<BaseResponse<String>> sendMessage(String userMessage) {
    return apiCall(() async {
      final response = await _chat.sendMessage(Content.text(userMessage));
      return response.text ?? AppTextConstants.smartCoachNoResponse;
    });
  }

  @override
  Future<BaseResponse<void>> loadSession(SessionModel session) async {
    return apiCall(() async {
      final history = session.messages.map((msg) {
        if (msg.role == AiModelConstants.modelRole) {
          return Content.model([TextPart(msg.text)]);
        } else {
          return Content.text(msg.text);
        }
      }).toList();

      _chat = _model.startChat(history: history);
    });
  }

  @override
  Future<BaseResponse<void>> startNewChatSession() async {
    return apiCall(() async {
      _chat = _model.startChat();
    });
  }
}
