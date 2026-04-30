import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/smart_coach/domain/repositories/smart_coach_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfilePicUrlUseCase {
  final SmartCoachRepository _smartCoachRepository;
  GetProfilePicUrlUseCase(this._smartCoachRepository);
  Future<BaseResponse<String?>> call() async {
    return await _smartCoachRepository.getImageUrl();
  }
}
