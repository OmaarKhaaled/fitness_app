import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Helper to wrap a widget with EasyLocalization for testing.
Widget wrapWithLocalization({
  required Widget child,
  Locale locale = const Locale(AppTextConstants.enLangKey),
}) {
  return EasyLocalization(
    supportedLocales: const [
      Locale(AppTextConstants.enLangKey),
      Locale(AppTextConstants.arLangKey),
    ],
    path: AppAssets.translationsPath,
    startLocale: locale,
    fallbackLocale: const Locale(AppTextConstants.enLangKey),
    useOnlyLangCode: true,
    saveLocale: false,
    child: child,
  );
}

/// Helper to initialize localization for tests.
Future<void> initLocalization() async {
  // This is often needed if EasyLocalization.ensureInitialized() hasn't been called
  // but in widget tests we usually just need the provider.
}
