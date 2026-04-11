import 'package:flutter/material.dart';
import 'package:chat_zxc/shared/theme/aether.dart';

// ─────────────────────────────────────────────────────────────
// AETHER BUTTON — все варианты кнопок дизайн-системы
//
// Использование:
//   AetherButton.elevated(label: 'Send', onPressed: () {})
//   AetherButton.outlined(label: 'Cancel', onPressed: () {})
//   AetherButton.ghost(label: 'Skip', onPressed: () {})
//   AetherButton.elevated(label: 'Delete', variant: AetherButtonVariant.danger, ...)
// ─────────────────────────────────────────────────────────────

enum AetherButtonVariant { primary, cyan, danger, neutral }

enum AetherButtonSize { small, medium, large }

enum _ButtonStyle { elevated, outlined, ghost }

class AetherButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final AetherButtonVariant variant;
  final AetherButtonSize size;
  final Widget? leading;
  final Widget? trailing;
  final bool fullWidth;
  final bool pill;
  final _ButtonStyle _style;

  const AetherButton._({
    required this.label,
    required _ButtonStyle style,
    this.onPressed,
    this.variant = AetherButtonVariant.primary,
    this.size = AetherButtonSize.medium,
    this.leading,
    this.trailing,
    this.fullWidth = false,
    this.pill = false,
  }) : _style = style;

  factory AetherButton.elevated({
    required String label,
    VoidCallback? onPressed,
    AetherButtonVariant variant = AetherButtonVariant.primary,
    AetherButtonSize size = AetherButtonSize.medium,
    Widget? leading,
    Widget? trailing,
    bool fullWidth = false,
    bool pill = false,
  }) => AetherButton._(
    label: label,
    style: _ButtonStyle.elevated,
    onPressed: onPressed,
    variant: variant,
    size: size,
    leading: leading,
    trailing: trailing,
    fullWidth: fullWidth,
    pill: pill,
  );

  factory AetherButton.outlined({
    required String label,
    VoidCallback? onPressed,
    AetherButtonVariant variant = AetherButtonVariant.primary,
    AetherButtonSize size = AetherButtonSize.medium,
    Widget? leading,
    Widget? trailing,
    bool fullWidth = false,
    bool pill = false,
  }) => AetherButton._(
    label: label,
    style: _ButtonStyle.outlined,
    onPressed: onPressed,
    variant: variant,
    size: size,
    leading: leading,
    trailing: trailing,
    fullWidth: fullWidth,
    pill: pill,
  );

  factory AetherButton.ghost({
    required String label,
    VoidCallback? onPressed,
    AetherButtonVariant variant = AetherButtonVariant.primary,
    AetherButtonSize size = AetherButtonSize.medium,
    Widget? leading,
    Widget? trailing,
    bool fullWidth = false,
  }) => AetherButton._(
    label: label,
    style: _ButtonStyle.ghost,
    onPressed: onPressed,
    variant: variant,
    size: size,
    leading: leading,
    trailing: trailing,
    fullWidth: fullWidth,
  );

  @override
  State<AetherButton> createState() => _AetherButtonState();
}

