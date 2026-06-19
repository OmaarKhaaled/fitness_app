import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/cache_modules/secure_storege_module.dart';
import 'package:fitness_app/config/errors/local_exception.dart';
import 'package:fitness_app/core/constants/cache_constants.dart';
import 'package:fitness_app/features/smart_coach/data/datasources/local/smart_coach_local_data_source.dart';
import 'package:fitness_app/features/smart_coach/data/models/chat_message.dart';
import 'package:fitness_app/features/smart_coach/data/models/session_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SmartCoachLocalDataSource)
class SmartCoachLocalDataSourceImpl implements SmartCoachLocalDataSource {
  final SecureStorageService _secureStorageService;
  final Box<SessionModel> _sessionBox;
  SmartCoachLocalDataSourceImpl(this._secureStorageService, this._sessionBox);
  @override
  Future<BaseResponse<String?>> getFirstName() async {
    return await _secureStorageService.read(CacheConstants.firstName);
  }

  @override
  Future<BaseResponse<String?>> getImageUrl() async {
    return await _secureStorageService.read(CacheConstants.imageUrl);
  }

  @override
  Future<BaseResponse<void>> saveSession(SessionModel session) async {
    try {
      await _sessionBox.put(session.id, session);
      return const BaseResponse.success(null);
    } catch (e) {
      return BaseResponse.failure(CacheException(e.toString()));
    }
  }

  @override
  Future<BaseResponse<SessionModel?>> loadLocalSession(String sessionId) async {
    try {
      final session = _sessionBox.get(sessionId);
      if (session == null) return const BaseResponse.success(null);
      final updatedMessages = session.messages
          .map((element) => element.copyWith(isCached: true))
          .toList();
      final updatedSession = session.copyWith(messages: updatedMessages);
      return BaseResponse.success(updatedSession);
    } catch (e) {
      return BaseResponse.failure(CacheException(e.toString()));
    }
  }

  @override
  Future<BaseResponse<List<SessionModel>>> getAllSessions() async {
    try {
      final sessions = _sessionBox.values.toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return BaseResponse.success(sessions);
    } catch (e) {
      return BaseResponse.failure(CacheException(e.toString()));
    }
  }

  @override
  Future<BaseResponse<void>> deleteSession(String sessionId) async {
    try {
      await _sessionBox.delete(sessionId);
      return const BaseResponse.success(null);
    } catch (e) {
      return BaseResponse.failure(CacheException(e.toString()));
    }
  }

  @override
  Future<BaseResponse<void>> deleteAllSession() async {
    try {
      await _sessionBox.clear();
      return const BaseResponse.success(null);
    } catch (e) {
      return BaseResponse.failure(CacheException(e.toString()));
    }
  }

  @override
  Future<BaseResponse<void>> appendMessage(
    String sessionId,
    ChatMessageModel message,
  ) async {
    try {
      final session = _sessionBox.get(sessionId);
      if (session == null)
        return const BaseResponse.failure(CacheException('Session not found'));
      session.messages.add(message);
      await session.save();
      return const BaseResponse.success(null);
    } catch (e) {
      return BaseResponse.failure(CacheException(e.toString()));
    }
  }
}
