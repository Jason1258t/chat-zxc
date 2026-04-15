import 'package:chat_zxc/shared/ui/aether_void_glow_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:chat_zxc/shared/theme/aether.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ...buildGlowEffects1(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AetherSpacing.xl3,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 2),

                  // Логотип и слоган
                  _buildLogoGroup(context),

                  const Spacer(flex: 3),

                  // Кнопка с эффектом масштабирования и свечения
                  _buildGetStartedButton(context)
                      .animate(delay: 1000.ms)
                      .fadeIn(duration: 600.ms)
                      .scale(
                        begin: const Offset(0.8, 0.8),
                        curve: Curves.elasticOut,
                        duration: 800.ms,
                      ),

                  const SizedBox(height: AetherSpacing.xl2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoGroup(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLogo(context)
            .animate()
            .fadeIn(duration: 800.ms, curve: Curves.easeOut)
            .slideY(begin: 0.3, end: 0),

        const SizedBox(height: AetherSpacing.sm),

        Text(
              'Ready to chat? Your friends are waiting to chat with you.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AetherColors.textSecondary,
                letterSpacing: 0.5,
              ),
            )
            .animate(delay: 500.ms)
            .fadeIn(duration: 600.ms)
            .slideX(begin: -0.1, end: 0),
      ],
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AetherColors.violet500, AetherColors.cyan500],
            ).createShader(bounds),
            blendMode: BlendMode.srcIn,
            child: Text(
              'Chat\nZXC',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 68,
                height: 0.9,
                letterSpacing: -1.5,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),

        const SizedBox(height: AetherSpacing.sm),
        Container(
              width: 60,
              height: 2,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AetherColors.violet500, AetherColors.cyan500],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            )
            .animate(delay: 800.ms)
            .scaleX(
              begin: 0,
              alignment: Alignment.centerLeft,
              duration: 600.ms,
            ),
      ],
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.go('/auth/phone');
        },
        child: Text('Continue', style: AetherTypography.displaySmall),
      ),
    );
  }
}
