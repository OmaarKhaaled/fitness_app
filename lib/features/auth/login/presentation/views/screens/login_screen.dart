import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      backgroundImage: AppAssets.authBackground,
      child: SingleChildScrollView(),
    );
  }
}
