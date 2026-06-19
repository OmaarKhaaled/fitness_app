import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/smart_coach/data/models/session_model.dart';

abstract interface class SmartCoachRepository {
  Future<BaseResponse<String?>> getFirstName();
  Future<BaseResponse<String?>> getImageUrl();
  Future<BaseResponse<SessionModel>> createSessionModel(String userMessage);
  Future<BaseResponse<String>> sendMessage(
    String userMessage,
    String sessionId,
    bool isFirstMessage,
  );
  Future<BaseResponse<SessionModel>> loadSession(String sessionId);
  Future<BaseResponse<List<SessionModel>>> getAllSessions();
  Future<BaseResponse<void>> deleteSession(String sessionId);
  Future<BaseResponse<void>> deleteAllSession();
  Future<BaseResponse<void>> startNewChatSession();
}
