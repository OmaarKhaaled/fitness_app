import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/smart_coach/domain/repositories/smart_coach_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartNewChatSessionUseCase {
  final SmartCoachRepository _smartCoachRepository;
  StartNewChatSessionUseCase(this._smartCoachRepository);
  Future<BaseResponse<void>> call() async {
    return await _smartCoachRepository.startNewChatSession();
  }
}
