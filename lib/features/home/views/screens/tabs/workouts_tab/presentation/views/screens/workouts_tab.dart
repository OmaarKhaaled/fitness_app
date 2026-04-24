import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:flutter/material.dart';

class WorkoutsTab extends StatefulWidget {
  final ScrollController scrollController;
  const WorkoutsTab({super.key, required this.scrollController});

  @override
  State<WorkoutsTab> createState() => _WorkoutsTabState();
}

class _WorkoutsTabState extends State<WorkoutsTab> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(AppTextConstants.workoutsIcon));
  }
}
