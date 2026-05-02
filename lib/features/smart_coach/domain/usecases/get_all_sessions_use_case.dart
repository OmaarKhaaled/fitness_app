import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/smart_coach/data/models/session_model.dart';
import 'package:fitness_app/features/smart_coach/domain/repositories/smart_coach_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllSessionsUseCase {
  final SmartCoachRepository _smartCoachRepository;
  GetAllSessionsUseCase(this._smartCoachRepository);
  Future<BaseResponse<List<SessionModel>>> call() async {
    return await _smartCoachRepository.getAllSessions();
  }
}
