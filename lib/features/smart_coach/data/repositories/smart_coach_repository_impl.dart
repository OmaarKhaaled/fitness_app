import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/local_exception.dart';
import 'package:fitness_app/core/constants/ai_model_constants.dart';
import 'package:fitness_app/features/smart_coach/data/datasources/local/smart_coach_local_data_source.dart';
import 'package:fitness_app/features/smart_coach/data/datasources/remote/smart_coach_remote_data_source.dart';
import 'package:fitness_app/features/smart_coach/data/models/chat_message.dart';
import 'package:fitness_app/features/smart_coach/data/models/session_model.dart';
import 'package:fitness_app/features/smart_coach/domain/repositories/smart_coach_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SmartCoachRepository)
class SmartCoachRepositoryImpl implements SmartCoachRepository {
  final SmartCoachLocalDataSource _smartCoachLocalDataSource;
  final SmartCoachRemoteDataSource _smartCoachRemoteDataSource;
  SmartCoachRepositoryImpl(
    this._smartCoachLocalDataSource,
    this._smartCoachRemoteDataSource,
  );
  @override
  Future<BaseResponse<String?>> getFirstName() async {
    return await _smartCoachLocalDataSource.getFirstName();
  }

  @override
  Future<BaseResponse<String?>> getImageUrl() async {
    return await _smartCoachLocalDataSource.getImageUrl();
  }

  @override
  Future<BaseResponse<SessionModel>> createSessionModel(
    String userMessage,
  ) async {
    final sessionId = DateTime.now().millisecondsSinceEpoch.toString();
    final message = ChatMessageModel(
      role: AiModelConstants.userRole,
      text: userMessage,
    );
    final title = userMessage.length > 30
        ? '${userMessage.substring(0, 30)}...'
        : userMessage;
    final session = SessionModel(
      id: sessionId,
      title: title,
      createdAt: DateTime.now(),
      messages: [message],
    );
    final response = await _smartCoachLocalDataSource.saveSession(session);
    return response.when(
      initial: () => const BaseResponse<SessionModel>.initial(),
      loading: () => const BaseResponse<SessionModel>.loading(),
      success: (_) => BaseResponse<SessionModel>.success(session),
      failure: (f) => BaseResponse<SessionModel>.failure(f),
    );
  }

  @override
  Future<BaseResponse<String>> sendMessage(
    String userMessage,
    String sessionId,
    bool isFirstMessage,
  ) async {
    if (!isFirstMessage) {
      await _smartCoachLocalDataSource.appendMessage(
        sessionId,
        ChatMessageModel(role: AiModelConstants.userRole, text: userMessage),
      );
    }
    final result = await _smartCoachRemoteDataSource.sendMessage(userMessage);
    return result.when(
      initial: () => const BaseResponse<String>.initial(),
      loading: () => const BaseResponse<String>.loading(),
      success: (response) async {
        await _smartCoachLocalDataSource.appendMessage(
          sessionId,
          ChatMessageModel(role: AiModelConstants.modelRole, text: response),
        );
        return BaseResponse<String>.success(response);
      },
      failure: (f) {
        return BaseResponse.failure(f);
      },
    );
  }

  @override
  Future<BaseResponse<SessionModel>> loadSession(String sessionId) async {
    final session = await _smartCoachLocalDataSource.loadLocalSession(
      sessionId,
    );
    return session.when(
      initial: () {
        return const BaseResponse<SessionModel>.initial();
      },
      loading: () {
        return const BaseResponse<SessionModel>.loading();
      },
      success: (session) async {
        if (session == null) {
          return const BaseResponse<SessionModel>.failure(
            CacheException(AiModelConstants.sessionNotFound),
          );
        }
        final remoteResponse = await _smartCoachRemoteDataSource.loadSession(
          session,
        );
        return remoteResponse.when(
          initial: () => const BaseResponse<SessionModel>.initial(),
          loading: () => const BaseResponse<SessionModel>.loading(),
          success: (re) => BaseResponse<SessionModel>.success(session),
          failure: (f) => BaseResponse<SessionModel>.failure(f),
        );
      },
      failure: (e) {
        return BaseResponse.failure(e);
      },
    );
  }

  @override
  Future<BaseResponse<List<SessionModel>>> getAllSessions() async {
    return await _smartCoachLocalDataSource.getAllSessions();
  }

  @override
  Future<BaseResponse<void>> deleteSession(String sessionId) async {
    return await _smartCoachLocalDataSource.deleteSession(sessionId);
  }

  @override
  Future<BaseResponse<void>> deleteAllSession() async {
    return await _smartCoachLocalDataSource.deleteAllSession();
  }

  @override
  Future<BaseResponse<void>> startNewChatSession() async {
    return await _smartCoachRemoteDataSource.startNewChatSession();
  }
}
