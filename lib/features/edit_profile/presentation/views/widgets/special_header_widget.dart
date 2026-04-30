import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SpecialHeaderWidget extends StatelessWidget {
  final String header;
  final VoidCallback onTap;
  const SpecialHeaderWidget({super.key,required this.header,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$header (',style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600
        ),),
        InkWell(
          onTap: onTap,
          child: Text(AppTextConstants.tapToEdit,style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600
          ),),
        ),
        Text(')',style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600
        ),)
      ],
    );
  }
}