import 'package:chat_zxc/shared/components/aether_button.dart';
import 'package:chat_zxc/shared/ui/aether_void_glow_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:chat_zxc/shared/theme/aether.dart';
import 'package:pinput/pinput.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Настройка темы для Pinput в стиле Aether
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: AetherTypography.displaySmall.copyWith(
        color: AetherColors.textPrimary,
        fontSize: 24,
      ),
      decoration: BoxDecoration(
        color: AetherColors.void200,
        borderRadius: BorderRadius.circular(AetherRadius.md),
        border: Border.all(color: AetherColors.void400),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AetherColors.violet500),
        boxShadow: [
          BoxShadow(
            color: AetherColors.violet500.withValues(alpha: 0.15),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          ...buildGlowEffects1(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AetherSpacing.xl3),
              child: Column(
                children: [
                  const SizedBox(height: AetherSpacing.lg),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(CupertinoIcons.back),
                      color: AetherColors.textSecondary,
                      onPressed: () => context.go('/auth/sign-up'),
                    ),
                  ),
                  const SizedBox(height: AetherSpacing.xl4),
                  _buildIconGroup(context),
                  const SizedBox(height: AetherSpacing.xl5),
                  _buildTextInfo(context),
                  const SizedBox(height: AetherSpacing.xl4),

                  // Поле ввода кода
                  Pinput(
                    length: 4,
                    // Можно поменять на 6, если Firebase настроен так
                    controller: pinController,
                    focusNode: focusNode,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    separatorBuilder: (index) => const SizedBox(width: 12),
                    onCompleted: (pin) {
                      // Логика проверки кода
                      context.go('/auth/enter-name');
                    },
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          width: 20,
                          height: 2,
                          color: AetherColors.violet500,
                        ),
                      ],
                    ),
                  ).animate(delay: 500.ms).fadeIn().slideY(begin: 0.1, end: 0),

                  const Spacer(),
                  _buildActionButtons(context),
                  const SizedBox(height: AetherSpacing.xl2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Вспомогательные методы (аналогичные предыдущим, но с правками верстки) ---

  Widget _buildIconGroup(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AetherColors.violet100.withValues(alpha: 0.3),
        boxShadow: AetherShadows.glowViolet,
        border: Border.all(
          color: AetherColors.violet500.withValues(alpha: 0.2),
        ),
      ),
      child: const Icon(
        CupertinoIcons.mail_solid,
        size: 44,
        color: AetherColors.violet500,
      ),
    ).animate().scale(curve: Curves.easeOutBack).fadeIn();
  }

  Widget _buildTextInfo(BuildContext context) {
    return Column(
      children: [
        Text(
          'Verify your email',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: AetherSpacing.md),
        Text(
          'Enter the code we just sent to your inbox.',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AetherColors.textSecondary),
          textAlign: TextAlign.center,
        ),
      ],
    ).animate(delay: 200.ms).fadeIn();
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        AetherButton.elevated(
          label: 'Verify Code',
          fullWidth: true,
          onPressed: () => context.go('/auth/enter-name'),
        ),
        const SizedBox(height: AetherSpacing.md),
        AetherButton.ghost(
          label: 'Resend code',
          fullWidth: true,
          onPressed: () {},
        ),
      ],
    ).animate(delay: 700.ms).fadeIn();
  }
}
