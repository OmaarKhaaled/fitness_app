import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  final ScrollController scrollController;
  const HomeTab({super.key, required this.scrollController});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Center(child: Text(AppTextConstants.exploreIcon));
      },
      itemCount: 300,
    );
  }
}