class _AetherButtonState extends State<AetherButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: AetherMotion.fast,
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  bool get _disabled => widget.onPressed == null;

  // ── Размерные параметры ──────────────────
  EdgeInsets get _padding => switch (widget.size) {
    AetherButtonSize.small => const EdgeInsets.symmetric(
      horizontal: AetherSpacing.md,
      vertical: AetherSpacing.xs + 2,
    ),
    AetherButtonSize.medium => const EdgeInsets.symmetric(
      horizontal: AetherSpacing.xl2,
      vertical: AetherSpacing.md - 1,
    ),
    AetherButtonSize.large => const EdgeInsets.symmetric(
      horizontal: AetherSpacing.xl3,
      vertical: AetherSpacing.lg - 2,
    ),
  };

  double get _fontSize => switch (widget.size) {
    AetherButtonSize.small => 13,
    AetherButtonSize.medium => 15,
    AetherButtonSize.large => 16,
  };

  double get _borderRadius => widget.pill ? AetherRadius.full : AetherRadius.lg;

  // ── Цвета по варианту ────────────────────
  Color get _primaryColor => switch (widget.variant) {
    AetherButtonVariant.primary => AetherColors.violet500,
    AetherButtonVariant.cyan => AetherColors.cyan500,
    AetherButtonVariant.danger => AetherColors.rose500,
    AetherButtonVariant.neutral => AetherColors.void300,
  };

  Color get _labelColorElevated => switch (widget.variant) {
    AetherButtonVariant.cyan => AetherColors.void0,
    AetherButtonVariant.neutral => AetherColors.textSecondary,
    _ => Colors.white,
  };

  Color get _labelColorOutlined => switch (widget.variant) {
    AetherButtonVariant.primary => AetherColors.violet600,
    AetherButtonVariant.cyan => AetherColors.cyan600,
    AetherButtonVariant.danger => AetherColors.rose600,
    AetherButtonVariant.neutral => AetherColors.textSecondary,
  };

  Color get _borderColorOutlined => switch (widget.variant) {
    AetherButtonVariant.primary => AetherColors.violet400,
    AetherButtonVariant.cyan => AetherColors.cyan400,
    AetherButtonVariant.danger => AetherColors.rose400,
    AetherButtonVariant.neutral => AetherColors.void400,
  };

  Color get _bgOutlined => switch (widget.variant) {
    AetherButtonVariant.primary => AetherColors.violet200,
    AetherButtonVariant.cyan => AetherColors.cyan200,
    AetherButtonVariant.danger => AetherColors.rose300,
    AetherButtonVariant.neutral => AetherColors.void300,
  };

  Color get _labelColorGhost => switch (widget.variant) {
    AetherButtonVariant.primary => AetherColors.violet600,
    AetherButtonVariant.cyan => AetherColors.cyan600,
    AetherButtonVariant.danger => AetherColors.rose600,
    AetherButtonVariant.neutral => AetherColors.textSecondary,
  };

  Color get _bgGhost => switch (widget.variant) {
    AetherButtonVariant.primary => AetherColors.violet500.withOpacity(0.08),
    AetherButtonVariant.cyan => AetherColors.cyan500.withOpacity(0.08),
    AetherButtonVariant.danger => AetherColors.rose500.withOpacity(0.08),
    AetherButtonVariant.neutral => AetherColors.void300,
  };

  // ── Сборка декорации ─────────────────────
  BoxDecoration _buildDecoration(bool pressed) {
    final radius = BorderRadius.circular(_borderRadius);
    switch (widget._style) {
      case _ButtonStyle.elevated:
        return BoxDecoration(
          color: pressed
              ? Color.lerp(_primaryColor, Colors.white, 0.08)
              : _primaryColor,
          borderRadius: radius,
          boxShadow: _disabled
              ? null
              : switch (widget.variant) {
                  AetherButtonVariant.primary => AetherShadows.glowViolet,
                  AetherButtonVariant.danger => AetherShadows.glowRose,
                  _ => null,
                },
        );
      case _ButtonStyle.outlined:
        return BoxDecoration(
          color: pressed ? _bgOutlined : Colors.transparent,
          borderRadius: radius,
          border: Border.all(color: _borderColorOutlined, width: 1),
        );
      case _ButtonStyle.ghost:
        return BoxDecoration(
          color: pressed ? _bgGhost : Colors.transparent,
          borderRadius: radius,
        );
    }
  }

  TextStyle get _textStyle =>
      AetherTypography.labelLarge.copyWith(fontSize: _fontSize);

  Color _labelColor(bool pressed) => switch (widget._style) {
    _ButtonStyle.elevated => _labelColorElevated,
    _ButtonStyle.outlined => _labelColorOutlined,
    _ButtonStyle.ghost => _labelColorGhost,
  }.withOpacity(_disabled ? AetherOpacity.disabled : 1.0);

  @override
  Widget build(BuildContext context) {
    final btn = GestureDetector(
      onTapDown: _disabled ? null : (_) => _ctrl.forward(),
      onTapUp: _disabled
          ? null
          : (_) {
              _ctrl.reverse();
              widget.onPressed?.call();
            },
      onTapCancel: _disabled ? null : () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: AnimatedBuilder(
          animation: _ctrl,
          builder: (_, __) {
            final pressed = _ctrl.value > 0;
            return AnimatedContainer(
              duration: AetherMotion.fast,
              padding: _padding,
              decoration: _buildDecoration(pressed),
              child: Row(
                mainAxisSize: widget.fullWidth
                    ? MainAxisSize.max
                    : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.leading != null) ...[
                    widget.leading!,
                    SizedBox(width: AetherSpacing.sm),
                  ],
                  Text(
                    widget.label,
                    style: _textStyle.copyWith(color: _labelColor(pressed)),
                  ),
                  if (widget.trailing != null) ...[
                    SizedBox(width: AetherSpacing.sm),
                    widget.trailing!,
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );

    return widget.fullWidth
        ? SizedBox(width: double.infinity, child: btn)
        : btn;
  }
}

// ─────────────────────────────────────────────────────────────
// AETHER ICON BUTTON
// ─────────────────────────────────────────────────────────────

enum AetherIconButtonVariant { neutral, accent }

class AetherIconButton extends StatefulWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final AetherIconButtonVariant variant;
  final double size;

  const AetherIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.variant = AetherIconButtonVariant.neutral,
    this.size = AetherSpacing.avatarSize,
  });

  @override
  State<AetherIconButton> createState() => _AetherIconButtonState();
}

class _AetherIconButtonState extends State<AetherIconButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: AetherMotion.fast);
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.90,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  BoxDecoration get _decoration =>
      widget.variant == AetherIconButtonVariant.accent
      ? BoxDecoration(
          color: AetherColors.violet200,
          borderRadius: BorderRadius.circular(AetherRadius.md),
          border: Border.all(color: AetherColors.violet400, width: 1),
        )
      : BoxDecoration(
          color: AetherColors.void300,
          borderRadius: BorderRadius.circular(AetherRadius.md),
          border: Border.all(color: AetherColors.void400, width: 0.5),
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onPressed?.call();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: _decoration,
          child: Center(child: widget.icon),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// AETHER FAB
// ─────────────────────────────────────────────────────────────

class AetherFAB extends StatefulWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final double size;

  const AetherFAB({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 52,
  });

  @override
  State<AetherFAB> createState() => _AetherFABState();
}

class _AetherFABState extends State<AetherFAB>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: AetherMotion.fast);
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.92,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onPressed?.call();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            gradient: AetherColors.gradientPrimary,
            shape: BoxShape.circle,
            boxShadow: AetherShadows.glowViolet,
          ),
          child: Center(child: widget.icon),
        ),
      ),
    );
  }
}
