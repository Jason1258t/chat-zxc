import 'package:chat_zxc/shared/components/aether_button.dart';
import 'package:chat_zxc/shared/components/aether_text_field.dart';
import 'package:chat_zxc/shared/ui/aether_void_glow_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:chat_zxc/shared/theme/aether.dart';

class EnterNameScreen extends StatefulWidget {
  const EnterNameScreen({super.key});

  @override
  State<EnterNameScreen> createState() => _EnterNameScreenState();
}

class _EnterNameScreenState extends State<EnterNameScreen> {
  final _usernameController = TextEditingController();
  final _displayNameController = TextEditingController();

  bool _isLoading = false;

  // Имитация списка занятых имен для теста
  final List<String> _takenUsernames = ['admin', 'aether', 'void', 'zxc'];

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

    // Имитация задержки сетевого запроса
    await Future.delayed(const Duration(seconds: 1));

    if (_takenUsernames.contains(username)) {
      setState(() => _isLoading = false);
      _showErrorSnackBar('Username @$username is already taken');
    } else {
      // Успех: меняем глобальный стейт, роутер сам перекинет на '/'
      // mockAuthState.value = true;
    }
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
                    hint: 'Your name or nickname',
                    textInputAction: TextInputAction.next,
                  ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.1),

                  const SizedBox(height: AetherSpacing.xl2),

                  // Поле для уникального username
                  AetherTextField(
                    controller: _usernameController,
                    label: 'Username',
                    hint: 'unique_handle',
                    leading: const Padding(
                      padding: EdgeInsets.only(left: 12, right: 4),
                      child: Text(
                        '@',
                        style: TextStyle(
                          color: AetherColors.violet500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    inputFormatters: [
                      // Ограничиваем ввод только латиницей, цифрами и нижним подчеркиванием
                    ],
                  ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.1),

                  const Spacer(),

                  AetherButton.elevated(
                    label: 'Enter the ZXC',
                    fullWidth: true,
                    onPressed: _isLoading ? null : _handleComplete,
                    // Добавляем индикатор загрузки если нужно, или просто блокируем
                  ).animate(delay: 400.ms).fadeIn(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
