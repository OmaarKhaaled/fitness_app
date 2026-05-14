import 'dart:io';

import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/constants/cache_constants.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/ui_utils.dart';
import 'package:fitness_app/core/validators/app_validators.dart';
import 'package:fitness_app/features/edit_profile/domain/models/user_model.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_events.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_states.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_view_model.dart';
import 'package:fitness_app/features/edit_profile/presentation/views/widgets/special_header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late EditProfileViewModel viewModel;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController weightController;
  late TextEditingController goalController;
  late TextEditingController activityLevelController;

  late FocusNode _firstNameFocusNode;
  late FocusNode _lastNameFocusNode;
  late FocusNode _emailFocusNode;

  String? _originalFirstName;
  String? _originalLastName;
  String? _originalEmail;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<EditProfileViewModel>();
    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _firstNameFocusNode.addListener(_onFirstNameFocusLost);
    _lastNameFocusNode.addListener(_onLastNameFocusLost);
    _emailFocusNode.addListener(_onEmailFocusLost);
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    weightController = TextEditingController();
    goalController = TextEditingController();
    activityLevelController = TextEditingController();
    viewModel.doIntent(GetProfileEvent());
  }

  @override
  void dispose() {
    _firstNameFocusNode.removeListener(_onFirstNameFocusLost);
    _lastNameFocusNode.removeListener(_onLastNameFocusLost);
    _emailFocusNode.removeListener(_onEmailFocusLost);
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    weightController.dispose();
    goalController.dispose();
    activityLevelController.dispose();
    super.dispose();
  }

  void _updateControllersFromUser(UserModel user) {
    final newFirstName = user.firstName ?? '';
    if (firstNameController.text != newFirstName) {
      firstNameController.text = newFirstName;
      _originalFirstName = user.firstName;
    } else
      _originalFirstName ??= user.firstName;
    final newLastName = user.lastName ?? '';
    if (lastNameController.text != newLastName) {
      lastNameController.text = newLastName;
      _originalLastName = user.lastName;
    } else
      _originalLastName ??= user.lastName;
    final newEmail = user.email ?? '';
    if (emailController.text != newEmail) {
      emailController.text = newEmail;
      _originalEmail = user.email;
    } else
      _originalEmail ??= user.email;
    weightController.text =
        '${user.weight} ${AppTextConstants.profileSetupWeightUnit.toUpperCase()}';
    goalController.text = user.goal ?? '';
    activityLevelController.text = user.activityLevel ?? '';
  }
  void _onFirstNameFocusLost() {
    if (!_firstNameFocusNode.hasFocus) {
      final currentValue = firstNameController.text.trim();
      if(currentValue==_originalFirstName) return;
      final validationError = AppValidators.validateRequired(currentValue);
      if(validationError!=null){
        UiUtils.showErrorMsg(context, validationError);
        firstNameController.text=_originalFirstName ?? '';
        return;
      }
      if (currentValue.isNotEmpty) {
        viewModel.doIntent(UpdateFirstNameEvent(currentValue));
        _originalFirstName = currentValue;
      }
    }
  }
  void _onLastNameFocusLost() {
    if (!_lastNameFocusNode.hasFocus) {
      final currentValue = lastNameController.text.trim();
      if(currentValue==_originalLastName) return;
      final validationError = AppValidators.validateRequired(currentValue);
      if(validationError!=null){
        UiUtils.showErrorMsg(context, validationError);
        lastNameController.text=_originalLastName ?? '';
        return;
      }
      if (currentValue.isNotEmpty) {
        viewModel.doIntent(UpdateLastNameEvent(currentValue));
        _originalLastName = currentValue;
      }
    }
  }
  void _onEmailFocusLost() {
  if (!_emailFocusNode.hasFocus) {
    final currentValue = emailController.text.trim();
    if (currentValue == _originalEmail) return;
    final validationError = AppValidators.validateEmail(currentValue);
    if (validationError != null) {
      UiUtils.showErrorMsg(context, validationError);
      emailController.text = _originalEmail ?? '';
      return;
    }
    if (currentValue.isNotEmpty) {
      viewModel.doIntent(UpdateEmailEvent(currentValue));
      _originalEmail = currentValue;
    }
  }
}
  Future<void> _pickAndUpdatePhoto(UserModel currentUser) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 500,
      imageQuality: 80,
    );

    if (pickedFile == null) return;
    viewModel.doIntent(UploadPhotoEvent(File(pickedFile.path)));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return BlocProvider<EditProfileViewModel>.value(
      value: viewModel,
      child: BlocConsumer<EditProfileViewModel, EditProfileStates>(
        listener: (context, state) {
          final profileState = state.profileState;

          if (profileState?.data?.userModel != null) {
            _updateControllersFromUser(profileState!.data!.userModel!);
            final photo = profileState.data!.userModel!.photo;
            if (photo != null && photo.isNotEmpty) {
              viewModel.doIntent(
                SavePhotoEvent(CacheConstants.imageUrl, photo),
              );
            }
          }

          if (state.isEditSuccess) {
            UiUtils.hideLoading(context);
            UiUtils.showSuccessMsg(
              context,
              state.editProfileState!.data!.message!,
            );
            viewModel.doIntent(ResetEditSuccessEvent());
          }

          if (state.editProfileState?.isLoading == true) {
            UiUtils.showLoading(context);
          } else if (state.editProfileState?.isLoading == false &&
              state.editProfileState?.errorMessage != null) {
            UiUtils.hideLoading(context);
            UiUtils.showErrorMsg(
              context,
              state.editProfileState!.errorMessage!,
            );
          }
        },
        builder: (context, state) {
          final profileState = state.profileState;
          if (profileState?.isLoading == true) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          if (profileState?.errorMessage != null) {
            return Center(
              child: Text(
                profileState!.errorMessage!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }
          if (profileState?.data?.userModel != null) {
            final user = profileState!.data!.userModel!;
            _updateControllersFromUser(user);

            return AppScaffold(
              blurSigma: 8,
              backgroundImage: AppAssets.profileBackground,
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 0.06 * height,
                        left: 0.04 * width,
                        right: 0.04 * width,
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              context.pop();
                            },
                            child: Container(
                              width: 0.06 * width,
                              height: 0.06 * width,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  AppIcons.backArrow,
                                  color: AppColors.white,
                                  width: 0.03 * width,
                                  height: 0.03 * width,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                AppTextConstants.editProfileHeader,
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          SizedBox(width: 0.06 * width),
                        ],
                      ),
                    ),
                    SizedBox(height: 0.05 * height),

                    // Profile Picture
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        CircleAvatar(
                          radius: 0.15 * width,
                          backgroundImage: user.photo != null
                              ? NetworkImage(user.photo!)
                              : const AssetImage(AppAssets.superFitness),
                        ),
                        Positioned(
                          right: 2,
                          child: InkWell(
                            onTap: () {
                              _pickAndUpdatePhoto(user);
                            },
                            child: Container(
                              width: 0.05 * width,
                              height: 0.05 * width,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.primary),
                              ),
                              child: const ImageIcon(
                                AssetImage(AppIcons.editingPencil),
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.01 * height),
                    Text(
                      '${user.firstName} ${user.lastName}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 0.1 * height),
                    Form(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.09 * width),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: firstNameController,
                              focusNode: _firstNameFocusNode,
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
                              focusNode: _lastNameFocusNode,
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
                              focusNode: _emailFocusNode,
                              decoration: InputDecoration(
                                hintText:
                                    AppTextConstants.registerEmailPlaceholder,
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 0.05 * height),
                            SpecialHeaderWidget(
                              key: ValueKey(AppTextConstants.yourWeight),
                              header: AppTextConstants.yourWeight,
                              onTap: () async {
                                await context.push(
                                  AppRoutesConstants.weightEditing,
                                );
                              },
                            ),
                            SizedBox(height: 0.02 * height),
                            TextFormField(
                              controller: weightController,
                              readOnly: true,
                            ),
                            SizedBox(height: 0.02 * height),
                            SpecialHeaderWidget(
                              key: ValueKey(AppTextConstants.yourGoal),
                              header: AppTextConstants.yourGoal,
                              onTap: () async {
                                await context.push(
                                  AppRoutesConstants.goalEditing,
                                );
                              },
                            ),
                            SizedBox(height: 0.02 * height),
                            TextFormField(
                              controller: goalController,
                              readOnly: true,
                            ),
                            SizedBox(height: 0.02 * height),
                            SpecialHeaderWidget(
                              key: ValueKey(AppTextConstants.yourActivityLevel),
                              header: AppTextConstants.yourActivityLevel,
                              onTap: () async {
                                await context.push(
                                  AppRoutesConstants.activityLevelEditing,
                                );
                              },
                            ),
                            SizedBox(height: 0.02 * height),
                            TextFormField(
                              controller: activityLevelController,
                              readOnly: true,
                            ),
                            SizedBox(height: 0.04 * height),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        },
      ),
    );
  }
}
