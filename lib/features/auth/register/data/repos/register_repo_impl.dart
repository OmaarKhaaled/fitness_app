import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/exception_handler.dart';
import 'package:fitness_app/features/auth/register/data/data_sources/remote/register_remote_data_source_contract.dart';
import 'package:fitness_app/features/auth/register/data/models/register_response.dart';
import 'package:fitness_app/features/auth/register/domain/models/register_request_model.dart';
import 'package:fitness_app/features/auth/register/domain/models/register_response_model.dart';
import 'package:fitness_app/features/auth/register/domain/repos/register_repo_contract.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: RegisterRepoContract)
class RegisterRepoImpl implements RegisterRepoContract{
  final RegisterRemoteDataSourceContract _registerRemoteDataSourceContract;
  RegisterRepoImpl(this._registerRemoteDataSourceContract);
  @override
  Future<BaseResponse<RegisterResponseModel>> register(RegisterRequestModel request) async{
    final response=await _registerRemoteDataSourceContract.register(request.toDTO());
    if(response is Success<RegisterResponse>){
      final res=response.data.toDomain();
      return Success<RegisterResponseModel>(res);
    }else if(response is Failure<RegisterResponse>){
      return Failure<RegisterResponseModel>(response.exception);
    }else{
      return Failure<RegisterResponseModel>(ExceptionsHandler.handle(response));
    }
  }
}