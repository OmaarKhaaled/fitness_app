import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/network/api_call.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/smart_coach/data/datasources/remote/smart_coach_remote_data_source.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SmartCoachRemoteDataSource)
class SmartCoachRemoteDataSourceImpl implements SmartCoachRemoteDataSource {
  final GenerativeModel _model;
  late final ChatSession _chat;
  SmartCoachRemoteDataSourceImpl(this._model) {
    _chat = _model.startChat();
  }
  @override
  Future<BaseResponse<String>> sendMessage(String userMessage) {
    return apiCall(() async {
      final response = await _chat.sendMessage(Content.text(userMessage));
      return response.text ?? AppTextConstants.smartCoachNoResponse;
    });
  }
}
