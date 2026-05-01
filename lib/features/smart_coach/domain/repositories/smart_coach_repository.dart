import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/smart_coach/data/models/session_model.dart';

abstract interface class SmartCoachRepository {
  Future<BaseResponse<String?>> getFirstName();
  Future<BaseResponse<String?>> getImageUrl();
  Future<BaseResponse<String>> sendMessage(String userMessage);
  Future<BaseResponse<void>> loadSession(String sessionId);
  Future<BaseResponse<List<SessionModel>>> getAllSessions();
  Future<BaseResponse<void>> startNewChatSession();
  Future<BaseResponse<void>> deleteSession(String sessionId);
}
