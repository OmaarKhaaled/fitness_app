import 'package:easy_localization/easy_localization.dart';
import 'config/bloc_observer/bloc_observer.dart';
import 'config/di/di.dart';
import 'core/constants/app_assets.dart';
import 'core/constants/app_text_constants.dart';
import 'fitness_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await configureDependencies();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale(AppTextConstants.enLangKey),
        Locale(AppTextConstants.arLangKey),
      ],
      path: AppAssets.translationsPath,
      startLocale: null, // Let EasyLocalization detect device locale
      fallbackLocale: const Locale(AppTextConstants.enLangKey),
      useOnlyLangCode:
          true, // Use only language code (ar, en) instead of full locale (ar_EG, en_US)
      saveLocale: false,
      child: const FitnessApp(),
    ),
  );
}
