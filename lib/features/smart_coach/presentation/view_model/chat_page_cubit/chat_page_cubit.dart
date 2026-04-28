import 'package:bloc/bloc.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/smart_coach/domain/usecases/get_profile_pic_url_use_case.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/chat_page_cubit/chat_page_intents.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/chat_page_cubit/chat_page_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatPageCubit extends Cubit<ChatPageStates> {
  final GetProfilePicUrlUseCase _getProfilePicUrlUseCase;
  ChatPageCubit({required GetProfilePicUrlUseCase getProfilePicUrlUseCase})
    : _getProfilePicUrlUseCase = getProfilePicUrlUseCase,
      super(const ChatPageStates());
  void doIntent(ChatPageIntents intent) {
    switch (intent) {
      case GetProfilePicUrlIntent():
        _getProfilePicUrl();
    }
  }

  Future<void> _getProfilePicUrl() async {
    final result = await _getProfilePicUrlUseCase();
    result.when(
      initial: () => emit(
        state.copyWith(
          profilePicUrl: const BaseState<String?>(isLoading: true),
        ),
      ),
      loading: () => emit(
        state.copyWith(
          profilePicUrl: const BaseState<String?>(isLoading: true),
        ),
      ),
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
}
