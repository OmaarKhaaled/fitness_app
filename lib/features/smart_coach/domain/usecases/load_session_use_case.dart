import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/smart_coach/data/models/session_model.dart';
import 'package:fitness_app/features/smart_coach/domain/repositories/smart_coach_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoadSessionUseCase {
  final SmartCoachRepository _smartCoachRepository;
  LoadSessionUseCase(this._smartCoachRepository);
  Future<BaseResponse<SessionModel>> call(String sessionId) async {
    return await _smartCoachRepository.loadSession(sessionId);
  }
}
