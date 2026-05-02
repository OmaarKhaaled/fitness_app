import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/chat_page_cubit/chat_page_cubit.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/chat_page_cubit/chat_page_intents.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/chat_page_cubit/chat_page_states.dart';
import 'package:fitness_app/features/smart_coach/presentation/views/widgets/previous_conversation_tab.dart';
import 'package:fitness_app/features/smart_coach/presentation/views/widgets/typing_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/core/theme/app_colors.dart';

class PreviousConversationsDrawer extends StatelessWidget {
  final ChatPageCubit cubit;

  const PreviousConversationsDrawer({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider.value(
      value: cubit,
      child: Align(
        alignment: Alignment.centerRight,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.65,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.darkGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                    child: Text(
                      AppTextConstants.previousConversations,
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(color: Colors.white12, height: 1),
                  BlocBuilder<ChatPageCubit, ChatPageStates>(
                    builder: (context, state) {
                      final previousConversations =
                          state.previousConversations?.data;
                      if (previousConversations == null ||
                          state.previousConversations?.isLoading == true) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Align(
                            alignment: Alignment.center,
                            child: TypingIndicator(),
                          ),
                        );
                      }
                      if (previousConversations.isEmpty) {
                        return Center(
                          child: Container(
                            height: 44,
                            alignment: Alignment.center,
                            child: Text(
                              AppTextConstants.noPreviousConversations,
                              style: textTheme.bodyMedium?.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        );
                      }
                      return Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                physics: const BouncingScrollPhysics(),
                                itemCount: previousConversations.length,
                                separatorBuilder: (_, __) => const Divider(
                                  color: Colors.white10,
                                  height: 1,
                                ),
                                itemBuilder: (context, index) {
                                  return PreviousConversationsTab(
                                    session: previousConversations[index],
                                  );
                                },
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  cubit.doIntent(DeleteAllSessionsIntent());
                                },
                                icon: const Icon(
                                  Icons.delete_forever,
                                  color: AppColors.white,
                                ),
                                label: Text(
                                  AppTextConstants.clearAll,
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
