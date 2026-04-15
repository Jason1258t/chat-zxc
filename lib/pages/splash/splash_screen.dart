import 'package:chat_zxc/shared/ui/aether_void_glow_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:chat_zxc/shared/theme/aether.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    // Имитация загрузки конфигов/проверки сессии
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      // GoRouter сам подхватит редирект на /welcome или / в зависимости от стейта
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AetherColors.void0,
      body: Stack(
        alignment: Alignment.center,
        children: [
          ...buildGlowEffects1(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity),
              Image.asset('assets/icon/icon-wo-bg.png', width: 200, height: 200)
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .shimmer(
                    duration: 2.seconds,
                    color: AetherColors.violet300.withValues(alpha: 0.3),
                  )
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.05, 1.05),
                    duration: 2.seconds,
                  ),

              const SizedBox(height: AetherSpacing.xl6),

              // Тот самый индикатор из пакета
              LoadingAnimationWidget.staggeredDotsWave(
                color: AetherColors.violet500,
                size: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
