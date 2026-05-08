import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/config/network/language_manager.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/blur_card.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/ui_utils.dart';
import 'package:fitness_app/features/auth/profile/presentation/view/pages/common_web_view_page.dart';
import 'package:fitness_app/features/auth/profile/presentation/view_model/profile_cubit.dart';
import 'package:fitness_app/features/auth/profile/presentation/view_model/profile_intents.dart';
import 'package:fitness_app/features/auth/profile/presentation/view_model/profile_states.dart';
import 'package:fitness_app/features/auth/profile/presentation/view_model/profile_ui_intents.dart';
import 'package:fitness_app/features/home/views/screens/tabs/profile_tab/presentation/views/widgets/logout_dialog.dart';
import 'package:fitness_app/features/home/views/screens/tabs/profile_tab/presentation/views/widgets/profile_menu_item.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late final ProfileCubit _cubit;
  late final StreamSubscription _streamSubscription;
  @override
  void initState() {
    super.initState();
    _cubit = getIt<ProfileCubit>()..doIntent(GetUserProfileIntent());
    _streamSubscription = _cubit.uiIntents.listen((intent) {
      switch (intent) {
        case ShowErrorIntent(errorMessage: final errorMessage):
          UiUtils.showErrorMsg(context, errorMessage);
          break;
      }
    });
  }

  @override
  void dispose() {
    _cubit.close();
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish =
        EasyLocalization.of(context)!.currentLocale?.languageCode == 'en';
    final textTheme = Theme.of(context).textTheme;
    final languageManager = getIt<LanguageManager>();
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: BlocBuilder<ProfileCubit, ProfileStates>(
            builder: (context, state) {
              final user = state.data;
              final isLoading = state.isLoading;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppTextConstants.profile,
                        style: textTheme.headlineMedium?.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 32),

                      Skeletonizer(
                        enabled: isLoading && user == null,
                        effect: const ShimmerEffect(
                          baseColor: AppColors.shimmerBaseColor,
                          highlightColor: AppColors.shimmerHighlightColor,
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.white.withValues(alpha: 0.2),
                                  width: 2,
                                ),
                              ),
                              child: ClipOval(
                                child: user?.photo != null
                                    ? CachedNetworkImage(
                                        imageUrl: user!.photo!,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                              CupertinoIcons
                                                  .person_alt_circle_fill,
                                              size: 100,
                                              color: AppColors.grey,
                                            ),
                                      )
                                    : const Bone.circle(size: 100),
                              ),
                            ),
                            const SizedBox(height: 16),
                            user != null
                                ? Text(
                                    user.fullName,
                                    style: textTheme.titleLarge?.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : const Bone.text(words: 2),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      BlurCard(
                        child: Column(
                          children: [
                            ProfileMenuItem(
                              iconPath: AppIcons.editProfile,
                              title: AppTextConstants.editProfile,
                              onTap: () {
                                context.go(AppRoutesConstants.editProfileRoute);
                              },
                            ),
                            ProfileMenuItem(
                              iconPath: AppIcons.changePassword,
                              title: AppTextConstants.changePassword,
                              onTap: () {
                                context.push(
                                  AppRoutesConstants.changePasswordRoute,
                                );
                              },
                            ),
                            ProfileMenuItem(
                              iconPath: AppIcons.language,
                              titleWidget: RichText(
                                text: TextSpan(
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${AppTextConstants.selectLanguage} (',
                                    ),
                                    TextSpan(
                                      text: isEnglish
                                          ? AppTextConstants.english
                                          : AppTextConstants.arabic,
                                      style: textTheme.bodyLarge?.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const TextSpan(text: ')'),
                                  ],
                                ),
                              ),
                              trailing: Switch(
                                value: isEnglish,
                                padding: EdgeInsets.zero,
                                onChanged: (val) {
                                  final newLocale = val ? const Locale('en') : const Locale('ar');
                                  final languageCode = val ? 'en' : 'ar';
                                  languageManager.setLanguage(languageCode);
                                  context.setLocale(newLocale);
                                },
                                activeTrackColor: AppColors.primary,
                                activeThumbColor: AppColors.white,
                                inactiveThumbColor: AppColors.primary,
                                inactiveTrackColor: AppColors.white,
                              ),
                              onTap: () {},
                            ),
                            ProfileMenuItem(
                              iconPath: AppIcons.security,
                              title: AppTextConstants.security,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CommonWebViewPage(
                                      title: AppTextConstants.security,
                                      url: AppRoutesConstants.securityUrl,
                                    ),
                                  ),
                                );
                              },
                            ),
                            ProfileMenuItem(
                              iconPath: AppIcons.privacyPolicy,
                              title: AppTextConstants.privacyPolicy,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CommonWebViewPage(
                                      title: AppTextConstants.privacyPolicy,
                                      url: AppRoutesConstants.privacyPolicyUrl,
                                    ),
                                  ),
                                );
                              },
                            ),
                            ProfileMenuItem(
                              iconPath: AppIcons.help,
                              title: AppTextConstants.help,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CommonWebViewPage(
                                      title: AppTextConstants.help,
                                      url: AppRoutesConstants.helpUrl,
                                    ),
                                  ),
                                );
                              },
                            ),
                            ProfileMenuItem(
                              iconPath: AppIcons.logout,
                              title: AppTextConstants.logout,
                              hasBottomBorder: false,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => BlocProvider.value(
                                    value: context.read<ProfileCubit>(),
                                    child: const LogoutDialog(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
