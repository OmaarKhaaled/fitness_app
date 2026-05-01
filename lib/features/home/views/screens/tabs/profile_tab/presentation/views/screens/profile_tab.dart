import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileTab extends StatefulWidget {
  final ScrollController scrollController;
  const ProfileTab({super.key, required this.scrollController});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          context.go(AppRoutesConstants.editProfileRoute);
        },
        child: Text(AppTextConstants.profileIcon),
      ),
    );
  }
}
