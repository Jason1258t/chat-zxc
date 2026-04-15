import 'package:chat_zxc/feature/auth/auth_controller.dart';
import 'package:chat_zxc/shared/components/aether_button.dart';
import 'package:chat_zxc/shared/ui/aether_void_glow_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:chat_zxc/shared/theme/aether.dart';
import 'package:pinput/pinput.dart';

class VerifyPhoneScreen extends ConsumerStatefulWidget {
  const VerifyPhoneScreen({super.key});

  @override
  ConsumerState<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends ConsumerState<VerifyPhoneScreen> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 48,
      height: 56,
      textStyle: AetherTypography.displaySmall.copyWith(
        color: AetherColors.textPrimary,
      ),
      decoration: BoxDecoration(
        color: AetherColors.void200,
        borderRadius: BorderRadius.circular(AetherRadius.md),
        border: Border.all(color: AetherColors.void400),
      ),
    );

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
                children: [
                  const SizedBox(height: AetherSpacing.lg),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(CupertinoIcons.back),
                      onPressed: () => context.go('/auth/phone'),
                    ),
                  ),
                  const Spacer(),

                  // Иконка СМС вместо почты
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: AetherShadows.glowViolet,
                    ),
                    child: const Icon(
                      CupertinoIcons.chat_bubble_2_fill,
                      size: 48,
                      color: AetherColors.violet500,
                    ),
                  ).animate().scale(curve: Curves.easeOutBack),

                  const SizedBox(height: AetherSpacing.xl4),
                  Text('Verification', style: AetherTypography.displayMedium),
                  const SizedBox(height: AetherSpacing.md),
                  Text(
                    'We sent a 6-digit code to your phone.',
                    style: AetherTypography.bodyMedium.copyWith(
                      color: AetherColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: AetherSpacing.xl5),

                  Pinput(
                    length: 6, // 6 символов для СМС-кода
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(color: AetherColors.violet500),
                      ),
                    ),
                      onCompleted: (pin) async {
                        await ref.read(authControllerProvider.notifier).verifyCode(pin);
                      }
                  ),

                  const Spacer(flex: 2),
                  AetherButton.ghost(
                    label: 'Resend Code',
                    fullWidth: true,
                    onPressed: () {},
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
}
