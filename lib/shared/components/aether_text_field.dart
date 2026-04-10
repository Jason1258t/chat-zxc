import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chat_zxc/shared/theme/aether.dart';

// ─────────────────────────────────────────────────────────────
// AETHER TEXT FIELD
//
// Использование:
//   AetherTextField(
//     label: 'Username',
//     hint: '@handle',
//     onChanged: (v) {},
//   )
//
//   AetherTextField.search(hint: 'Search chats...')
//   AetherTextField.password(label: 'Password')
// ─────────────────────────────────────────────────────────────

enum AetherInputStatus { normal, error, success }
enum _TextFieldFlavor { standard, search, password }

class AetherTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final String? successText;
  final AetherInputStatus status;

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;

  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTrailingTap;

  final bool readOnly;
  final bool enabled;
  final bool pill;
  final bool autofocus;

  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxLines;

  final _TextFieldFlavor _flavor;

  const AetherTextField({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.successText,
    this.status = AetherInputStatus.normal,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.leading,
    this.trailing,
    this.onTrailingTap,
    this.readOnly = false,
    this.enabled = true,
    this.pill = false,
    this.autofocus = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.inputFormatters,
    this.maxLength,
    this.maxLines = 1,
  }) : _flavor = _TextFieldFlavor.standard;

  const AetherTextField._({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.successText,
    this.status = AetherInputStatus.normal,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.leading,
    this.trailing,
    this.onTrailingTap,
    this.readOnly = false,
    this.enabled = true,
    this.pill = false,
    this.autofocus = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.inputFormatters,
    this.maxLength,
    this.maxLines = 1,
    required _TextFieldFlavor flavor,
  }) : _flavor = flavor;

  /// Поле поиска с иконкой лупы
  factory AetherTextField.search({
    Key? key,
    String hint = 'Search...',
    TextEditingController? controller,
    FocusNode? focusNode,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    bool autofocus = false,
    Widget? trailing,
    VoidCallback? onTrailingTap,
  }) =>
      AetherTextField._(
        key: key,
        hint: hint,
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        autofocus: autofocus,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        trailing: trailing,
        onTrailingTap: onTrailingTap,
        flavor: _TextFieldFlavor.search,
        pill: true,
      );

  /// Поле пароля с кнопкой показать/скрыть
  factory AetherTextField.password({
    Key? key,
    String? label,
    String hint = '••••••••',
    String? helperText,
    String? errorText,
    AetherInputStatus status = AetherInputStatus.normal,
    TextEditingController? controller,
    FocusNode? focusNode,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
  }) =>
      AetherTextField._(
        key: key,
        label: label,
        hint: hint,
        helperText: helperText,
        errorText: errorText,
        status: status,
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: TextInputAction.done,
        flavor: _TextFieldFlavor.password,
      );

  @override
  State<AetherTextField> createState() => _AetherTextFieldState();
}

class _AetherTextFieldState extends State<AetherTextField> {
  late FocusNode _focus;
  late TextEditingController _ctrl;
  bool _focused = false;
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _focus = widget.focusNode ?? FocusNode();
    _ctrl = widget.controller ?? TextEditingController();
    _focus.addListener(() {
      setState(() => _focused = _focus.hasFocus);
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) _focus.dispose();
    if (widget.controller == null) _ctrl.dispose();
    super.dispose();
  }

  // ── Эффективный статус ───────────────────
  AetherInputStatus get _status {
    if (widget.errorText != null) return AetherInputStatus.error;
    return widget.status;
  }

  Color get _borderColor {
    if (!widget.enabled) return AetherColors.void400;
    if (_status == AetherInputStatus.error) return AetherColors.rose500;
    if (_status == AetherInputStatus.success) return AetherColors.success;
    if (_focused) return AetherColors.violet500;
    return AetherColors.void400;
  }

  double get _borderWidth {
    if (_focused || _status != AetherInputStatus.normal) return 1.5;
    return 1.0;
  }

