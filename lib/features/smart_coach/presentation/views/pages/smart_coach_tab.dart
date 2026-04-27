import 'dart:developer';
import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/blur_card.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/cubit/samrt_coach_intents.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_cubit.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_state.dart';
import 'package:fitness_app/features/smart_coach/presentation/views/widgets/type_writer_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SmartCoachTab extends StatefulWidget {
  final ScrollController scrollController;
  const SmartCoachTab({super.key, required this.scrollController});

  @override
  State<SmartCoachTab> createState() => _SmartCoachTabState();
}

class _SmartCoachTabState extends State<SmartCoachTab> {
  late TextTheme textTheme;
  late Size screenSize;
  late SmartCoachCubit smartCoachCubit;
  @override
  void initState() {
    smartCoachCubit = getIt<SmartCoachCubit>();
    smartCoachCubit.doIntent(GetFirstNameIntent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    textTheme = Theme.of(context).textTheme;
    screenSize = MediaQuery.sizeOf(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.smartCoachBackGround),
          fit: BoxFit.cover,
        ),
      ),
      child: BlocProvider(
        create: (context) => smartCoachCubit,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Column(
              children: [
                BlocBuilder<SmartCoachCubit, SmartCoachState>(
                  buildWhen: (previous, current) =>
                      previous.firstName?.data != current.firstName?.data,
                  builder: (context, state) {
                    log(state.toString());
                    return Text(
                      '${AppTextConstants.smartCoachGreeting} ${state.firstName?.data ?? ''},',
                      style: textTheme.bodyLarge,
                    );
                  },
                ),
                TypewriterText(
                  text: AppTextConstants.smartCoachGreetingDescription,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 25),
                Image.asset(
                  AppAssets.robotImage,
                  height: screenSize.height * 0.5,
                  width: double.infinity,
                ),
                BlurCard(
                  height: screenSize.height * 0.23,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppTextConstants.smartCoachWelcomeMessage,
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.pushNamed(AppRoutesConstants.chatPage);
                          },
                          child: Text(
                            AppTextConstants.smartCoachGetStarted,
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
