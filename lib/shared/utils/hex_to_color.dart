import 'package:flutter/material.dart';

/// Преобразует HEX-строку в Color.
/// Поддерживает форматы:
/// - "RRGGBB" или "AARRGGBB"
/// - "#RRGGBB" или "#AARRGGBB"
Color hexToColor(String hex) {
  // Убираем пробелы и переводим в верхний регистр
  final cleaned = hex.trim().toUpperCase();

  // Удаляем '#' если есть
  final hexColor = cleaned.startsWith('#') ? cleaned.substring(1) : cleaned;

  // Если длина 6 (RRGGBB) — добавляем непрозрачность (FF)
  final hexWithAlpha = hexColor.length == 6 ? 'FF$hexColor' : hexColor;

  // Парсим как целое по основанию 16
  final intValue = int.parse(hexWithAlpha, radix: 16);

  return Color(intValue);
}