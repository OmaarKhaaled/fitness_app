import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/smart_coach/data/models/session_model.dart';

abstract interface class SmartCoachRemoteDataSource {
  Future<BaseResponse<String>> sendMessage(String userMessage);
  Future<BaseResponse<void>> loadSession(SessionModel session);
  Future<BaseResponse<void>> startNewChatSession();
}
