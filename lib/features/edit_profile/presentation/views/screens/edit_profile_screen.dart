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
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_request_model.dart';
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
  final _formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController weightController;
  late TextEditingController goalController;
  late TextEditingController activityLevelController;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<EditProfileViewModel>();
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
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    weightController.dispose();
    goalController.dispose();
    activityLevelController.dispose();
    super.dispose();
  }

  void _updateControllersFromUser(UserModel user) {
    if (firstNameController.text.isEmpty) {
      firstNameController.text = user.firstName ?? '';
      lastNameController.text = user.lastName ?? '';
      emailController.text = user.email ?? '';
      weightController.text =
          '${user.weight} ${AppTextConstants.profileSetupWeightUnit.toUpperCase()}';
      goalController.text = user.goal ?? '';
      activityLevelController.text = user.activityLevel ?? '';
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
          final editProfileState = state.editProfileState;
          if (profileState?.data?.userModel != null) {
            _updateControllersFromUser(profileState!.data!.userModel!);
            final photo = profileState.data!.userModel!.photo;
            if (photo != null && photo.isNotEmpty) {
              viewModel.doIntent(SavePhotoEvent(CacheConstants.imageUrl, photo));
            }
          }
          if (editProfileState?.isLoading == true) {
            UiUtils.showLoading(context);
          } else if (editProfileState?.isLoading == false &&
              editProfileState?.data != null &&
              state.isEditSuccess) {
            UiUtils.hideLoading(context);
            UiUtils.showSuccessMsg(context, profileState!.data!.message!);
            viewModel.doIntent(SaveFirstNameEvent(CacheConstants.firstName,firstNameController.text,));
            viewModel.doIntent(ResetEditSuccessEvent());
            context.go(AppRoutesConstants.homeRoute);
            return;
          } else if (editProfileState?.isLoading == false &&
              editProfileState?.errorMessage != null) {
            UiUtils.hideLoading(context);
            UiUtils.showErrorMsg(context, profileState!.errorMessage!);
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
                              context.go(AppRoutesConstants.homeRoute);
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
                              child: Text(AppTextConstants.editProfileHeader,style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600
                              ),),
                            ),
                          ),
                          SizedBox(width: 0.06 * width),
                        ],
                      ),
                    ),
                    SizedBox(height: 0.05 * height),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        CircleAvatar(
                          radius: 0.27 * width,
                          backgroundImage: NetworkImage(user.photo ?? ''),
                        ),
                        InkWell(
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
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.09 * width),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: firstNameController,
                              validator: (value) =>
                                  AppValidators.validateRequired(value),
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
                              validator: (value) =>
                                  AppValidators.validateRequired(value),
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
                              validator: (value) =>
                                  AppValidators.validateRequired(value),
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
                              header: AppTextConstants.yourWeight,
                              onTap: () {
                                context.go(AppRoutesConstants.weightEditing);
                              },
                            ),
                            SizedBox(height: 0.02 * height),
                            TextFormField(
                              controller: weightController,
                              readOnly: true,
                            ),
                            SizedBox(height: 0.02 * height),
                            SpecialHeaderWidget(
                              header: AppTextConstants.yourGoal,
                              onTap: () {
                                context.go(AppRoutesConstants.goalEditing);
                              },
                            ),
                            SizedBox(height: 0.02 * height),
                            TextFormField(
                              controller: goalController,
                              readOnly: true,
                            ),
                            SizedBox(height: 0.02 * height),
                            SpecialHeaderWidget(
                              header: AppTextConstants.yourActivityLevel,
                              onTap: () {
                                context.go(
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
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ==
                                      true) {
                                    final currentUser =
                                        profileState.data!.userModel!;
                                    viewModel.doIntent(
                                      EditProfileEvent(
                                        EditProfileRequestModel(
                                          firstName: firstNameController.text,
                                          lastName: lastNameController.text,
                                          email: emailController.text,
                                          weight: currentUser.weight,
                                          goal: currentUser.goal,
                                          activityLevel:
                                              currentUser.activityLevel,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Text(AppTextConstants.editButton),
                              ),
                            ),
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
