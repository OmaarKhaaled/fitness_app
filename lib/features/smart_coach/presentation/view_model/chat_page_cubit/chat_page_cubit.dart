import 'package:bloc/bloc.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/core/constants/ai_model_constants.dart';
import 'package:fitness_app/features/smart_coach/domain/usecases/get_profile_pic_url_use_case.dart';
import 'package:fitness_app/features/smart_coach/domain/usecases/send_message_use_case.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/chat_page_cubit/chat_page_intents.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/chat_page_cubit/chat_page_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatPageCubit extends Cubit<ChatPageStates> {
  final GetProfilePicUrlUseCase _getProfilePicUrlUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  ChatPageCubit({
    required GetProfilePicUrlUseCase getProfilePicUrlUseCase,
    required SendMessageUseCase sendMessageUseCase,
  }) : _getProfilePicUrlUseCase = getProfilePicUrlUseCase,
       _sendMessageUseCase = sendMessageUseCase,
       super(const ChatPageStates());
  void doIntent(ChatPageIntents intent) {
    switch (intent) {
      case GetProfilePicUrlIntent():
        _getProfilePicUrl();
      case SendMessageIntent(userMessage: final userMessage):
        _sendMessage(userMessage);
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
    final List<Map<String, String>> messages = state.messages?.data ?? [];
    messages.add({
      AiModelConstants.roleKey: AiModelConstants.userRole,
      AiModelConstants.messageKey: userMessage,
    });
    emit(
      state.copyWith(
        messages: BaseState<List<Map<String, String>>>(
          data: messages,
          isLoading: true,
        ),
      ),
    );
    final result = await _sendMessageUseCase(userMessage);
    result.when(
      initial: () {},
      loading: () {},
      success: (response) {
        messages.add({
          AiModelConstants.roleKey: AiModelConstants.modelRole,
          AiModelConstants.messageKey: response,
        });
        emit(
          state.copyWith(
            messages: BaseState<List<Map<String, String>>>(
              data: messages,
              isLoading: false,
            ),
          ),
        );
      },
      failure: (f) => emit(
        state.copyWith(
          messages: BaseState<List<Map<String, String>>>(
            errorMessage: f.message,
            isLoading: false,
          ),
        ),
      ),
    );
  }
}
