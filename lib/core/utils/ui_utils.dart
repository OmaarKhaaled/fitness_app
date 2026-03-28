import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fitness_app/core/theme/app_colors.dart';

class UiUtils {
  static void showLoading(
    BuildContext context, {
    String status = 'Loading...',
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (_) => PopScope(
        canPop: false,
        child: Material(
          color: Colors.transparent,
          child: Stack(
            fit: StackFit.expand,
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(color: AppColors.black.withValues(alpha: .6)),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _PulsingRingLoader(),
                    const SizedBox(height: 32),
                    _LoadingText(status: status),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void hideLoading(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  static void showErrorMsg(BuildContext context, String error) {
    _showSnackBar(
      context,
      message: error,
      icon: Icons.error_outline_rounded,
      color: Colors.redAccent.shade700,
    );
  }

  static void showSuccessMsg(BuildContext context, String msg) {
    _showSnackBar(
      context,
      message: msg,
      icon: Icons.check_circle_outline_rounded,
      color: Colors.green.shade600,
    );
  }

  static void _showSnackBar(
    BuildContext context, {
    required String message,
    required IconData icon,
    required Color color,
  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(seconds: 2),
      content: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: color.withValues(alpha: .85),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.white.withValues(alpha: .2)),
            ),
            child: Row(
              children: [
                Icon(icon, color: AppColors.white, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static Future<bool> showConfirmDialog(
    BuildContext context,
    String s, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (_) => Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(color: AppColors.black.withValues(alpha: .4)),
          ),
          AlertDialog(
            backgroundColor: AppColors.white.withValues(alpha: .1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(color: AppColors.white.withValues(alpha: .15)),
            ),
            title: Text(
              title,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              message,
              style: TextStyle(color: AppColors.white.withValues(alpha: .7)),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  cancelText,
                  style: TextStyle(
                    color: AppColors.white.withValues(alpha: .6),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  confirmText,
                  style: const TextStyle(color: AppColors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    return result ?? false;
  }
}

class _PulsingRingLoader extends StatefulWidget {
  @override
  State<_PulsingRingLoader> createState() => _PulsingRingLoaderState();
}

class _PulsingRingLoaderState extends State<_PulsingRingLoader>
    with TickerProviderStateMixin {
  late AnimationController _rotateController;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _pulseAnim = Tween(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _rotateController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_rotateController, _pulseController]),
      builder: (_, __) {
        return Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(
                  alpha: _pulseAnim.value * 0.5,
                ),
                blurRadius: 40,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: _rotateController.value * 2 * 3.14159,
                child: CustomPaint(
                  size: const Size(140, 140),
                  painter: _ArcPainter(),
                ),
              ),

              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: .15),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: .3),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.fitness_center_rounded,
                  color: AppColors.primary,
                  size: 36,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(4, 4, size.width - 8, size.height - 8);

    canvas.drawArc(
      rect,
      0,
      2 * 3.14159,
      false,
      Paint()
        ..color = AppColors.primary.withValues(alpha: .15)
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke,
    );

    canvas.drawArc(
      rect,
      -1.5,
      2.5,
      false,
      Paint()
        ..shader = SweepGradient(
          colors: [AppColors.primary.withValues(alpha: 0), AppColors.primary],
        ).createShader(rect)
        ..strokeWidth = 3.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_) => true;
}

class _LoadingText extends StatefulWidget {
  final String status;
  const _LoadingText({required this.status});

  @override
  State<_LoadingText> createState() => _LoadingTextState();
}

class _LoadingTextState extends State<_LoadingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _fadeAnim = Tween(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: Text(
        widget.status,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.5,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
