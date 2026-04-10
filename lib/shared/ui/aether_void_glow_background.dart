
import 'package:chat_zxc/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'animated_glow.dart';

List<Widget> buildGlowEffects1({bool animate = true}) {
  return [
    // Фиолетовое свечение сверху
    AnimatedGlow(
      top: -80,
      right: -50,
      size: 280,
      color: AetherColors.violet500.withValues(alpha: .35),
      delay: 0.ms,
      animate: animate,
    ),

    // Циановое свечение снизу
    AnimatedGlow(
      bottom: -60,
      left: -40,
      size: 240,
      color: AetherColors.cyan500.withValues(alpha: 0.2),
      delay: 350.ms,
      animate: animate,
    ),

    // Третье свечение для глубины
    AnimatedGlow(
      top: 200,
      left: -100,
      size: 200,
      color: AetherColors.rose500.withValues(alpha: 0.4),
      delay: 250.ms,
      animate: animate,
    ),
  ];
}