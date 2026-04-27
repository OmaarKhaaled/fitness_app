import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/smart_coach/data/datasources/local/smart_coach_local_data_source.dart';
import 'package:fitness_app/features/smart_coach/domain/repositories/smart_coach_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SmartCoachRepository)
class SmartCoachRepositoryImpl implements SmartCoachRepository {
  final SmartCoachLocalDataSource _smartCoachLocalDataSource;
  SmartCoachRepositoryImpl(this._smartCoachLocalDataSource);
  @override
  Future<BaseResponse<String?>> getFirstName() async {
    return await _smartCoachLocalDataSource.getFirstName();
  }
}
