import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/chat_page_cubit/chat_page_cubit.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/chat_page_cubit/chat_page_intents.dart';
import 'package:fitness_app/features/smart_coach/presentation/views/widgets/message_bubble.dart';
import 'package:fitness_app/features/smart_coach/presentation/views/widgets/smart_coach_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextTheme textTheme;
  late ChatPageCubit chatPageCubit;

  @override
  void initState() {
    chatPageCubit = getIt<ChatPageCubit>();
    chatPageCubit.doIntent(GetProfilePicUrlIntent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => chatPageCubit,
      child: AppScaffold(
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
                        physics: const BouncingScrollPhysics(),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          final msg = {
                            'role': 'coach',
                            'text': 'Hello, how are you? I am fine',
                          };
                          return MessageBubble(
                            message: msg['text']!,
                            isUser: msg['role'] == 'user',
                          );
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
      ),
    );
  }
}
