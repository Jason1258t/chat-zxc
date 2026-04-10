import 'package:flutter/material.dart';

import 'package:chat_zxc/shared/theme/aether.dart';

// ─────────────────────────────────────────────────────────────
// AETHER BADGE
//
// Использование:
//   AetherBadge(label: 'Online', variant: AetherBadgeVariant.cyan)
//   AetherBadge.count(count: 5)
// ─────────────────────────────────────────────────────────────

enum AetherBadgeVariant { violet, cyan, rose, success, warning, neutral }

class AetherBadge extends StatelessWidget {
  final String? label;
  final int? count;
  final AetherBadgeVariant variant;
  final bool showDot;

  const AetherBadge({
    super.key,
    this.label,
    this.count,
    this.variant = AetherBadgeVariant.violet,
    this.showDot = true,
  }) : assert(label != null || count != null,
            'Provide either label or count');

  factory AetherBadge.count({
    Key? key,
    required int count,
    AetherBadgeVariant variant = AetherBadgeVariant.violet,
  }) =>
      AetherBadge(
        key: key,
        count: count,
        variant: variant,
        showDot: false,
      );

  _BadgeColors get _colors => switch (variant) {
        AetherBadgeVariant.violet => _BadgeColors(
            bg: AetherColors.violet200,
            border: AetherColors.violet400,
            text: AetherColors.violet700,
            dot: AetherColors.violet500,
            shadows: AetherShadows.glowViolet,
          ),
        AetherBadgeVariant.cyan => _BadgeColors(
            bg: AetherColors.cyan100,
            border: AetherColors.cyan400,
            text: AetherColors.cyan600,
            dot: AetherColors.cyan500,
          ),
        AetherBadgeVariant.rose => _BadgeColors(
            bg: AetherColors.rose300,
            border: AetherColors.rose500,
            text: AetherColors.rose600,
            dot: AetherColors.rose500,
            shadows: AetherShadows.glowRose,
          ),
        AetherBadgeVariant.success => _BadgeColors(
            bg: AetherColors.successSubtle,
            border: AetherColors.success,
            text: const Color(0xFF34D399),
            dot: AetherColors.success,
          ),
        AetherBadgeVariant.warning => _BadgeColors(
            bg: AetherColors.warningSubtle,
            border: AetherColors.warning,
            text: AetherColors.warning,
            dot: AetherColors.warning,
          ),
        AetherBadgeVariant.neutral => _BadgeColors(
            bg: AetherColors.void300,
            border: AetherColors.void400,
            text: AetherColors.textSecondary,
            dot: AetherColors.void500,
          ),
      };

  @override
  Widget build(BuildContext context) {
    final c = _colors;
    final displayText = count != null
        ? count! > 99 ? '99+' : count.toString()
        : label!;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AetherSpacing.sm + 1,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: c.bg,
        borderRadius: BorderRadius.circular(AetherRadius.full),
        border: Border.all(color: c.border, width: 0.5),
        boxShadow: c.shadows,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot && label != null) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: c.dot,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AetherSpacing.xs),
          ],
          Text(
            displayText,
            style: AetherTypography.labelSmall.copyWith(color: c.text),
          ),
        ],
      ),
    );
  }
}

class _BadgeColors {
  final Color bg, border, text, dot;
  final List<BoxShadow>? shadows;
  const _BadgeColors({
    required this.bg,
    required this.border,
    required this.text,
    required this.dot,
    this.shadows,
  });
}

// ─────────────────────────────────────────────────────────────
// AETHER CHIP — фильтры, теги
//
// Использование:
//   AetherChip(label: 'Design', selected: true, onTap: () {})
//   AetherChip(label: 'AI', onRemove: () {})
// ─────────────────────────────────────────────────────────────

class AetherChip extends StatefulWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;
  final Widget? leading;

  const AetherChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.onRemove,
    this.leading,
  });

  @override
  State<AetherChip> createState() => _AetherChipState();
}

class _AetherChipState extends State<AetherChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: AetherMotion.fast);
    _scale = Tween<double>(begin: 1.0, end: 0.95)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  BoxDecoration get _decoration => widget.selected
      ? BoxDecoration(
          color: AetherColors.violet200,
          borderRadius: BorderRadius.circular(AetherRadius.full),
          border: Border.all(color: AetherColors.violet400, width: 1),
        )
      : BoxDecoration(
          color: AetherColors.void300,
          borderRadius: BorderRadius.circular(AetherRadius.full),
          border: Border.all(color: AetherColors.void400, width: 0.5),
        );

  Color get _labelColor =>
      widget.selected ? AetherColors.violet700 : AetherColors.textSecondary;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: AnimatedContainer(
          duration: AetherMotion.fast,
          padding: const EdgeInsets.symmetric(
            horizontal: AetherSpacing.md,
            vertical: AetherSpacing.xs + 1,
          ),
          decoration: _decoration,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.leading != null) ...[
                widget.leading!,
                const SizedBox(width: AetherSpacing.xs),
              ],
              Text(
                widget.label,
                style: AetherTypography.labelMedium.copyWith(
                  color: _labelColor,
                ),
              ),
              if (widget.onRemove != null) ...[
                const SizedBox(width: AetherSpacing.xs),
                GestureDetector(
                  onTap: widget.onRemove,
                  child: Icon(
                    Icons.close_rounded,
                    size: AetherIconSize.xs,
                    color: AetherColors.textTertiary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// AETHER TOGGLE (Switch)
//
// Использование:
//   AetherToggle(
//     label: 'Notifications',
//     subtitle: 'Push alerts for new messages',
//     value: _enabled,
//     onChanged: (v) => setState(() => _enabled = v),
//   )
// ─────────────────────────────────────────────────────────────

class AetherToggle extends StatelessWidget {
  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;

  const AetherToggle({
    super.key,
    required this.label,
    this.subtitle,
    required this.value,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : AetherOpacity.disabled,
      child: GestureDetector(
        onTap: enabled ? () => onChanged?.call(!value) : null,
        behavior: HitTestBehavior.opaque,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AetherTypography.bodyMedium.copyWith(
                      color: AetherColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: AetherTypography.bodySmall.copyWith(
                        color: AetherColors.textTertiary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: AetherSpacing.lg),
            _AetherToggleTrack(value: value, enabled: enabled),
          ],
        ),
      ),
    );
  }
}

class _AetherToggleTrack extends StatelessWidget {
  final bool value;
  final bool enabled;

  const _AetherToggleTrack({required this.value, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AetherMotion.normal,
      curve: AetherMotion.standard,
      width: 44,
      height: 26,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AetherRadius.full),
        color: value ? AetherColors.violet500 : AetherColors.void400,
      ),
      child: AnimatedAlign(
        duration: AetherMotion.normal,
        curve: AetherMotion.standard,
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 20,
          height: 20,
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: value ? Colors.white : AetherColors.textTertiary,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// AETHER TOGGLE LIST TILE — удобная обёртка для настроек
// ─────────────────────────────────────────────────────────────

class AetherToggleTile extends StatelessWidget {
  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget? leading;
  final bool enabled;

  const AetherToggleTile({
    super.key,
    required this.label,
    this.subtitle,
    required this.value,
    this.onChanged,
    this.leading,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AetherSpacing.lg,
        vertical: AetherSpacing.md,
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: AetherSpacing.md),
          ],
          Expanded(
            child: AetherToggle(
              label: label,
              subtitle: subtitle,
              value: value,
              onChanged: onChanged,
              enabled: enabled,
            ),
          ),
        ],
      ),
    );
  }
}
