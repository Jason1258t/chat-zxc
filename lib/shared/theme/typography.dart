import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Aether Design System — Typography
///
/// Шрифтовая система построена на трёх гарнитурах:
///
/// • [Syne] — Display / заголовки. Геометрический, с характером.
///   Идеален для имён контактов крупным планом, названий групп.
///
/// • [Figtree] — UI / тело. Современный гротеск с мягкими
///   скруглениями — читается идеально на тёмном фоне.
///
/// • [Fira Code] — Mono / технические блоки.
///   Timestamps, коды, ссылки, системные строки.

abstract class AetherTypography {
  // ──────────────────────────────────────────
  // FONT FAMILIES (raw)
  // ──────────────────────────────────────────

  static const String fontDisplay = 'Syne';
  static const String fontBody = 'Figtree';
  static const String fontMono = 'Fira Code';

  // ──────────────────────────────────────────
  // DISPLAY — Syne
  // ──────────────────────────────────────────

  /// Имя контакта / группы на экране профиля (крупно)
  static TextStyle get displayLarge => GoogleFonts.syne(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.1,
      );

  /// Заголовок экрана / названия разделов
  static TextStyle get displayMedium => GoogleFonts.syne(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        height: 1.2,
      );

  /// Имя контакта в шапке чата
  static TextStyle get displaySmall => GoogleFonts.syne(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        height: 1.3,
      );

  // ──────────────────────────────────────────
  // HEADLINE — Syne (для заголовков секций)
  // ──────────────────────────────────────────

  static TextStyle get headlineLarge => GoogleFonts.syne(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        height: 1.25,
      );

  static TextStyle get headlineMedium => GoogleFonts.syne(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.1,
        height: 1.3,
      );

  static TextStyle get headlineSmall => GoogleFonts.syne(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
        height: 1.35,
      );

  // ──────────────────────────────────────────
  // BODY — Figtree (основной UI-текст)
  // ──────────────────────────────────────────

  static TextStyle get figtree => GoogleFonts.figtree();

  /// Текст сообщений (основной)
  static TextStyle get bodyLarge => GoogleFonts.figtree(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        height: 1.5,
      );

  /// Превью сообщения в списке чатов
  static TextStyle get bodyMedium => GoogleFonts.figtree(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        height: 1.45,
      );

  /// Вспомогательные подписи, описания
  static TextStyle get bodySmall => GoogleFonts.figtree(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
        height: 1.4,
      );

  // ──────────────────────────────────────────
  // LABEL / UI — Figtree (кнопки, теги, навигация)
  // ──────────────────────────────────────────

  /// Кнопки, primary action labels
  static TextStyle get labelLarge => GoogleFonts.figtree(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.2,
      );

  /// Tab-bar, secondary labels
  static TextStyle get labelMedium => GoogleFonts.figtree(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        height: 1.2,
      );

  /// Badge, chip, мелкие метки
  static TextStyle get labelSmall => GoogleFonts.figtree(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
        height: 1.2,
      );

  // ──────────────────────────────────────────
  // MONO — Fira Code (timestamp, ссылки, коды)
  // ──────────────────────────────────────────

  /// Timestamp сообщений
  static TextStyle get monoSmall => GoogleFonts.firaCode(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        height: 1.0,
        fontFeatures: const [FontFeature.enable('calt')],
      );

  /// Ссылки в сообщениях
  static TextStyle get monoMedium => GoogleFonts.firaCode(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        height: 1.4,
        fontFeatures: const [FontFeature.enable('calt')],
      );

  /// Блоки кода, технические строки
  static TextStyle get monodisplay => GoogleFonts.firaCode(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.3,
        height: 1.6,
        fontFeatures: const [
          FontFeature.enable('calt'),
          FontFeature.enable('liga'),
        ],
      );

  // ──────────────────────────────────────────
  // CHAT-SPECIFIC COMPOSITIONS
  // ──────────────────────────────────────────

  /// Имя отправителя в групповом чате (над пузырём)
  static TextStyle get senderName => GoogleFonts.figtree(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
        height: 1.3,
      );

  /// Текст самого сообщения
  static TextStyle get messageText => GoogleFonts.figtree(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        height: 1.5,
      );

  /// Пересланное сообщение (forward) — немного меньше
  static TextStyle get forwardedText => GoogleFonts.figtree(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        height: 1.45,
        fontStyle: FontStyle.italic,
      );

  /// Время сообщения
  static TextStyle get timestamp => GoogleFonts.firaCode(
        fontSize: 10.5,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        height: 1.0,
      );

  /// Статус "печатает..."
  static TextStyle get typingIndicator => GoogleFonts.figtree(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        height: 1.0,
        fontStyle: FontStyle.italic,
      );

  /// Имя в списке чатов (жирное)
  static TextStyle get chatListName => GoogleFonts.figtree(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.1,
        height: 1.2,
      );

  /// Превью в списке чатов
  static TextStyle get chatListPreview => GoogleFonts.figtree(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        height: 1.3,
      );

  /// Время в списке чатов (правый угол)
  static TextStyle get chatListTime => GoogleFonts.firaCode(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        height: 1.0,
      );

  // Внутри abstract class AetherTypography
  static TextStyle get avatarInitials => GoogleFonts.figtree(
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    height: 1.0,
  );

  // ──────────────────────────────────────────
  // THEME TEXT THEME (для MaterialApp)
  // ──────────────────────────────────────────

  static TextTheme get textTheme => TextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: displaySmall,
        headlineLarge: headlineLarge,
        headlineMedium: headlineMedium,
        headlineSmall: headlineSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: labelLarge,
        labelMedium: labelMedium,
        labelSmall: labelSmall,
      );
}
