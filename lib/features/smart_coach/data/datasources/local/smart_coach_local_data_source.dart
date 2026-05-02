import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/smart_coach/data/models/chat_message.dart';
import 'package:fitness_app/features/smart_coach/data/models/session_model.dart';

abstract interface class SmartCoachLocalDataSource {
  Future<BaseResponse<String?>> getFirstName();
  Future<BaseResponse<String?>> getImageUrl();
  Future<BaseResponse<void>> saveSession(SessionModel session);
  Future<BaseResponse<SessionModel?>> loadLocalSession(String sessionId);
  Future<BaseResponse<List<SessionModel>>> getAllSessions();
  Future<BaseResponse<void>> deleteSession(String sessionId);
  Future<BaseResponse<void>> deleteAllSession();
  Future<BaseResponse<void>> appendMessage(
    String sessionId,
    ChatMessageModel message,
  );
}
