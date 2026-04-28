import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/smart_coach/data/datasources/local/smart_coach_local_data_source.dart';
import 'package:fitness_app/features/smart_coach/data/datasources/remote/smart_coach_remote_data_source.dart';
import 'package:fitness_app/features/smart_coach/domain/repositories/smart_coach_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SmartCoachRepository)
class SmartCoachRepositoryImpl implements SmartCoachRepository {
  final SmartCoachLocalDataSource _smartCoachLocalDataSource;
  final SmartCoachRemoteDataSource _smartCoachRemoteDataSource;
  SmartCoachRepositoryImpl(
    this._smartCoachLocalDataSource,
    this._smartCoachRemoteDataSource,
  );
  @override
  Future<BaseResponse<String?>> getFirstName() async {
    return await _smartCoachLocalDataSource.getFirstName();
  }

  @override
  Future<BaseResponse<String?>> getImageUrl() async {
    return await _smartCoachLocalDataSource.getImageUrl();
  }

  @override
  Future<BaseResponse<String>> sendMessage(String userMessage) async {
    return await _smartCoachRemoteDataSource.sendMessage(userMessage);
  }
}
