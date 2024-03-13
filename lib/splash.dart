import 'package:aqua_assignment/core/constants/app_assets.dart';
import 'package:aqua_assignment/features/home/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPageAfterDelay();
  }

  _navigateToNextPageAfterDelay() async {
    await Future.delayed(const Duration(seconds: 5));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          SafeArea(child: Center(child: Lottie.asset(AppAssets.splashLottie))),
    );
  }
}
