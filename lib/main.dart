import 'package:easy_localization/easy_localization.dart';
import 'config/bloc_observer/bloc_observer.dart';
import 'config/di/di.dart';
import 'core/constants/app_assets.dart';
import 'core/constants/app_text_constants.dart';
import 'fitness_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/util/webview_initializer_stub.dart'
    if (dart.library.js_util) 'core/util/webview_initializer_web.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await configureDependencies();
  await EasyLocalization.ensureInitialized();
  
  if (kIsWeb) {
    initializeWebView();
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale(AppTextConstants.enLangKey),
        Locale(AppTextConstants.arLangKey),
      ],
      path: AppAssets.translationsPath,
      startLocale: null,
      fallbackLocale: const Locale(AppTextConstants.enLangKey),
      useOnlyLangCode: true,
      saveLocale: false,
      child: const FitnessApp(),
    ),
  );
}
