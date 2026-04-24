import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/view/widgets/provide_email_view.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/view/widgets/reset_password_view.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/view/widgets/verify_code_view.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/view_model/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String _email = '';

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => getIt<ForgetPasswordCubit>(),
      child: AppScaffold(
        backgroundImage: AppAssets.forgetPasswordBackground,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              AppBar(
                backgroundColor: AppColors.transparent,
                leading: InkWell(
                  onTap: () {
                    if (_currentPage > 0) {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      context.pop();
                    }
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.primary,
                    size: 35,
                  ),
                ),
                title: Image.asset(AppAssets.fitness, height: 75, width: 90),
              ),
              SizedBox(height: size.height * .1),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ProvideEmailView(
                      onNext: (email) {
                        setState(() => _email = email);
                        _nextPage();
                      },
                    ),
                    VerifyCodeView(email: _email, onNext: () => _nextPage()),
                    const ResetPasswordView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
