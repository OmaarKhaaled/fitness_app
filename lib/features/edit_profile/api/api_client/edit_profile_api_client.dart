import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fitness_app/core/constants/api_constants.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile_request_dto.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile_response.dart';
import 'package:fitness_app/features/edit_profile/data/models/upload_photo_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'edit_profile_api_client.g.dart';
@injectable
@RestApi()
abstract class EditProfileApiClient {
  @factoryMethod
  factory EditProfileApiClient(Dio dio)=_EditProfileApiClient;
  @PUT(ApiConstants.editProfileEndpoint)
  Future<EditProfileResponse> editProfile(@Body() EditProfileRequestDto request);
  @GET(ApiConstants.getLoggedUserDataEndpoint)
  Future<EditProfileResponse> getProfile();
  @PUT(ApiConstants.uploadPhotoEndpoint)
  @MultiPart()
  Future<UploadPhotoResponse> uploadPhoto(@Part(name: 'photo') File photo);
}