  Color get _fillColor {
    if (_status == AetherInputStatus.error) {
      return AetherColors.errorSubtle.withOpacity(0.05);
    }
    if (_status == AetherInputStatus.success) {
      return AetherColors.successSubtle.withOpacity(0.08);
    }
    return AetherColors.void200;
  }

  double get _radius =>
      widget.pill ? AetherRadius.full : AetherRadius.md;

  // ── Ведущая иконка (для search) ──────────
  Widget? get _leadingWidget {
    if (widget._flavor == _TextFieldFlavor.search) {
      return Icon(
        Icons.search_rounded,
        size: AetherIconSize.md,
        color: AetherColors.textTertiary,
      );
    }
    return widget.leading;
  }

  // ── Завершающая иконка ───────────────────
  Widget? _buildTrailing() {
    if (widget._flavor == _TextFieldFlavor.password) {
      return GestureDetector(
        onTap: () => setState(() => _obscure = !_obscure),
        child: Icon(
          _obscure
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          size: AetherIconSize.md,
          color: AetherColors.textTertiary,
        ),
      );
    }
    if (_status == AetherInputStatus.success) {
      return Icon(
        Icons.check_circle_outline_rounded,
        size: AetherIconSize.md,
        color: AetherColors.success,
      );
    }
    if (_status == AetherInputStatus.error) {
      return Icon(
        Icons.error_outline_rounded,
        size: AetherIconSize.md,
        color: AetherColors.rose500,
      );
    }
    if (widget.trailing != null) {
      return GestureDetector(
        onTap: widget.onTrailingTap,
        child: widget.trailing,
      );
    }
    return null;
  }

  // ── Helper-строка под полем ──────────────
  Widget? _buildHelper() {
    final text = widget.errorText ?? widget.successText ?? widget.helperText;
    if (text == null) return null;
    final color = switch (_status) {
      AetherInputStatus.error => AetherColors.rose500,
      AetherInputStatus.success => AetherColors.success,
      _ => AetherColors.textTertiary,
    };
    return Padding(
      padding: const EdgeInsets.only(top: AetherSpacing.xs, left: 2),
      child: Text(
        text,
        style: AetherTypography.bodySmall.copyWith(color: color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final trailing = _buildTrailing();

    final field = AnimatedContainer(
      duration: AetherMotion.fast,
      decoration: BoxDecoration(
        color: widget.enabled ? _fillColor : AetherColors.void200,
        borderRadius: BorderRadius.circular(_radius),
        border: Border.all(color: _borderColor, width: _borderWidth),
      ),
      child: TextField(
        controller: _ctrl,
        focusNode: _focus,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
        onSubmitted: widget.onSubmitted,
        readOnly: widget.readOnly,
        enabled: widget.enabled,
        autofocus: widget.autofocus,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        inputFormatters: widget.inputFormatters,
        maxLength: widget.maxLength,
        maxLines: widget._flavor == _TextFieldFlavor.password ? 1 : widget.maxLines,
        obscureText:
            widget._flavor == _TextFieldFlavor.password ? _obscure : false,
        style: AetherTypography.bodyLarge.copyWith(
          color: widget.enabled
              ? AetherColors.textPrimary
              : AetherColors.textTertiary,
        ),
        cursorColor: AetherColors.violet500,
        cursorWidth: 1.5,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: AetherTypography.bodyLarge.copyWith(
            color: AetherColors.textTertiary,
          ),
          prefixIcon: _leadingWidget != null
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: AetherSpacing.md, right: AetherSpacing.sm),
                  child: _leadingWidget,
                )
              : null,
          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: trailing != null
              ? Padding(
                  padding: const EdgeInsets.only(right: AetherSpacing.md),
                  child: trailing,
                )
              : null,
          suffixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          filled: false,
          counterText: '',
          contentPadding: EdgeInsets.symmetric(
            horizontal: AetherSpacing.lg,
            vertical: widget.maxLines != null && widget.maxLines! > 1
                ? AetherSpacing.md
                : AetherSpacing.md - 1,
          ),
        ),
      ),
    );

    return Opacity(
      opacity: widget.enabled ? 1.0 : AetherOpacity.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null) ...[
            Text(
              widget.label!,
              style: AetherTypography.labelMedium.copyWith(
                color: _focused
                    ? AetherColors.violet500
                    : AetherColors.textSecondary,
              ),
            ),
            const SizedBox(height: AetherSpacing.xs),
          ],
          field,
          if (_buildHelper() != null) _buildHelper()!,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// AETHER TEXTAREA
// ─────────────────────────────────────────────────────────────

class AetherTextarea extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final bool enabled;
  final bool showCounter;

  const AetherTextarea({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.minLines = 3,
    this.maxLines = 8,
    this.maxLength,
    this.enabled = true,
    this.showCounter = false,
  });

  @override
  State<AetherTextarea> createState() => _AetherTextareaState();
}

class _AetherTextareaState extends State<AetherTextarea> {
  late FocusNode _focus;
  late TextEditingController _ctrl;
  bool _focused = false;
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    _focus = widget.focusNode ?? FocusNode();
    _ctrl = widget.controller ?? TextEditingController();
    _focus.addListener(() => setState(() => _focused = _focus.hasFocus));
    _ctrl.addListener(() => setState(() => _charCount = _ctrl.text.length));
  }

