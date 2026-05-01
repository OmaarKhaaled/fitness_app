import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/smart_coach/domain/repositories/smart_coach_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendMessageUseCase {
  final SmartCoachRepository _smartCoachRepository;
  SendMessageUseCase(this._smartCoachRepository);
  Future<BaseResponse<String>> call(String userMessage) async {
    return await _smartCoachRepository.sendMessage(userMessage);
  }
}
