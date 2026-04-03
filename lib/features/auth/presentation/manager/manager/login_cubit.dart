import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/services/token_service.dart';
import 'package:fitness_app/features/auth/data/models/request/login_request.dart';
import 'package:fitness_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:fitness_app/features/auth/presentation/manager/manager/login_intent.dart';
import 'package:fitness_app/features/auth/presentation/manager/manager/login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  final LoginUseCase _loginUseCase;
  final TokenService _tokenService;

  LoginCubit(this._loginUseCase, this._tokenService) : super(LoginStates.initial());

  void doIntent(LoginIntent intent) {
    if (intent is PerformLogin) {
      _performLogin(
        email: intent.email,
        password: intent.password,
        rememberMe: intent.rememberMe,
      );
    } else if (intent is ToggleRememberMe) {
      emit(state.copyWith(rememberMe: intent.value));
    }
  }

  Future<void> _performLogin({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(state.copyWith(loginResource: const BaseResponse.loading()));
    
    final request = LoginRequest(email: email, password: password);
    final result = await _loginUseCase.call(request);

    result.when(
      initial: () => emit(state.copyWith(loginResource: const BaseResponse.initial())),
      loading: () => emit(state.copyWith(loginResource: const BaseResponse.loading())),
      success: (data) async {
        await _tokenService.saveToken(data.token);
        emit(state.copyWith(loginResource: BaseResponse.success(data)));
      },
      failure: (exception) {
        emit(state.copyWith(loginResource: BaseResponse.failure(exception)));
      },
    );
  }
}
