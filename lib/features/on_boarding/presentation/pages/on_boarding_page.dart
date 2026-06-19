import 'package:fitness_app/config/cache_modules/secure_storege_module.dart';
import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/constants/cache_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_text_constants.dart';
import '../widgets/on_boarding_bottom_sheet.dart';
import '../widgets/on_boarding_pics_section.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  SecureStorageService secureStorageService = getIt<SecureStorageService>();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0Xff54433b),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.onboardingBackGround),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
              TextButton(
                onPressed: () {
                  secureStorageService.writeBool(
                    CacheConstants.onBoardingViewed,
                    true,
                  );
                  context.go(AppRoutesConstants.loginRoute);
                },
                child: Text(AppTextConstants.onboardingSkipButton),
              ),
              OnBoardingPicsSection(currentPage: _currentPage),
              OnBoardingBottomSheet(
                currentPage: _currentPage,
                onNextPressed: () {
                  setState(() {
                    _currentPage++;
                  });
                },
                onBackPressed: () {
                  setState(() {
                    _currentPage--;
                  });
                },
                onDoItPressed: () {
                  secureStorageService.writeBool(
                    CacheConstants.onBoardingViewed,
                    true,
                  );
                  context.go(AppRoutesConstants.loginRoute);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
