class AiModelConstants {
  static const String gemini25Flash = 'gemini-2.5-flash';
  static const String geminiApiKey = 'GEMINI_API_KEY';
  static const String systemInstruction =
      '''You are a Smart Fitness Coach assistant.
        You ONLY answer questions related to fitness, gym, workouts, nutrition, and healthy lifestyle.
        If the user asks anything unrelated (e.g., programming, Flutter, history, etc.), politely refuse and say:
        "I’m specialized in fitness and gym coaching only. Please ask me something related to that."
        You are motivating, concise, and practical.
        Always give short, actionable advice.''';
  static const String roleKey = 'role';
  static const String messageKey = 'message';
  static const String userRole = 'user';
  static const String modelRole = 'model';
  static const String sessionNotFound = 'Session Not Found';
  static const String geminiApiKeyFromEnv = String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: '',
  );
}
