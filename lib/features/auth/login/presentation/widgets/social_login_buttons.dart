import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(Icons.facebook, Colors.white.withValues(alpha: .1)),
        const SizedBox(width: 20),
        _buildSocialIcon(
          Icons.g_mobiledata,
          Colors.white.withValues(alpha: .15),
          size: 36,
        ),
        const SizedBox(width: 20),
        _buildSocialIcon(Icons.apple, Colors.white.withValues(alpha: .1)),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color, {double size = 24}) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, color: Colors.white, size: size),
    );
  }
}
