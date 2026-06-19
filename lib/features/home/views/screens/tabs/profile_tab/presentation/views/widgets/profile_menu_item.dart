import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenuItem extends StatelessWidget {
  final String iconPath;
  final String? title;
  final Widget? titleWidget;
  final Widget? trailing;
  final VoidCallback onTap;
  final bool hasBottomBorder;

  const ProfileMenuItem({
    super.key,
    required this.iconPath,
    this.title,
    this.titleWidget,
    this.trailing,
    required this.onTap,
    this.hasBottomBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: hasBottomBorder
              ? Border(
                  bottom: BorderSide(
                    color: AppColors.white.withValues(alpha: 0.1),
                    width: 1.5,
                  ),
                )
              : null,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child:
                  titleWidget ??
                  Text(
                    title ?? '',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
            if (trailing != null)
              trailing!
            else
              const Icon(
                Icons.chevron_right,
                color: AppColors.primary,
                size: 28,
              ),
          ],
        ),
      ),
    );
  }
}
