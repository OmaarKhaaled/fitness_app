import 'package:fitness_app/config/base_response/base_response.dart';
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
  String? _currentSessionId;
  bool _isFirstMessage = true;
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
  Future<BaseResponse<String>> sendMessage(String userMessage) async {
    if (_isFirstMessage) {
      _currentSessionId = DateTime.now().millisecondsSinceEpoch.toString();
      final title = userMessage.length > 30
          ? '${userMessage.substring(0, 30)}...'
          : userMessage;
      final session = SessionModel(
        id: _currentSessionId!,
        title: title,
        createdAt: DateTime.now(),
        messages: [],
      );
      await _smartCoachLocalDataSource.saveSession(session);
      _isFirstMessage = false;
    }
    await _smartCoachLocalDataSource.appendMessage(
      _currentSessionId!,
      ChatMessageModel(role: AiModelConstants.userRole, text: userMessage),
    );
    final result = await _smartCoachRemoteDataSource.sendMessage(userMessage);
    return result.when(
      initial: () => const BaseResponse<String>.initial(),
      loading: () => const BaseResponse<String>.loading(),
      success: (response) async {
        await _smartCoachLocalDataSource.appendMessage(
          _currentSessionId!,
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
  Future<BaseResponse<void>> loadSession(String sessionId) async {
    final session = await _smartCoachLocalDataSource.loadLocalSession(
      sessionId,
    );
    return session.when(
      initial: () {
        return const BaseResponse<void>.initial();
      },
      loading: () {
        return const BaseResponse<void>.loading();
      },
      success: (session) async {
        if (session == null) {
          return const BaseResponse<void>.success(null);
        }
        _currentSessionId = sessionId;
        _isFirstMessage = false;
        return await _smartCoachRemoteDataSource.loadSession(session);
      },
      failure: (e) {
        return BaseResponse.failure(e);
      },
    );
  }

  @override
  Future<BaseResponse<void>> startNewChatSession() async {
    _currentSessionId = null;
    _isFirstMessage = true;
    return await _smartCoachRemoteDataSource.startNewChatSession();
  }
}
