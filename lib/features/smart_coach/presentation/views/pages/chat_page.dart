import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/smart_coach/presentation/views/widgets/message_bubble.dart';
import 'package:fitness_app/features/smart_coach/presentation/views/widgets/smart_coach_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextTheme textTheme;

  @override
  void didChangeDependencies() {
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundImage: AppAssets.smartCoachBackGround,
      child: Column(
        children: [
          AppBar(
            backgroundColor: AppColors.transparent,
            centerTitle: true,
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                AppIcons.back,
                height: 24,
                width: 24,
                fit: BoxFit.scaleDown,
              ),
            ),
            title: Text(
              AppTextConstants.smartCoach,
              style: textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: SvgPicture.asset(
                    AppIcons.menu,
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        final msg = {
                          'role': 'coach',
                          'text': 'Hello, how are you?',
                        };
                        return MessageBubble(message: msg['text']!);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 24);
                      },
                    ),
                  ),
                  const SmartCoachTextField(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
