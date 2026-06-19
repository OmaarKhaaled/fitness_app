import 'package:injectable/injectable.dart';

@singleton
class LanguageManager {
  String _currentLanguage = 'en';

  String get currentLanguage => _currentLanguage;

  void setLanguage(String languageCode) {
    _currentLanguage = languageCode;
  }
}
