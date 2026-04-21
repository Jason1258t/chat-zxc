import 'package:chat_zxc/shared/components/aether_button.dart';
import 'package:chat_zxc/shared/components/aether_text_field.dart';
import 'package:chat_zxc/shared/ui/aether_void_glow_background.dart';
import 'package:chat_zxc/shared/ui/app_dialogs.dart';
import 'package:chat_zxc/shared/utils/dialog_manager.dart';
import 'package:chat_zxc/shared/utils/notifications_manager.dart';
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

  void sendCode() async {
    await ref
        .read(authControllerProvider.notifier)
        .sendCode(_phoneController.text.trim());

    navigateToVerify();
  }

  void navigateToVerify() => context.go('/auth/verify-phone');



  @override
  Widget build(BuildContext context) {
    ref.listen<AuthControllerState>(authControllerProvider, (previous, next) {
      // Управление лоадером через каталог
      if (next.loading && !(previous?.loading ?? false)) {
        DialogManager().showModal(
          context,
          AppDialogs.loading(),
          barrierDismissible: false,
        );
      } else if (!next.loading && (previous?.loading ?? false)) {
        DialogManager().hideDialog();
      }

      // Управление ошибками через менеджер уведомлений
      if (next.error != null && next.error != previous?.error) {
        NotificationManager().showError(context, next.error.toString());
        ref.read(authControllerProvider.notifier).clearError();
      }
    });

    final isLoading = ref.watch(authControllerProvider.select((s) => s.loading));


    // Показываем ошибку и сбрасываем её

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
                    enabled: !isLoading,
                  ).animate().fadeIn().slideY(begin: 0.1),
                  const SizedBox(height: AetherSpacing.xl2),
                  Row(
                    children: [
                      Checkbox(
                        value: _agreed,
                        onChanged: isLoading
                            ? null
                            : (v) => setState(() => _agreed = v ?? false),
                        activeColor: AetherColors.violet500,
                        checkColor: Colors.white,
                        side: const BorderSide(color: AetherColors.void400),
                      ),
                      Expanded(child: _buildPrivacy()),
                    ],
                  ).animate(delay: 200.ms).fadeIn(),
                  const Spacer(),
                  AetherButton.elevated(
                    label: isLoading ? 'Sending...' : 'Next',
                    fullWidth: true,
                    onPressed: (_agreed && !isLoading) ? sendCode : null,
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

  Widget _buildPrivacy() {
    return RichText(
      text: TextSpan(
        style: AetherTypography.bodySmall.copyWith(
          color: AetherColors.textSecondary,
        ),
        children: [
          const TextSpan(text: 'I agree to the '),
          TextSpan(
            text: 'Privacy Policy',
            style: const TextStyle(color: AetherColors.cyan500),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          const TextSpan(text: ' and terms of service.'),
        ],
      ),
    );
  }
}
