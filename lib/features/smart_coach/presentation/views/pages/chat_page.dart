import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/constants/ai_model_constants.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/chat_page_cubit/chat_page_cubit.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/chat_page_cubit/chat_page_intents.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/chat_page_cubit/chat_page_states.dart';
import 'package:fitness_app/features/smart_coach/presentation/views/widgets/message_bubble.dart';
import 'package:fitness_app/features/smart_coach/presentation/views/widgets/smart_coach_text_field.dart';
import 'package:fitness_app/features/smart_coach/presentation/views/widgets/typing_indicator.dart';
import 'package:fitness_app/features/smart_coach/presentation/views/widgets/welcome_lottie.dart';
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
  final ScrollController _scrollController = ScrollController();

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
                      child: BlocBuilder<ChatPageCubit, ChatPageStates>(
                        buildWhen: (previous, current) =>
                            previous.messages != current.messages,
                        builder: (context, state) {
                          if (state.messages?.errorMessage != null) {
                            return Center(
                              child: Container(
                                color: AppColors.black,
                                child: Text(
                                  state.messages!.errorMessage!,
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: AppColors.redAccent,
                                  ),
                                ),
                              ),
                            );
                          }
                          final messages = state.messages?.data ?? [];
                          final isLoading = state.messages?.isLoading ?? false;
                          return messages.isEmpty
                              ? const WelcomeLottie()
                              : Column(
                                  children: [
                                    Expanded(
                                      child: ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        controller: _scrollController,
                                        itemCount: messages.length,
                                        itemBuilder: (context, index) {
                                          return MessageBubble(
                                            message:
                                                messages[index][AiModelConstants
                                                    .messageKey]!,
                                            isUser:
                                                messages[index][AiModelConstants
                                                    .roleKey] ==
                                                AiModelConstants.userRole,
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(height: 24);
                                        },
                                      ),
                                    ),
                                    if (isLoading)
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: TypingIndicator(),
                                        ),
                                      ),
                                    if (state.messages?.errorMessage != null)
                                      Text(
                                        state.messages!.errorMessage!,
                                        style: textTheme.bodyMedium?.copyWith(
                                          color: AppColors.redAccent,
                                        ),
                                      ),
                                  ],
                                );
                        },
                      ),
                    ),
                    SmartCoachTextField(
                      onSend: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        });
                      },
                    ),
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
