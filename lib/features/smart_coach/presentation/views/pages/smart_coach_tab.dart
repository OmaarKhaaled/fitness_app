import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/blur_card.dart';
import 'package:flutter/material.dart';

class SmartCoachTab extends StatefulWidget {
  final ScrollController scrollController;
  const SmartCoachTab({super.key, required this.scrollController});

  @override
  State<SmartCoachTab> createState() => _SmartCoachTabState();
}

class _SmartCoachTabState extends State<SmartCoachTab> {
  late TextTheme textTheme;
  late Size screenSize;
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
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: Column(
            children: [
              Text(
                '${AppTextConstants.smartCoachGreeting} ,',
                style: textTheme.bodyLarge,
              ),
              Text(
                AppTextConstants.smartCoachGreetingDescription,
                style: textTheme.bodyLarge?.copyWith(
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
                        onPressed: () {},
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
    );
  }
}
