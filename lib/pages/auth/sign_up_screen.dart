import 'package:chat_zxc/shared/components/aether_button.dart';
import 'package:chat_zxc/shared/components/aether_badge_chip_toggle.dart';
import 'package:chat_zxc/shared/components/aether_text_field.dart';
import 'package:chat_zxc/shared/ui/aether_void_glow_background.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:chat_zxc/shared/theme/aether.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _agreeToTerms = false;
  bool _isLoading = false;

  // Для валидации
  String? _emailError;
  String? _usernameError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _emailError == null &&
          _usernameError == null &&
          _passwordError == null &&
          _confirmPasswordError == null &&
          _emailController.text.isNotEmpty &&
          _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _agreeToTerms;

  void _validateEmail(String value) {
    setState(() {
      if (value.isEmpty) {
        _emailError = null;
      } else if (!value.contains('@') || !value.contains('.')) {
        _emailError = 'Enter a valid email address';
      } else {
        _emailError = null;
      }
    });
  }

  void _validateUsername(String value) {
    setState(() {
      if (value.isEmpty) {
        _usernameError = null;
      } else if (value.length < 3) {
        _usernameError = 'Username must be at least 3 characters';
      } else {
        _usernameError = null;
      }
    });
  }

  void _validatePassword(String value) {
    setState(() {
      if (value.isEmpty) {
        _passwordError = null;
      } else if (value.length < 8) {
        _passwordError = 'Password must be at least 8 characters';
      } else {
        _passwordError = null;
      }
    });
    _validateConfirmPassword(_confirmPasswordController.text);
  }

  void _validateConfirmPassword(String value) {
    setState(() {
      if (value.isEmpty) {
        _confirmPasswordError = null;
      } else if (value != _passwordController.text) {
        _confirmPasswordError = 'Passwords do not match';
      } else {
        _confirmPasswordError = null;
      }
    });
  }

  void _handleSignUp() {
    if (!_isFormValid) return;

    setState(() => _isLoading = true);

    // Симуляция регистрации
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      // TODO: реальная регистрация
    });
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
                children: [
                  const Spacer(flex: 1),
                  _buildLogoGroup(context),
                  const SizedBox(height: AetherSpacing.xl4),
                  _buildForm(context),
                  const Spacer(flex: 2),
                  const SizedBox(height: AetherSpacing.xl2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;

    const loginPromptText = "Already have an account? ";
    const loginLinkText = "Sign in";

    return Column(
      children: [
        // Заголовок
        Text("Create Account", style: AetherTypography.displayLarge)
            .animate(delay: 100.ms)
            .fadeIn(duration: 200.ms)
            .slideY(begin: 1, end: 0, duration: 150.ms),

        const SizedBox(height: AetherSpacing.lg),

        // Поле Email
        AetherTextField(
          label: "Email",
          hint: "user@example.com",
          controller: _emailController,
          leading: const Icon(Icons.email_outlined),
          keyboardType: TextInputType.emailAddress,
          errorText: _emailError,
          onChanged: _validateEmail,
        )
            .animate(delay: 200.ms)
            .fadeIn(duration: 200.ms)
            .slideY(begin: 1.5, end: 0, duration: 150.ms),

        const SizedBox(height: AetherSpacing.lg),

        // Поле Password
        AetherTextField.password(
          label: "Password",
          controller: _passwordController,
          helperText: "Minimum 8 characters",
          errorText: _passwordError,
          onChanged: _validatePassword,
        )
            .animate(delay: 250.ms)
            .fadeIn(duration: 200.ms)
            .slideY(begin: 1.5, end: 0, duration: 150.ms),

        const SizedBox(height: AetherSpacing.lg),

        // Поле Confirm Password
        AetherTextField.password(
          label: "Confirm Password",
          controller: _confirmPasswordController,
          errorText: _confirmPasswordError,
          onChanged: _validateConfirmPassword,
        )
            .animate(delay: 300.ms)
            .fadeIn(duration: 200.ms)
            .slideY(begin: 1.5, end: 0, duration: 150.ms),

        const SizedBox(height: AetherSpacing.xl2),

        // Чекбокс согласия с условиями (используем AetherToggle)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AetherSpacing.xs),
          child: AetherToggle(
            label: "I agree to the Terms of Service and Privacy Policy",
            value: _agreeToTerms,
            onChanged: (value) {
              setState(() {
                _agreeToTerms = value;
              });
            },
          ),
        )
            .animate(delay: 350.ms)
            .fadeIn(duration: 200.ms)
            .slideY(begin: 0.5, end: 0, duration: 150.ms),

        const SizedBox(height: AetherSpacing.xl3),

        // Кнопка Sign Up
        AetherButton.elevated(
          label: _isLoading ? "Creating account..." : "Sign Up",
          fullWidth: true,
          onPressed: _isFormValid && !_isLoading ? _handleSignUp : () {
            context.go('/auth/verify-email'); // TODO temp
          },
        )
            .animate(delay: 400.ms)
            .fadeIn(duration: 200.ms)
            .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          duration: 200.ms,
        ),

        const SizedBox(height: AetherSpacing.lg),

        // Ссылка на вход
        RichText(
          text: TextSpan(
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            children: [
              TextSpan(text: loginPromptText),
              TextSpan(
                text: loginLinkText,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.secondary,
                  decoration: TextDecoration.underline,
                  decorationColor: colorScheme.secondary.withValues(
                    alpha: 0.4,
                  ),
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.go('/auth/sign-in');
                  },
              ),
            ],
          ),
        )
            .animate(delay: 450.ms)
            .fadeIn(duration: 200.ms)
            .slideY(begin: 0.3, end: 0, duration: 150.ms),
      ],
    );
  }

  Widget _buildLogoGroup(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/icon/icon-wo-bg.png', width: 180, height: 180)
            .animate()
            .fadeIn(duration: 800.ms, curve: Curves.easeOut)
            .slideY(begin: -0.7, end: 0),
        Text('Join us...', style: Theme
            .of(context)
            .textTheme
            .bodyLarge)
            .animate(delay: 500.ms)
            .fadeIn(duration: 600.ms)
            .slideY(begin: -0.3, end: 0),
      ],
    );
  }
}
