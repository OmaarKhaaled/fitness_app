import 'package:fitness_app/config/cache_modules/secure_storege_module.dart';
import 'package:fitness_app/features/auth/profile/api/api_client/profile_api_client.dart';
import 'package:fitness_app/features/auth/profile/data/data_source/profile_data_source.dart';
import 'package:fitness_app/features/auth/profile/domain/repositories/user_profile_repository.dart';
import 'package:fitness_app/features/auth/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:fitness_app/features/auth/profile/domain/usecases/logout_usecase.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  ProfileApiClient,
  ProfileDataSource,
  UserProfileRepository,
  SecureStorageService,
  GetUserProfileUseCase,
  LogoutUseCase,
])
void main() {}
