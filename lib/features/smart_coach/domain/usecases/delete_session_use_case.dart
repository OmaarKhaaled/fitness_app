import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/smart_coach/domain/repositories/smart_coach_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteSessionUseCase {
  final SmartCoachRepository _smartCoachRepository;
  DeleteSessionUseCase(this._smartCoachRepository);
  Future<BaseResponse<void>> call(String sessionId) async {
    return await _smartCoachRepository.deleteSession(sessionId);
  }
}
