import 'package:flutter/material.dart';

/// Менеджер диалогов, гарантирующий показ только одного диалога за раз.
class DialogManager {
  static final DialogManager _instance = DialogManager._internal();
  factory DialogManager() => _instance;
  DialogManager._internal();

  bool _isShowing = false;
  BuildContext? _dialogContext;

  /// Показывает модальный диалог, если ни один диалог не открыт.
  ///
  /// Возвращает [Future] с результатом диалога или `null`, если диалог уже показывается.
  Future<T?> showModal<T>(
      BuildContext context,
      Widget dialog, {
        bool barrierDismissible = true,
      }) async {
    // Если диалог уже показывается, просто выходим
    if (_isShowing) {
      return null;
    }

    _isShowing = true;
    _dialogContext = context;

    final result = await showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => dialog,
    );

    // После закрытия диалога (пользователем или программно) сбрасываем флаг
    _isShowing = false;
    _dialogContext = null;

    return result;
  }

  /// Закрывает текущий диалог, если он открыт.
  void hideDialog() {
    if (_isShowing && _dialogContext != null) {
      try {
        Navigator.of(_dialogContext!).pop();
      } catch (_) {
        // Игнорируем ошибки, если диалог уже закрыт или контекст недействителен
      }
    }
  }
}