import 'package:flutter/material.dart';
import 'colors.dart';
import 'tokens.dart';
import 'typography.dart';

/// Aether Design System — Component Styles
///
/// Готовые стили для часто используемых компонентов мессенджера.
/// Используйте как справочник при построении виджетов.

// ──────────────────────────────────────────
// AVATAR STYLES
// ──────────────────────────────────────────

class AetherAvatarStyle {
  /// Стандартный аватар в списке чатов
  static BoxDecoration get default_ => const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AetherColors.gradientSubtle,
      );

  /// Аватар онлайн-пользователя (с cyan glow)
  static BoxDecoration get online => BoxDecoration(
        shape: BoxShape.circle,
        gradient: AetherColors.gradientSubtle,
        boxShadow: AetherShadows.glowCyan,
      );

  /// Индикатор онлайн-статуса (зелёная точка)
  static BoxDecoration get onlineIndicator => BoxDecoration(
        shape: BoxShape.circle,
        color: AetherColors.cyan500,
        border: Border.all(color: AetherColors.void0, width: 2),
        boxShadow: AetherShadows.glowCyan,
      );
}

// ──────────────────────────────────────────
// BUBBLE STYLES
// ──────────────────────────────────────────

class AetherBubbleStyle {
  /// Исходящее сообщение
  static BoxDecoration get outgoing => BoxDecoration(
        borderRadius: AetherRadius.bubbleOutgoing,
        gradient: AetherColors.gradientOutgoingBubble,
        boxShadow: AetherShadows.bubbleOutgoing,
      );

  /// Входящее сообщение
  static BoxDecoration get incoming => BoxDecoration(
        borderRadius: AetherRadius.bubbleIncoming,
        color: AetherColors.void200,
        border: Border.all(
          color: AetherColors.void400,
          width: 0.5,
        ),
        boxShadow: AetherShadows.bubbleIncoming,
      );

  /// Временной разделитель между группами сообщений
  static BoxDecoration get timeSeparator => BoxDecoration(
        color: AetherColors.glassLight,
        borderRadius: AetherRadius.chip,
        border: Border.all(
          color: AetherColors.void400,
          width: 0.5,
        ),
      );
}

// ──────────────────────────────────────────
// INPUT BAR
// ──────────────────────────────────────────

class AetherInputBarStyle {
  /// Контейнер нижней панели ввода
  static BoxDecoration get container => BoxDecoration(
        color: AetherColors.void100,
        border: const Border(
          top: BorderSide(color: AetherColors.void400, width: 0.5),
        ),
      );

  /// Само поле ввода текста
  static BoxDecoration get field => BoxDecoration(
        color: AetherColors.void200,
        borderRadius: AetherRadius.chip,
        border: Border.all(
          color: AetherColors.void400,
          width: 0.5,
        ),
      );

  /// Кнопка отправки (активная)
  static BoxDecoration get sendButtonActive => BoxDecoration(
        shape: BoxShape.circle,
        gradient: AetherColors.gradientPrimary,
        boxShadow: AetherShadows.glowViolet,
      );

  /// Кнопка отправки (неактивная)
  static BoxDecoration get sendButtonInactive => const BoxDecoration(
        shape: BoxShape.circle,
        color: AetherColors.void300,
      );
}

// ──────────────────────────────────────────
// UNREAD BADGE
// ──────────────────────────────────────────

class AetherBadgeStyle {
  static BoxDecoration get unread => BoxDecoration(
        color: AetherColors.violet500,
        borderRadius: AetherRadius.chip,
        boxShadow: AetherShadows.glowViolet,
      );

  static BoxDecoration get mention => BoxDecoration(
        color: AetherColors.rose500,
        borderRadius: AetherRadius.chip,
        boxShadow: AetherShadows.glowRose,
      );
}

// ──────────────────────────────────────────
// REACTION CHIP
// ──────────────────────────────────────────

class AetherReactionStyle {
  /// Реакция — обычная
  static BoxDecoration get default_ => BoxDecoration(
        color: AetherColors.void300,
        borderRadius: AetherRadius.chip,
        border: Border.all(
          color: AetherColors.void400,
          width: 0.5,
        ),
      );

  /// Реакция — добавлена текущим пользователем
  static BoxDecoration get selected => BoxDecoration(
        color: AetherColors.violet100,
        borderRadius: AetherRadius.chip,
        border: Border.all(
          color: AetherColors.violet400,
          width: 1,
        ),
      );
}

// ──────────────────────────────────────────
// GLASS SURFACE (glassmorphism)
// ──────────────────────────────────────────

class AetherGlassStyle {
  /// Лёгкое стекло — контекстные меню, tooltips
  static BoxDecoration get light => BoxDecoration(
        color: AetherColors.glassDark,
        borderRadius: AetherRadius.card,
        border: Border.all(
          color: AetherColors.glassLight,
          width: 0.5,
        ),
      );

  /// Среднее стекло — side panels, overlays
  static BoxDecoration get medium => BoxDecoration(
        color: AetherColors.glassMedium,
        borderRadius: AetherRadius.card,
        border: Border.all(
          color: AetherColors.glassMedium,
          width: 0.5,
        ),
      );
}

// ──────────────────────────────────────────
// TEXT STYLES (chat-specific, с цветом)
// ──────────────────────────────────────────

class AetherChatTextStyle {
  static TextStyle get outgoingMessage =>
      AetherTypography.messageText.copyWith(
        color: AetherColors.textPrimary,
      );

  static TextStyle get incomingMessage =>
      AetherTypography.messageText.copyWith(
        color: AetherColors.textPrimary,
      );

  static TextStyle get outgoingTimestamp =>
      AetherTypography.timestamp.copyWith(
        color: AetherColors.violet700.withOpacity(0.7),
      );

  static TextStyle get incomingTimestamp =>
      AetherTypography.timestamp.copyWith(
        color: AetherColors.textTertiary,
      );

  static TextStyle get senderName =>
      AetherTypography.senderName.copyWith(
        color: AetherColors.cyan500,
      );

  static TextStyle get chatListName =>
      AetherTypography.chatListName.copyWith(
        color: AetherColors.textPrimary,
      );

  static TextStyle get chatListPreview =>
      AetherTypography.chatListPreview.copyWith(
        color: AetherColors.textTertiary,
      );

  static TextStyle get chatListTime =>
      AetherTypography.chatListTime.copyWith(
        color: AetherColors.textTertiary,
      );

  static TextStyle get chatListTimeUnread =>
      AetherTypography.chatListTime.copyWith(
        color: AetherColors.violet600,
      );

  static TextStyle get link => AetherTypography.bodyMedium.copyWith(
        color: AetherColors.cyan500,
        decoration: TextDecoration.underline,
        decorationColor: AetherColors.cyan500.withOpacity(0.4),
      );

  static TextStyle get typingIndicator =>
      AetherTypography.typingIndicator.copyWith(
        color: AetherColors.textTertiary,
      );
}

// ──────────────────────────────────────────
// SECTION HEADER (в списке чатов)
// ──────────────────────────────────────────

class AetherSectionHeaderStyle {
  static TextStyle get text => AetherTypography.labelSmall.copyWith(
        color: AetherColors.textTertiary,
        letterSpacing: 0.8,
      );
}
