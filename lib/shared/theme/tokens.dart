import 'package:flutter/material.dart';
import 'colors.dart';

/// Aether Design System — Spacing, Radius, Elevation & Motion

// ──────────────────────────────────────────
// SPACING
// ──────────────────────────────────────────

/// Базовая единица — 4px. Все отступы кратны ей.
abstract class AetherSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xl2 = 24.0;
  static const double xl3 = 32.0;
  static const double xl4 = 40.0;
  static const double xl5 = 48.0;
  static const double xl6 = 64.0;

  // Chat-specific
  static const double bubblePaddingH = 14.0;
  static const double bubblePaddingV = 10.0;
  static const double bubbleSpacing = 2.0;  // между пузырями одного отправителя
  static const double threadSpacing = 12.0; // между группами сообщений
  static const double avatarSize = 40.0;
  static const double avatarSizeLg = 56.0;
  static const double avatarSizeXl = 80.0;

  // Input bar
  static const double inputBarHeight = 52.0;
  static const double inputBarPaddingH = 12.0;
  static const double inputBarPaddingV = 8.0;

  // Navigation
  static const double bottomNavHeight = 64.0;
  static const double appBarHeight = 56.0;
}

// ──────────────────────────────────────────
// BORDER RADIUS
// ──────────────────────────────────────────

abstract class AetherRadius {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double full = 999.0;

  // Bubble-специфичные радиусы
  static const BorderRadius bubbleOutgoing = BorderRadius.only(
    topLeft: Radius.circular(18),
    topRight: Radius.circular(18),
    bottomLeft: Radius.circular(18),
    bottomRight: Radius.circular(4), // "хвост" справа
  );

  static const BorderRadius bubbleIncoming = BorderRadius.only(
    topLeft: Radius.circular(4), // "хвост" слева
    topRight: Radius.circular(18),
    bottomLeft: Radius.circular(18),
    bottomRight: Radius.circular(18),
  );

  // Первое сообщение в цепочке (большой радиус везде)
  static const BorderRadius bubbleOutgoingFirst = BorderRadius.only(
    topLeft: Radius.circular(18),
    topRight: Radius.circular(18),
    bottomLeft: Radius.circular(18),
    bottomRight: Radius.circular(4),
  );

  static const BorderRadius bubbleIncomingFirst = BorderRadius.only(
    topLeft: Radius.circular(4),
    topRight: Radius.circular(18),
    bottomLeft: Radius.circular(18),
    bottomRight: Radius.circular(18),
  );

  static const BorderRadius card = BorderRadius.all(Radius.circular(16));
  static const BorderRadius sheet = BorderRadius.only(
    topLeft: Radius.circular(24),
    topRight: Radius.circular(24),
  );
  static const BorderRadius input = BorderRadius.all(Radius.circular(12));
  static const BorderRadius chip = BorderRadius.all(Radius.circular(999));
  static const BorderRadius avatar = BorderRadius.all(Radius.circular(999));
  static const BorderRadius avatarGroup = BorderRadius.all(Radius.circular(14));
}

// ──────────────────────────────────────────
// ELEVATION / SHADOWS
// ──────────────────────────────────────────

abstract class AetherShadows {
  /// Тонкая тень для карточек и элементов на поверхности
  static List<BoxShadow> get cardSubtle => [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  /// Средняя тень — модальные окна, bottom sheets
  static List<BoxShadow> get modal => [
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 24,
          offset: const Offset(0, -4),
        ),
      ];

  /// Glow-эффект для акцентных кнопок (violet)
  static List<BoxShadow> get glowViolet => [
        BoxShadow(
          color: AetherColors.glowViolet,
          blurRadius: 20,
          spreadRadius: -2,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: AetherColors.glowViolet.withOpacity(0.3),
          blurRadius: 40,
          spreadRadius: -4,
          offset: const Offset(0, 8),
        ),
      ];

  /// Glow-эффект для онлайн-аватаров / активных элементов (cyan)
  static List<BoxShadow> get glowCyan => [
        BoxShadow(
          color: AetherColors.glowCyan,
          blurRadius: 12,
          spreadRadius: 0,
          offset: const Offset(0, 0),
        ),
      ];

  /// Glow для уведомлений / badge (rose)
  static List<BoxShadow> get glowRose => [
        BoxShadow(
          color: AetherColors.glowRose,
          blurRadius: 8,
          spreadRadius: 0,
          offset: const Offset(0, 0),
        ),
      ];

  /// Тень входящего пузыря
  static List<BoxShadow> get bubbleIncoming => [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ];

  /// Тень исходящего пузыря (с фиолетовым подсветом)
  static List<BoxShadow> get bubbleOutgoing => [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        BoxShadow(
          color: AetherColors.violet400.withOpacity(0.15),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];
}

// ──────────────────────────────────────────
// MOTION / ANIMATION
// ──────────────────────────────────────────

abstract class AetherMotion {
  // Durations
  static const Duration instant = Duration(milliseconds: 80);
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);
  static const Duration xslow = Duration(milliseconds: 600);

  // Curves
  /// Стандартный ease — большинство переходов
  static const Curve standard = Curves.easeInOut;

  /// Вход элементов — accelerate from zero
  static const Curve enter = Curves.easeOut;

  /// Выход элементов
  static const Curve exit = Curves.easeIn;

  /// Упругость — появление пузырей, уведомлений
  static const Curve spring = Curves.elasticOut;

  /// Плавный bounce для FAB / кнопок
  static const Curve bounce = Curves.bounceOut;

  /// Плавный decelerate — slide-in панели
  static const Curve decelerate = Curves.decelerate;

  // Preset transitions
  static const Duration messageAppear = Duration(milliseconds: 200);
  static const Curve messageAppearCurve = Curves.easeOutBack;

  static const Duration reactionPop = Duration(milliseconds: 300);
  static const Curve reactionPopCurve = Curves.elasticOut;

  static const Duration pageTransition = Duration(milliseconds: 350);
  static const Curve pageTransitionCurve = Curves.easeOutCubic;

  static const Duration sheetSlide = Duration(milliseconds: 400);
  static const Curve sheetSlideCurve = Curves.easeOutQuart;
}

// ──────────────────────────────────────────
// OPACITY TOKENS
// ──────────────────────────────────────────

abstract class AetherOpacity {
  static const double disabled = 0.38;
  static const double subtle = 0.6;
  static const double medium = 0.75;
  static const double strong = 0.9;
  static const double full = 1.0;

  // Glass layers
  static const double glassThin = 0.06;
  static const double glassLight = 0.10;
  static const double glassMedium = 0.15;
}

// ──────────────────────────────────────────
// ICON SIZES
// ──────────────────────────────────────────

abstract class AetherIconSize {
  static const double xs = 14.0;
  static const double sm = 16.0;
  static const double md = 20.0;
  static const double lg = 24.0;
  static const double xl = 28.0;
  static const double xl2 = 32.0;
  static const double xl3 = 48.0;
}

// ──────────────────────────────────────────
// BLUR (BackdropFilter)
// ──────────────────────────────────────────

abstract class AetherBlur {
  static const double subtle = 4.0;
  static const double medium = 12.0;
  static const double strong = 24.0;
  static const double extreme = 40.0;
}
