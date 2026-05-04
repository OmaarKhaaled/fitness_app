import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebViewPage extends StatefulWidget {
  final String title;
  final String url;

  const CommonWebViewPage({super.key, required this.title, required this.url});

  @override
  State<CommonWebViewPage> createState() => _CommonWebViewPageState();
}

class _CommonWebViewPageState extends State<CommonWebViewPage> {
  late final WebViewController _controller;
  bool isLoading = true;
  double loadingProgress = 0;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.darkGrey)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (mounted) {
              setState(() {
                loadingProgress = progress / 100;
                if (progress > 80) {
                  isLoading = false;
                }
              });
            }
          },
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                isLoading = false;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            if (mounted) {
              setState(() {
                isLoading = false;
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      appBar: AppBar(
        backgroundColor: AppColors.darkGrey,
        elevation: 0,
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: WebViewWidget(controller: _controller)),
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: AppColors.darkGrey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.shimmerBaseColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            _buildShimmerBlock(
                              height: 48,
                              width: 48,
                              shape: BoxShape.circle,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildShimmerBlock(height: 20, width: 140),
                                  const SizedBox(height: 8),
                                  _buildShimmerBlock(
                                    height: 14,
                                    width: double.infinity,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        child: Row(
                          children: List.generate(
                            5,
                            (index) => Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: _buildShimmerBlock(
                                height: 36,
                                width: index == 0 ? 110 : 80,
                                borderRadius: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      ...List.generate(
                        3,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.shimmerBaseColor.withValues(
                                alpha: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    _buildShimmerBlock(
                                      height: 24,
                                      width: 24,
                                      shape: BoxShape.circle,
                                    ),
                                    const SizedBox(width: 12),
                                    _buildShimmerBlock(height: 18, width: 120),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                _buildShimmerBlock(
                                  height: 14,
                                  width: double.infinity,
                                ),
                                const SizedBox(height: 8),
                                _buildShimmerBlock(
                                  height: 14,
                                  width: double.infinity,
                                ),
                                const SizedBox(height: 8),
                                _buildShimmerBlock(height: 14, width: 200),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildShimmerBlock({
    double? height,
    double? width,
    BoxShape shape = BoxShape.rectangle,
    double borderRadius = 8,
  }) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerHighlightColor,
      highlightColor: AppColors.shimmerBaseColor,
      period: const Duration(milliseconds: 1500),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: shape,
          borderRadius: shape == BoxShape.circle
              ? null
              : BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