  @override
  void dispose() {
    if (widget.focusNode == null) _focus.dispose();
    if (widget.controller == null) _ctrl.dispose();
    super.dispose();
  }

  bool get _hasError => widget.errorText != null;

  Color get _borderColor {
    if (_hasError) return AetherColors.rose500;
    if (_focused) return AetherColors.violet500;
    return AetherColors.void400;
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.enabled ? 1.0 : AetherOpacity.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null) ...[
            Text(
              widget.label!,
              style: AetherTypography.labelMedium.copyWith(
                color: _focused
                    ? AetherColors.violet500
                    : AetherColors.textSecondary,
              ),
            ),
            const SizedBox(height: AetherSpacing.xs),
          ],
          AnimatedContainer(
            duration: AetherMotion.fast,
            decoration: BoxDecoration(
              color: AetherColors.void200,
              borderRadius: BorderRadius.circular(AetherRadius.md),
              border: Border.all(
                color: _borderColor,
                width: _focused || _hasError ? 1.5 : 1.0,
              ),
            ),
            child: TextField(
              controller: _ctrl,
              focusNode: _focus,
              onChanged: widget.onChanged,
              enabled: widget.enabled,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              maxLength: widget.maxLength,
              style: AetherTypography.bodyMedium.copyWith(
                color: AetherColors.textPrimary,
                height: 1.5,
              ),
              cursorColor: AetherColors.violet500,
              cursorWidth: 1.5,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: AetherTypography.bodyMedium.copyWith(
                  color: AetherColors.textTertiary,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
                counterText: '',
                contentPadding: const EdgeInsets.all(AetherSpacing.md),
              ),
            ),
          ),
          if (widget.errorText != null || widget.helperText != null ||
              widget.showCounter)
            Padding(
              padding: const EdgeInsets.only(top: AetherSpacing.xs, left: 2),
              child: Row(
                children: [
                  if (widget.errorText != null)
                    Expanded(
                      child: Text(
                        widget.errorText!,
                        style: AetherTypography.bodySmall
                            .copyWith(color: AetherColors.rose500),
                      ),
                    )
                  else if (widget.helperText != null)
                    Expanded(
                      child: Text(
                        widget.helperText!,
                        style: AetherTypography.bodySmall
                            .copyWith(color: AetherColors.textTertiary),
                      ),
                    )
                  else
                    const Spacer(),
                  if (widget.showCounter && widget.maxLength != null)
                    Text(
                      '$_charCount / ${widget.maxLength}',
                      style: AetherTypography.monoSmall.copyWith(
                        color: _charCount > widget.maxLength!
                            ? AetherColors.rose500
                            : AetherColors.textTertiary,
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
