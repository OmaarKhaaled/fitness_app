import 'package:bloc/bloc.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/smart_coach/data/models/session_model.dart';
import 'package:fitness_app/features/smart_coach/domain/usecases/create_session_model_use_case.dart';
import 'package:fitness_app/features/smart_coach/domain/usecases/delete_all_sessions_use_case.dart';
import 'package:fitness_app/features/smart_coach/domain/usecases/delete_session_use_case.dart';
import 'package:fitness_app/features/smart_coach/domain/usecases/get_all_sessions_use_case.dart';
import 'package:fitness_app/features/smart_coach/domain/usecases/get_profile_pic_url_use_case.dart';
import 'package:fitness_app/features/smart_coach/domain/usecases/load_session_use_case.dart';
import 'package:fitness_app/features/smart_coach/domain/usecases/send_message_use_case.dart';
import 'package:fitness_app/features/smart_coach/domain/usecases/start_new_chat_session_use_case.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/chat_page_cubit/chat_page_intents.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/chat_page_cubit/chat_page_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatPageCubit extends Cubit<ChatPageStates> {
  final CreateSessionModelUseCase _createSessionModelUseCase;
  final GetProfilePicUrlUseCase _getProfilePicUrlUseCase;
  final LoadSessionUseCase _loadSessionUseCase;
  final GetAllSessionsUseCase _getPreviousConversationsUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final DeleteAllSessionsUseCase _deleteAllSessionsUseCase;
  final DeleteSessionUseCase _deleteSessionUseCase;
  final StartNewChatSessionUseCase _startNewChatSessionUseCase;
  ChatPageCubit({
    required CreateSessionModelUseCase createSessionModelUseCase,
    required GetProfilePicUrlUseCase getProfilePicUrlUseCase,
    required LoadSessionUseCase loadSessionUseCase,
    required SendMessageUseCase sendMessageUseCase,
    required DeleteAllSessionsUseCase deleteAllSessionsUseCase,
    required GetAllSessionsUseCase getAllSessionsUseCase,
    required DeleteSessionUseCase deleteSessionUseCase,
    required StartNewChatSessionUseCase startNewChatSessionUseCase,
  }) : _createSessionModelUseCase = createSessionModelUseCase,
       _getProfilePicUrlUseCase = getProfilePicUrlUseCase,
       _sendMessageUseCase = sendMessageUseCase,
       _getPreviousConversationsUseCase = getAllSessionsUseCase,
       _loadSessionUseCase = loadSessionUseCase,
       _deleteAllSessionsUseCase = deleteAllSessionsUseCase,
       _deleteSessionUseCase = deleteSessionUseCase,
       _startNewChatSessionUseCase = startNewChatSessionUseCase,
       super(const ChatPageStates());
  void doIntent(ChatPageIntents intent) {
    switch (intent) {
      case GetProfilePicUrlIntent():
        _getProfilePicUrl();
      case SendMessageIntent(userMessage: final userMessage):
        _sendMessage(userMessage);
      case GetPreviousConversationsIntent():
        _getPreviousConversations();
      case LoadSessionIntent(sessionId: final sessionId):
        _loadSession(sessionId);
      case DeleteAllSessionsIntent():
        _deleteAllSessions();
      case DeleteSessionIntent(sessionId: final sessionId):
        _deleteSession(sessionId);
      case StartNewSessionIntent():
        _startNewSession();
    }
  }

  Future<void> _getProfilePicUrl() async {
    final result = await _getProfilePicUrlUseCase();
    result.when(
      initial: () {},
      loading: () {},
      success: (name) => emit(
        state.copyWith(
          profilePicUrl: BaseState<String?>(data: name, isLoading: false),
        ),
      ),
      failure: (f) => emit(
        state.copyWith(
          profilePicUrl: BaseState<String?>(
            errorMessage: f.message,
            isLoading: false,
          ),
        ),
      ),
    );
  }

  Future<void> _sendMessage(String userMessage) async {
    if (state.isFirstMessage) {
      final result = await _createSessionModelUseCase(userMessage);
      result.when(
        initial: () {},
        loading: () {},
        success: (session) {
          emit(
            state.copyWith(
              currentSession: BaseState<SessionModel>(data: session),
            ),
          );
        },

        failure: (f) => emit(
          state.copyWith(
            currentSession: BaseState<SessionModel>(errorMessage: f.message),
          ),
        ),
      );
    }
    emit(
      state.copyWith(
        currentSession: BaseState<SessionModel>(
          data: state.currentSession?.data,
          isLoading: true,
        ),
      ),
    );
    final result = await _sendMessageUseCase(
      userMessage,
      state.currentSession!.data!.id,
      state.isFirstMessage,
    );

    result.when(
      initial: () {},
      loading: () {},
      success: (response) {
        emit(
          state.copyWith(
            currentSession: BaseState<SessionModel>(
              data: state.currentSession?.data,
              isLoading: false,
            ),
            isFirstMessage: false,
          ),
        );
      },
      failure: (f) => emit(
        state.copyWith(
          currentSession: BaseState<SessionModel>(
            errorMessage: f.message,
            isLoading: false,
          ),
          isFirstMessage: false,
        ),
      ),
    );
  }

  Future<void> _getPreviousConversations() async {
    final result = await _getPreviousConversationsUseCase();
    emit(
      state.copyWith(
        previousConversations: const BaseState<List<SessionModel>>(
          isLoading: true,
        ),
      ),
    );
    result.when(
      initial: () {},
      loading: () {},
      success: (conversations) => emit(
        state.copyWith(
          previousConversations: BaseState<List<SessionModel>>(
            data: conversations,
            isLoading: false,
          ),
        ),
      ),
      failure: (f) => emit(
        state.copyWith(
          previousConversations: BaseState<List<SessionModel>>(
            errorMessage: f.message,
            isLoading: false,
          ),
        ),
      ),
    );
  }

  Future<void> _loadSession(String sessionId) async {
    final result = await _loadSessionUseCase(sessionId);
    emit(
      state.copyWith(
        currentSession: const BaseState<SessionModel>(isLoading: true),
        isFirstMessage: false,
      ),
    );
    result.when(
      initial: () {},
      loading: () {},
      success: (session) => emit(
        state.copyWith(
          currentSession: BaseState<SessionModel>(
            data: session,
            isLoading: false,
          ),
        ),
      ),
      failure: (f) => emit(
        state.copyWith(
          currentSession: BaseState<SessionModel>(
            errorMessage: f.message,
            isLoading: false,
          ),
        ),
      ),
    );
  }

  Future<void> _deleteAllSessions() async {
    emit(
      state.copyWith(
        previousConversations: const BaseState<List<SessionModel>>(
          isLoading: true,
        ),
      ),
    );
    final result = await _deleteAllSessionsUseCase();
    result.when(
      initial: () {},
      loading: () {},
      success: (_) => emit(
        state.copyWith(
          previousConversations: const BaseState<List<SessionModel>>(
            data: [],
            isLoading: false,
          ),
        ),
      ),
      failure: (f) => emit(
        state.copyWith(
          previousConversations: BaseState<List<SessionModel>>(
            errorMessage: f.message,
            isLoading: false,
          ),
        ),
      ),
    );
  }

  Future<void> _deleteSession(String sessionId) async {
    final result = await _deleteSessionUseCase(sessionId);
    result.when(
      initial: () {},
      loading: () {},
      success: (_) => emit(
        state.copyWith(
          previousConversations: BaseState<List<SessionModel>>(
            data: state.previousConversations?.data
                ?.where((session) => session.id != sessionId)
                .toList(),
          ),
        ),
      ),
      failure: (f) => emit(
        state.copyWith(
          previousConversations: BaseState<List<SessionModel>>(
            errorMessage: f.message,
          ),
        ),
      ),
    );
  }

  Future<void> _startNewSession() async {
    // final result = await _startNewChatSessionUseCase();
    // emit(state.copyWith(isFirstMessage: true));
    // result.when(
    //   initial: () {},
    //   loading: () {},
    //   success: (session) => emit(
    //     state.copyWith(currentSession: BaseState<SessionModel>(data: session)),
    //   ),
    //   failure: (f) => emit(
    //     state.copyWith(
    //       currentSession: BaseState<SessionModel>(errorMessage: f.message),
    //     ),
    //   ),
    // );
  }
}
