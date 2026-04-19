import 'package:chat_zxc/entities/user/profile.dart';
import 'package:chat_zxc/feature/auth/auth_controller.dart';
import 'package:chat_zxc/feature/profile/model/draft_profile.dart';
import 'package:chat_zxc/shared/components/aether_button.dart';
import 'package:chat_zxc/shared/components/aether_text_field.dart';
import 'package:chat_zxc/shared/ui/aether_void_glow_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:chat_zxc/shared/theme/aether.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EnterNameScreen extends ConsumerStatefulWidget {
  const EnterNameScreen({super.key});

  @override
  ConsumerState<EnterNameScreen> createState() => _EnterNameScreenState();
}

class _EnterNameScreenState extends ConsumerState<EnterNameScreen> {
  final _usernameController = TextEditingController();
  final _displayNameController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    DraftProfile draft = ref.read(authControllerProvider.notifier).draftProfile;
    _usernameController.text = draft.username;
    _displayNameController.text = draft.displayName;
    super.initState();
  }

  void _handleComplete() async {
    final username = _usernameController.text.trim().toLowerCase();
    final displayName = _displayNameController.text.trim();

    if (displayName.isEmpty) {
      _showErrorSnackBar('Please enter your display name');
      return;
    }

    if (username.isEmpty) {
      _showErrorSnackBar('Username cannot be empty');
      return;
    }

    setState(() => _isLoading = true);
    ref
        .read(authControllerProvider.notifier)
        .completeRegistration(username: username, displayName: displayName);
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AetherTypography.bodyMedium.copyWith(color: Colors.white),
        ),
        backgroundColor: AetherColors.rose500.withValues(alpha: 0.8),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(AetherSpacing.lg),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AetherRadius.md),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  static final _usernameFormatter = MaskTextInputFormatter(
    mask: '@${'#' * UserProfile.maxUsernameLength}',
    filter: {"#": RegExp(r'[a-zA-Z0-9_]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ...buildGlowEffects1(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AetherSpacing.xl3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AetherSpacing.xl6),

                  Text(
                    'Identity',
                    style: AetherTypography.displayLarge,
                  ).animate().fadeIn().slideX(begin: -0.2),

                  const SizedBox(height: AetherSpacing.sm),

                  Text(
                    'How should others see you here?',
                    style: AetherTypography.bodyLarge.copyWith(
                      color: AetherColors.textSecondary,
                    ),
                  ).animate(delay: 100.ms).fadeIn(),

                  const SizedBox(height: AetherSpacing.xl6),

                  // Поле для публичного имени (проверка только на пустоту)
                  AetherTextField(
                    controller: _displayNameController,
                    label: 'Display Name',
                    hint: 'Your name to display',
                    textInputAction: TextInputAction.next,
                  ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.1),

                  const SizedBox(height: AetherSpacing.xl2),

                  // Поле для уникального username
                  AetherTextField(
                    controller: _usernameController,
                    label: 'Username',
                    hint: '@username',
                    // Подсказка теперь тоже с собачкой
                    keyboardType: TextInputType.text,
                    inputFormatters: [_usernameFormatter],
                  ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.1),

                  const Spacer(),

                  AetherButton.elevated(
                    label: 'Enter the ZXC',
                    fullWidth: true,
                    onPressed: _isLoading ? null : _handleComplete,
                    // Добавляем индикатор загрузки если нужно, или просто блокируем
                  ).animate(delay: 400.ms).fadeIn(),

                  SizedBox(height: AetherSpacing.xl6),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
