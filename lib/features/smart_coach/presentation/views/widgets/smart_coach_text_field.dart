import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/chat_page_cubit/chat_page_cubit.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/chat_page_cubit/chat_page_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SmartCoachTextField extends StatefulWidget {
  const SmartCoachTextField({super.key, required this.onSend});
  final VoidCallback onSend;

  @override
  State<SmartCoachTextField> createState() => _SmartCoachTextFieldState();
}

class _SmartCoachTextFieldState extends State<SmartCoachTextField> {
  final TextEditingController controller = TextEditingController();
  late TextTheme textTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 30,
          child: Material(
            color: AppColors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              child: const Icon(Icons.add, color: AppColors.white),
              onTap: () {
                context.pushReplacement(AppRoutesConstants.chatPage);
              },
            ),
          ),
        ),
        Expanded(
          child: TextField(
            controller: controller,
            cursorColor: AppColors.white,
            decoration: InputDecoration(
              hintText: AppTextConstants.askSmartCoach,
              hintStyle: textTheme.bodyLarge?.copyWith(
                color: AppColors.white.withValues(alpha: 0.5),
              ),
            ),
            textInputAction: TextInputAction.newline,
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            onSubmitted: (value) {},
          ),
        ),
        const SizedBox(width: 4),
        SizedBox(
          height: 40,
          child: Material(
            color: AppColors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              child: const Icon(Icons.send, color: AppColors.white),
              onTap: () {
                if (controller.text.trim().isEmpty) {
                  return;
                }
                widget.onSend();
                context.read<ChatPageCubit>().doIntent(
                  SendMessageIntent(controller.text.trim()),
                );
                controller.clear();
              },
            ),
          ),
        ),
      ],
    );
  }
}
