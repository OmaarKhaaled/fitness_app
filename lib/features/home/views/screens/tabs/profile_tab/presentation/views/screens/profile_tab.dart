import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  final ScrollController scrollController;
  const ProfileTab({super.key, required this.scrollController});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(AppTextConstants.profileIcon));
  }
}
