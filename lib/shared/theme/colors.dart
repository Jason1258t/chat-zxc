import 'package:flutter/material.dart';

/// Aether Design System — Color Tokens
///
/// Построена вокруг "void" эстетики:
/// глубокие почти-чёрные фоны с синим подтоном,
/// мягкие фиолетовые акценты и холодный cyan-glow.
abstract class AetherColors {
  // ──────────────────────────────────────────
  // BASE PALETTE (raw color values)
  // ──────────────────────────────────────────

  /// Абсолютная пустота — основной фон приложения
  static const Color void0 = Color(0xFF080A0F);

  /// Тёмная бездна — фон панелей / drawer
  static const Color void100 = Color(0xFF0D0F15);

  /// Поверхность — карточки, чат-пузыри
  static const Color void200 = Color(0xFF12151C);

  /// Поверхность с подъёмом — hover / active states
  static const Color void300 = Color(0xFF191D27);

  /// Разделители и границы
  static const Color void400 = Color(0xFF252A38);

  /// Приглушённые иконки, placeholder-текст
  static const Color void500 = Color(0xFF454C61);

  // ──────────────────────────────────────────
  // ACCENT — PRIMARY (Violet Glow)
  // ──────────────────────────────────────────

  static const Color violet100 = Color(0xFF1A0F2E);
  static const Color violet200 = Color(0xFF2D1E52);
  static const Color violet300 = Color(0xFF4A2F82);
  static const Color violet400 = Color(0xFF6B46C1);

  /// Основной акцент — кнопки, активные элементы
  static const Color violet500 = Color(0xFF8B5CF6);

  /// Hover-состояние основного акцента
  static const Color violet600 = Color(0xFFA78BFA);

  /// Светлый тинт, subtle highlights
  static const Color violet700 = Color(0xFFC4B5FD);

  // ──────────────────────────────────────────
  // ACCENT — SECONDARY (Cyan Haze)
  // ──────────────────────────────────────────

  static const Color cyan100 = Color(0xFF071A1F);
  static const Color cyan200 = Color(0xFF0E2E35);
  static const Color cyan300 = Color(0xFF164E57);
  static const Color cyan400 = Color(0xFF0E7490);

  /// Онлайн-индикатор, ссылки, вторичные акценты
  static const Color cyan500 = Color(0xFF06B6D4);

  /// Glow-эффект, иконки активных чатов
  static const Color cyan600 = Color(0xFF22D3EE);

  // ──────────────────────────────────────────
  // ACCENT — TERTIARY (Rose Dust)
  // ──────────────────────────────────────────

  static const Color rose300 = Color(0xFF4C1D2F);
  static const Color rose400 = Color(0xFF881337);

  /// Уведомления, "непрочитано", важные статусы
  static const Color rose500 = Color(0xFFF43F5E);

  static const Color rose600 = Color(0xFFFB7185);

  // ──────────────────────────────────────────
  // NEUTRAL TEXT
  // ──────────────────────────────────────────

  /// Основной текст — максимальный контраст
  static const Color textPrimary = Color(0xFFECEDF5);

  /// Вторичный текст — имена, метки
  static const Color textSecondary = Color(0xFFAAADB8);

  /// Tertiary — timestamp, disabled
  static const Color textTertiary = Color(0xFF636779);

  /// Инвертированный текст (на светлых поверхностях)
  static const Color textInverse = Color(0xFF0A0B0F);

  // ──────────────────────────────────────────
  // SEMANTIC
  // ──────────────────────────────────────────

  static const Color success = Color(0xFF10B981);
  static const Color successSubtle = Color(0xFF064E3B);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningSubtle = Color(0xFF451A03);

  static const Color error = Color(0xFFF43F5E);
  static const Color errorSubtle = Color(0xFF4C0519);

  static const Color info = Color(0xFF06B6D4);
  static const Color infoSubtle = Color(0xFF071A1F);

  // ──────────────────────────────────────────
  // CHAT BUBBLE SPECIFIC
  // ──────────────────────────────────────────

  /// Исходящее сообщение (от пользователя)
  static const Color bubbleOutgoing = Color(0xFF2D1E52);

  /// Входящее сообщение (от собеседника)
  static const Color bubbleIncoming = Color(0xFF14172094);

  /// Фон поля ввода
  static const Color inputBackground = Color(0xFF12151C);

  /// Граница поля ввода (focused)
  static const Color inputBorderFocused = Color(0xFF6B46C1);

  /// Граница поля ввода (default)
  static const Color inputBorderDefault = Color(0xFF252A38);

  // ──────────────────────────────────────────
  // GLASS / OVERLAY
  // ──────────────────────────────────────────

  /// Glassmorphism overlay — панели поверх контента
  static const Color glassLight = Color(0x1AFFFFFF);
  static const Color glassMedium = Color(0xff181818);
  static const Color glassDark = Color(0x0DFFFFFF);

  /// Overlay для модальных окон
  static const Color scrim = Color(0xCC080A0F);

  // ──────────────────────────────────────────
  // GLOW (для BoxShadow с цветом)
  // ──────────────────────────────────────────

  /// Violet glow — акцентные кнопки
  static const Color glowViolet = Color(0x558B5CF6);

  /// Cyan glow — онлайн-аватары, активные чаты
  static const Color glowCyan = Color(0x4006B6D4);

  /// Rose glow — уведомления
  static const Color glowRose = Color(0x44F43F5E);

  // ──────────────────────────────────────────
  // GRADIENTS
  // ──────────────────────────────────────────

  static const LinearGradient gradientPrimary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8B5CF6), Color(0xFF06B6D4)],
    stops: [0.0, 1.0],
  );

  static const LinearGradient gradientSubtle = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2D1E52), Color(0xFF071A1F)],
    stops: [0.0, 1.0],
  );

  static const LinearGradient gradientVoid = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF080A0F), Color(0xFF0D0F18)],
    stops: [0.0, 1.0],
  );

  static const LinearGradient gradientOutgoingBubble = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3B2568), Color(0xFF1E1242)],
    stops: [0.0, 1.0],
  );

  static const RadialGradient gradientGlowViolet = RadialGradient(
    center: Alignment.center,
    radius: 0.8,
    colors: [Color(0x338B5CF6), Color(0x008B5CF6)],
  );

  static const RadialGradient gradientGlowCyan = RadialGradient(
    center: Alignment.center,
    radius: 0.8,
    colors: [Color(0x3006B6D4), Color(0x0006B6D4)],
  );
}
