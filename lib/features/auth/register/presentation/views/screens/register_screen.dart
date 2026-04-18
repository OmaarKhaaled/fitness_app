import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/core/shared/blur_card.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/validators/app_validators.dart';
import 'package:fitness_app/features/auth/register/domain/models/registeration_data_model.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_events.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_states.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterViewModel viewModel;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController rePasswordController;
  @override
  void initState() {
    super.initState();
    viewModel = getIt<RegisterViewModel>();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cachedData = viewModel.state.registerationData;
      if (cachedData.firstName.isNotEmpty) {
        firstNameController.text = cachedData.firstName;
        lastNameController.text = cachedData.lastName;
        emailController.text = cachedData.email;
        passwordController.text = cachedData.password;
        rePasswordController.text = cachedData.rePassword;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return BlocProvider<RegisterViewModel>.value(
      value: viewModel,
      child: AppScaffold(
        backgroundImage: AppAssets.authBackground,
        alignment: Alignment.topCenter,
        child: BlocBuilder<RegisterViewModel, RegisterStates>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 0.06 * height),
                  Image.asset(AppAssets.superFitness),
                  SizedBox(height: 0.05 * height),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 0.04 * width),
                        child: Text(
                          AppTextConstants.registerGreeting,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0.04 * width),
                        child: Text(
                          AppTextConstants.registerCreateAccount,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                      SizedBox(height: 0.02 * height),
                      BlurCard(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(height: 0.03 * height),
                              Text(
                                AppTextConstants.registerHeading,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              SizedBox(height: 0.02 * height),
                              TextFormField(
                                controller: firstNameController,
                                validator: (value) {
                                  return AppValidators.validateRequired(value);
                                },
                                decoration: InputDecoration(
                                  hintText: AppTextConstants
                                      .registerFirstNamePlaceholder,
                                  prefixIcon: const Icon(
                                    CupertinoIcons.person,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 0.02 * height),
                              TextFormField(
                                controller: lastNameController,
                                validator: (value) {
                                  return AppValidators.validateRequired(value);
                                },
                                decoration: InputDecoration(
                                  hintText: AppTextConstants
                                      .registerLastNamePlaceholder,
                                  prefixIcon: const Icon(
                                    CupertinoIcons.person,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 0.02 * height),
                              TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  return AppValidators.validateEmail(value);
                                },
                                decoration: InputDecoration(
                                  hintText:
                                      AppTextConstants.registerEmailPlaceholder,
                                  prefixIcon: const Icon(
                                    Icons.email_outlined,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 0.02 * height),
                              TextFormField(
                                controller: passwordController,
                                obscureText: state.isPasswordHidden,
                                validator: (value) {
                                  return AppValidators.validatePassword(value);
                                },
                                decoration: InputDecoration(
                                  hintText: AppTextConstants
                                      .registerPasswordPlaceholder,
                                  prefixIcon: const Icon(
                                    CupertinoIcons.lock,
                                    color: AppColors.white,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      viewModel.doIntent(
                                        TogglePasswordHiddenEvent(),
                                      );
                                    },
                                    icon: state.isPasswordHidden
                                        ? const Icon(
                                            Icons.visibility_off_outlined,
                                            color: AppColors.white,
                                          )
                                        : const Icon(
                                            Icons.visibility_outlined,
                                            color: AppColors.white,
                                          ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 0.02 * height),
                              TextFormField(
                                controller: rePasswordController,
                                obscureText: state.isRePasswordHidden,
                                validator: (value) {
                                  return AppValidators.validateConfirmPassword(
                                    value,
                                    passwordController.text,
                                  );
                                },
                                decoration: InputDecoration(
                                  hintText: AppTextConstants
                                      .registerRePasswordPlaceholder,
                                  prefixIcon: const Icon(
                                    CupertinoIcons.lock,
                                    color: AppColors.white,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      viewModel.doIntent(
                                        ToggleRePasswordHiddenEvent(),
                                      );
                                    },
                                    icon: state.isRePasswordHidden
                                        ? const Icon(
                                            Icons.visibility_off_outlined,
                                            color: AppColors.white,
                                          )
                                        : const Icon(
                                            Icons.visibility_outlined,
                                            color: AppColors.white,
                                          ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 0.02 * height),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 0.04 * width,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ==
                                          true) {
                                        final registerationData =
                                            RegisterationDataModel(
                                              firstName:
                                                  firstNameController.text,
                                              lastName: lastNameController.text,
                                              email: emailController.text,
                                              password: passwordController.text,
                                              rePassword:
                                                  rePasswordController.text,
                                            );
                                        viewModel.doIntent(
                                          CacheRegistrationDataEvent(
                                            registerationData,
                                          ),
                                        );
                                        context.go(
                                          AppRoutesConstants
                                              .additionalRegisterInfoRoute,
                                        );
                                      }
                                    },
                                    child: Text(
                                      AppTextConstants.registerButton,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 0.01 * height),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppTextConstants.registerAlreadyAccount,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  SizedBox(width: 0.01 * width),
                                  InkWell(
                                    onTap: () {
                                      context.go(AppRoutesConstants.loginRoute);
                                    },
                                    child: Text(
                                      AppTextConstants.registerLoginLink,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.primary,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: AppColors.primary,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
