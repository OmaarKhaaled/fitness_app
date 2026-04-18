import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/core/api_manager/api_client.dart';
import 'package:fitness_app/features/auth/login/api/login_remote_data_source_impl.dart';
import 'package:fitness_app/features/auth/login/data/models/request/login_request.dart';
import 'package:fitness_app/features/auth/login/data/models/response/login_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'aurh_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late LoginRemoteDataSourceImpl dataSource;

  setUpAll(() {
    mockApiClient = MockApiClient();
    dataSource = LoginRemoteDataSourceImpl(mockApiClient);
  });
  final loginRequest = LoginRequest(email: "test@test.com", password: "123456");

group("LoginRemoteDataSourceImpl.login()", (){
  test("should return BaseResponse.success when login is successful", ()async{
    final loginResponse = LoginResponse(
      message:"success",
      token: "token",
    );
    when(mockApiClient.login(loginRequest)).thenAnswer((_) async => loginResponse);
    final result = await dataSource.login(loginRequest);
    expect(result, BaseResponse.success(loginResponse));
  });
});
}