import 'package:flutter/material.dart';
import 'package:chat_zxc/shared/theme/aether.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppDialogs {
  // Тот самый блокирующий лоадер
  static Widget loading() {
    return PopScope(
      canPop: false,
      child: Center(
        child: LoadingAnimationWidget.fourRotatingDots(
          color: AetherColors.violet500,
          size: 50,
        ),
      ),
    );
  }

  static Widget info(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    return AlertDialog(
      backgroundColor: AetherColors.void200,
      title: Text(title, style: const TextStyle(color: Colors.white)),
      content: Text(
        message,
        style: const TextStyle(color: AetherColors.textSecondary),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'OK',
            style: TextStyle(color: AetherColors.violet400),
          ),
        ),
      ],
    );
  }
}
