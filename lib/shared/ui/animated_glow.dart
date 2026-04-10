import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedGlow extends StatelessWidget {
  final double? top, bottom, left, right;
  final double size;
  final Color color;
  final Duration delay;
  final bool animate; // Добавлен параметр

  const AnimatedGlow({
    super.key,
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.size,
    required this.color,
    required this.delay,
    this.animate = true, // По умолчанию анимация включена
  });

  @override
  Widget build(BuildContext context) {
    final glowWidget = Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color,
              color.withValues(alpha: color.a * 0.5),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );

    // Если анимация выключена, возвращаем статический виджет
    if (!animate) return glowWidget;

    // Иначе применяем анимации
    return glowWidget.animate(delay: delay).fadeIn(duration: 1200.ms).scale(
      begin: const Offset(0.5, 0.5),
      curve: Curves.easeOutCirc,
    );
  }
}