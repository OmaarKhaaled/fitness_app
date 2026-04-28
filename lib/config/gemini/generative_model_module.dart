import 'package:fitness_app/core/constants/ai_model_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

@module
abstract class GenerativeModelModule {
  @lazySingleton
  GenerativeModel get generativeModel => GenerativeModel(
    model: AiModelConstants.gemini25Flash,
    apiKey: dotenv.env[AiModelConstants.geminiApiKey]!,
    systemInstruction: Content.system(AiModelConstants.systemInstruction),
  );
}
