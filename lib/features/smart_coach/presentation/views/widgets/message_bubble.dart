import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/chat_page_cubit/chat_page_cubit.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/chat_page_cubit/chat_page_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const MessageBubble({super.key, required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        if (!isUser) ...[
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(AppAssets.modelImage),
          ),
          const SizedBox(width: 10),
        ],

        Container(
          constraints: const BoxConstraints(maxWidth: 210),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isUser
                  ? [
                      AppColors.smartCoachBubbleGradientColor,
                      AppColors.smartCoachBubbleGradientColor2,
                    ]
                  : [AppColors.lightBlack, AppColors.darkGrey],
              begin: Alignment.bottomLeft,
              stops: const [0, .3],
              end: Alignment.topRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isUser ? 28 : 0),
              topRight: Radius.circular(isUser ? 0 : 28),
              bottomLeft: const Radius.circular(28),
              bottomRight: const Radius.circular(28),
            ),
          ),
          child: Text(
            message,
            style: textTheme.titleLarge?.copyWith(fontSize: 18, height: 1.35),
            overflow: TextOverflow.clip,
          ),
        ),

        if (isUser) ...[
          const SizedBox(width: 10),
          BlocBuilder<ChatPageCubit, ChatPageStates>(
            buildWhen: (previous, current) =>
                previous.profilePicUrl != current.profilePicUrl,
            builder: (context, state) {
              return CircleAvatar(
                radius: 20,
                backgroundImage: CachedNetworkImageProvider(
                  state.profilePicUrl?.data?.isNotEmpty == true
                      ? state.profilePicUrl!.data!
                      : AppAssets.defaultProfileImage,
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}
