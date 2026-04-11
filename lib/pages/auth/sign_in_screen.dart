import 'package:chat_zxc/shared/components/aether_button.dart';
import 'package:chat_zxc/shared/components/aether_text_field.dart';
import 'package:chat_zxc/shared/ui/aether_void_glow_background.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:chat_zxc/shared/theme/aether.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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

                  // Логотип и слоган
                  _buildLogoGroup(context),
                  SizedBox(height: AetherSpacing.xl6),
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

    final promptText = "Haven't account yet? ";
    final linkText = "Let's sign up";

    return Column(
      children: [
        Text("Sign In", style: AetherTypography.displayLarge)
            .animate(delay: 100.ms)
            .fadeIn(duration: 200.ms)
            .slideY(begin: 1, end: 0, duration: 150.ms),
        SizedBox(height: AetherSpacing.xl2),
        AetherTextField(hint: "Email", leading: Icon(Icons.email_outlined))
            .animate(delay: 200.ms)
            .fadeIn(duration: 200.ms)
            .slideY(begin: 1.5, end: 0, duration: 150.ms),
        SizedBox(height: AetherSpacing.lg),
        AetherTextField.password()
            .animate(delay: 300.ms)
            .fadeIn(duration: 200.ms)
            .slideY(begin: 1, end: 0, duration: 150.ms),
        SizedBox(height: AetherSpacing.xl2),
        AetherButton.elevated(
          label: "Sign In",
          fullWidth: true,
          onPressed: () {
            // Navigator.pop(context);
          },
        )
            .animate(delay: 400.ms)
            .fadeIn(duration: 200.ms)
            .slideY(begin: 1, end: 0, duration: 150.ms),
        SizedBox(height: AetherSpacing.lg),
        RichText(
          text: TextSpan(
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            children: [
              TextSpan(text: promptText),
              TextSpan(
                text: linkText,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.secondary,
                  decoration: TextDecoration.underline,
                  decorationColor: colorScheme.secondary.withValues(alpha: 0.4),
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.go('/auth/sign-up');
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLogoGroup(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/icon/icon-wo-bg.png', width: 200, height: 200)
            .animate()
            .fadeIn(duration: 800.ms, curve: Curves.easeOut)
            .slideY(begin: -0.7, end: 0),

        Text(
          'Have an account? Let\'s sign in.',
          style: Theme
              .of(context)
              .textTheme
              .bodyLarge,
        )
            .animate(delay: 500.ms)
            .fadeIn(duration: 600.ms)
            .slideY(begin: -0.3, end: 0),
      ],
    );
  }
}
