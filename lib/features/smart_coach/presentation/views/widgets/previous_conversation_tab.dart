import 'package:fitness_app/core/extensions/extentions.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/smart_coach/data/models/session_model.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/chat_page_cubit/chat_page_cubit.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/chat_page_cubit/chat_page_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviousConversationsTab extends StatelessWidget {
  const PreviousConversationsTab({super.key, required this.session});
  final SessionModel session;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.read<ChatPageCubit>().doIntent(LoadSessionIntent(session.id));
          Navigator.pop(context);
        },
        splashColor: AppColors.primary,
        hoverColor: AppColors.primary,
        overlayColor: const WidgetStatePropertyAll(AppColors.primary),
        highlightColor: AppColors.primary,
        focusColor: AppColors.primary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              const Icon(Icons.arrow_back_sharp, color: AppColors.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  session.title.capitalize(),
                  style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
