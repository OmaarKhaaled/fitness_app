import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:flutter/material.dart';

class SmartCoachTab extends StatefulWidget {
  final ScrollController scrollController;
  const SmartCoachTab({super.key, required this.scrollController});

  @override
  State<SmartCoachTab> createState() => _SmartCoachTabState();
}

class _SmartCoachTabState extends State<SmartCoachTab> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(AppTextConstants.smartCoachIcon));
  }
}
