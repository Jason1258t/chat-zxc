import 'package:chat_zxc/shared/components/aether_button.dart';
import 'package:chat_zxc/shared/components/aether_text_field.dart';
import 'package:chat_zxc/shared/ui/aether_void_glow_background.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:chat_zxc/shared/theme/aether.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../feature/auth/auth_controller.dart';

class PhoneScreen extends ConsumerStatefulWidget {
  const PhoneScreen({super.key});

  @override
  ConsumerState<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends ConsumerState<PhoneScreen> {
  final _phoneController = TextEditingController();
  bool _agreed = false;


  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(AetherSpacing.xl2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: AetherSpacing.md),
                Text('Sending code...'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _hideLoadingDialog() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  Future<void> sendCode() async {
    _showLoadingDialog();

    try {
      await ref
          .read(authControllerProvider.notifier)
          .sendCode(_phoneController.text.trim());

      _hideLoadingDialog();
      goToVerify();
    } catch (e) {
      _hideLoadingDialog();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send code: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void goToVerify() {
    context.go('/auth/verify-phone');
  }

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
                  const SizedBox(height: AetherSpacing.xl6),
                  Text('Your Phone', style: AetherTypography.displayLarge),
                  const SizedBox(height: AetherSpacing.sm),
                  Text(
                    'Confirm your country code and enter phone number.',
                    style: AetherTypography.bodyLarge.copyWith(
                      color: AetherColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AetherSpacing.xl6),

                  AetherTextField.phone(
                    controller: _phoneController,
                    label: 'Phone Number',
                  ).animate().fadeIn().slideY(begin: 0.1),

                  const SizedBox(height: AetherSpacing.xl2),

                  // Блок согласия на обработку данных
                  Row(
                    children: [
                      Checkbox(
                        value: _agreed,
                        onChanged: (v) => setState(() => _agreed = v ?? false),
                        activeColor: AetherColors.violet500,
                        checkColor: Colors.white,
                        side: const BorderSide(color: AetherColors.void400),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: AetherTypography.bodySmall.copyWith(
                              color: AetherColors.textSecondary,
                            ),
                            children: [
                              const TextSpan(text: 'I agree to the '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: const TextStyle(
                                  color: AetherColors.cyan500,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                              const TextSpan(text: ' and terms of service.'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ).animate(delay: 200.ms).fadeIn(),

                  const Spacer(),
                  AetherButton.elevated(
                    label: 'Next',
                    fullWidth: true,
                    onPressed: _agreed ? sendCode : null,
                  ).animate(delay: 400.ms).fadeIn(),
                  const SizedBox(height: AetherSpacing.xl4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
