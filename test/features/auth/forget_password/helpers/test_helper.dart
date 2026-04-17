import 'package:fitness_app/features/auth/forget_password/api/api_client/forget_password_api_client.dart';
import 'package:fitness_app/features/auth/forget_password/data/data_sources/forget_password_data_source.dart';
import 'package:fitness_app/features/auth/forget_password/domain/use_cases/forget_password_use_case.dart';
import 'package:fitness_app/features/auth/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:fitness_app/features/auth/forget_password/domain/use_cases/verify_code_use_case.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  ForgetPasswordApiClient,
  ForgetPasswordDataSource,
  ForgetPasswordUseCase,
  ResetPasswordUseCase,
  VerifyCodeUseCase,
])
void main() {}
