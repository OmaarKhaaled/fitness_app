import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/features/meals/data/models/meals_details/meal.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MealDetailsHeader extends StatefulWidget {
  const MealDetailsHeader({super.key, required this.meal});

  final Meal meal;

  @override
  State<MealDetailsHeader> createState() => _MealDetailsHeaderState();
}

class _MealDetailsHeaderState extends State<MealDetailsHeader> {
  YoutubePlayerController? _controller;
  String? videoId;

  @override
  void initState() {
    super.initState();

    videoId = _extractYoutubeId(widget.meal.strYoutube);

    if (videoId != null && videoId!.isNotEmpty) {
      debugPrint('Youtube Video ID: $videoId');
      _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: true,
          enableCaption: false,
          isLive: true,
        ),
      );
    } else {
      debugPrint('No valid Youtube Video ID found for this meal.');
    }
  }

  String? _extractYoutubeId(String? url) {
    if (url == null || url.isEmpty) return null;

    if (url.contains('/shorts/')) {
      return url.split('/shorts/').last.split('?').first;
    }

    return YoutubePlayer.convertUrlToId(url);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final hasValidVideo = videoId != null && videoId!.isNotEmpty;

    return SliverAppBar(
      expandedHeight: mediaQuery.height * 0.4,
      backgroundColor: AppColors.black,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: AppColors.white),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (hasValidVideo && _controller != null)
              YoutubePlayer(
                controller: _controller!,
                showVideoProgressIndicator: true,
                onReady: () => debugPrint('Youtube Player is Ready'),
              )
            else
              CachedNetworkImage(
                imageUrl: widget.meal.strMealThumb ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: AppColors.grey[900]),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),

            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.transparent,
                    AppColors.grey[900]!.withValues(alpha: 0.8),
                  ],
                ),
              ),
            ),

            InstructionsWidget(widget: widget),
          ],
        ),
      ),
    );
  }
}

class InstructionsWidget extends StatelessWidget {
  const InstructionsWidget({super.key, required this.widget});

  final MealDetailsHeader widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 20,
      right: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.meal.strMeal ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.meal.strInstructions?.split('\n').first ??
                AppTextConstants.deliciousMealPreparedWithFreshIngredients,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
