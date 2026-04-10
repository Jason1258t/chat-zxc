import 'package:flutter/material.dart';
import 'package:chat_zxc/shared/theme/aether.dart';
import 'components.dart';

/// Экран-витрина всех компонентов Aether.
/// Подключи его в роутер для просмотра в приложении.
///
/// ```dart
/// routes: {
///   '/kit': (_) => const ComponentKitScreen(),
/// }
/// ```

class ComponentKitScreen extends StatefulWidget {
  const ComponentKitScreen({super.key});

  @override
  State<ComponentKitScreen> createState() => _ComponentKitScreenState();
}

class _ComponentKitScreenState extends State<ComponentKitScreen> {
  // Toggle states
  bool _notif = true;
  bool _darkMode = true;
  bool _receipts = false;

  // Chip states
  final Set<String> _selected = {'Design'};

  // Field values
  final _searchCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController(text: 'aether_user');
  final _emailCtrl = TextEditingController(text: 'user@aether.io');
  final _bioCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AetherColors.void0,
      appBar: AppBar(
        title: Text(
          'Component Kit',
          style: AetherTypography.displaySmall.copyWith(
            color: AetherColors.textPrimary,
          ),
        ),
        backgroundColor: AetherColors.void0,
        surfaceTintColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(height: 0.5, color: AetherColors.void400),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AetherSpacing.xl2),
        children: [
          _Section(title: 'Elevated Buttons', children: [
            Wrap(
              spacing: AetherSpacing.sm,
              runSpacing: AetherSpacing.sm,
              children: [
                AetherButton.elevated(
                    label: 'Send message',
                    onPressed: () {}),
                AetherButton.elevated(
                    label: 'Follow',
                    variant: AetherButtonVariant.cyan,
                    onPressed: () {}),
                AetherButton.elevated(
                    label: 'Delete',
                    variant: AetherButtonVariant.danger,
                    onPressed: () {}),
                AetherButton.elevated(
                    label: 'Disabled',
                    onPressed: null),
              ],
            ),
            const SizedBox(height: AetherSpacing.sm),
            Wrap(
              spacing: AetherSpacing.sm,
              children: [
                AetherButton.elevated(
                    label: 'Reply',
                    size: AetherButtonSize.small,
                    onPressed: () {}),
                AetherButton.elevated(
                    label: 'New chat',
                    pill: true,
                    onPressed: () {}),
              ],
            ),
            const SizedBox(height: AetherSpacing.sm),
            AetherButton.elevated(
                label: 'Create group',
                fullWidth: true,
                onPressed: () {}),
          ]),

          _Section(title: 'Outlined & Ghost', children: [
            Wrap(
              spacing: AetherSpacing.sm,
              runSpacing: AetherSpacing.sm,
              children: [
                AetherButton.outlined(
                    label: 'Edit profile', onPressed: () {}),
                AetherButton.outlined(
                    label: 'Cancel',
                    variant: AetherButtonVariant.neutral,
                    onPressed: () {}),
                AetherButton.ghost(
                    label: 'Learn more', onPressed: () {}),
                AetherButton.ghost(
                    label: 'Skip',
                    variant: AetherButtonVariant.neutral,
                    onPressed: () {}),
              ],
            ),
          ]),

          _Section(title: 'Icon Buttons & FAB', children: [
            Row(
              children: [
                AetherIconButton(
                  icon: const Icon(Icons.menu_rounded),
                  onPressed: () {},
                ),
                const SizedBox(width: AetherSpacing.sm),
                AetherIconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () {},
                ),
                const SizedBox(width: AetherSpacing.sm),
                AetherIconButton(
                  icon: const Icon(Icons.attach_file_rounded),
                  onPressed: () {},
                ),
                const SizedBox(width: AetherSpacing.sm),
                AetherIconButton(
                  icon: const Icon(Icons.more_horiz_rounded),
                  onPressed: () {},
                ),
                const SizedBox(width: AetherSpacing.sm),
                AetherIconButton(
                  icon: const Icon(Icons.auto_awesome_rounded,
                      color: AetherColors.violet600),
                  variant: AetherIconButtonVariant.accent,
                  onPressed: () {},
                ),
                const SizedBox(width: AetherSpacing.sm),
                AetherFAB(
                  icon: const Icon(Icons.edit_rounded, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ]),

          _Section(title: 'Badges', children: [
            Wrap(
              spacing: AetherSpacing.sm,
              runSpacing: AetherSpacing.sm,
              children: const [
                AetherBadge(
                    label: 'Active', variant: AetherBadgeVariant.violet),
                AetherBadge(
                    label: 'Online', variant: AetherBadgeVariant.cyan),
                AetherBadge(
                    label: 'Muted', variant: AetherBadgeVariant.rose),
                AetherBadge(
                    label: 'Delivered',
                    variant: AetherBadgeVariant.success),
                AetherBadge(
                    label: 'Pending',
                    variant: AetherBadgeVariant.warning),
              ],
            ),
            const SizedBox(height: AetherSpacing.sm),
            Row(
              children: [
                AetherBadge.count(count: 5),
                const SizedBox(width: AetherSpacing.sm),
                AetherBadge.count(
                    count: 99, variant: AetherBadgeVariant.rose),
                const SizedBox(width: AetherSpacing.sm),
                AetherBadge.count(
                    count: 200, variant: AetherBadgeVariant.cyan),
              ],
            ),
          ]),

          _Section(title: 'Filter Chips', children: [
            Wrap(
              spacing: AetherSpacing.sm,
              runSpacing: AetherSpacing.sm,
              children: ['Design', 'Development', 'AI', 'Flutter', 'Figma']
                  .map((tag) => AetherChip(
                        label: tag,
                        selected: _selected.contains(tag),
                        onTap: () => setState(() {
                          if (_selected.contains(tag)) {
                            _selected.remove(tag);
                          } else {
                            _selected.add(tag);
                          }
                        }),
                      ))
                  .toList(),
            ),
            const SizedBox(height: AetherSpacing.sm),
            Wrap(
              spacing: AetherSpacing.sm,
              children: ['dart', 'flutter', 'aether']
                  .map((tag) => AetherChip(
                        label: tag,
                        selected: false,
                        onRemove: () {},
                      ))
                  .toList(),
            ),
          ]),

          _Section(title: 'Text Inputs', children: [
            AetherTextField(
              label: 'Username',
              hint: '@handle',
            ),
            const SizedBox(height: AetherSpacing.md),
            AetherTextField.search(
              hint: 'Search chats...',
              controller: _searchCtrl,
            ),
            const SizedBox(height: AetherSpacing.md),
            AetherTextField(
              label: 'With clear button',
              controller: _usernameCtrl,
              trailing: const Icon(
                Icons.close_rounded,
                size: AetherIconSize.sm,
                color: AetherColors.textTertiary,
              ),
              onTrailingTap: () => _usernameCtrl.clear(),
              helperText: 'Username is available',
              status: AetherInputStatus.success,
            ),
            const SizedBox(height: AetherSpacing.md),
            const AetherTextField(
              label: 'Error state',
              hint: 'user@example.com',
              errorText: 'Invalid email format',
              status: AetherInputStatus.error,
            ),
            const SizedBox(height: AetherSpacing.md),
            AetherTextField(
              label: 'Success state',
              controller: _emailCtrl,
              status: AetherInputStatus.success,
              successText: 'Email confirmed',
            ),
            const SizedBox(height: AetherSpacing.md),
            const AetherTextField(
              label: 'Disabled',
              hint: 'cannot.edit',
              enabled: false,
            ),
            const SizedBox(height: AetherSpacing.md),
            AetherTextField.search(
              hint: 'Ask AI anything...',
            ),
          ]),

          _Section(title: 'Password', children: [
            AetherTextField.password(
              label: 'Password',
              helperText: 'Minimum 8 characters',
            ),
          ]),

          _Section(title: 'Textarea', children: [
            AetherTextarea(
              label: 'Bio',
              hint: 'Write something about yourself...',
              controller: _bioCtrl,
              helperText: 'Max 160 characters',
              maxLength: 160,
              showCounter: true,
            ),
          ]),

          _Section(title: 'Toggles', children: [
            AetherToggle(
              label: 'Notifications',
              subtitle: 'Push alerts for new messages',
              value: _notif,
              onChanged: (v) => setState(() => _notif = v),
            ),
            const SizedBox(height: AetherSpacing.lg),
            Container(
              height: 0.5,
              color: AetherColors.void400,
            ),
            const SizedBox(height: AetherSpacing.lg),
            AetherToggle(
              label: 'Dark mode',
              subtitle: 'Always on in Aether',
              value: _darkMode,
              onChanged: (v) => setState(() => _darkMode = v),
            ),
            const SizedBox(height: AetherSpacing.lg),
            Container(
              height: 0.5,
              color: AetherColors.void400,
            ),
            const SizedBox(height: AetherSpacing.lg),
            AetherToggle(
              label: 'Read receipts',
              subtitle: 'Show when you\'ve read messages',
              value: _receipts,
              onChanged: (v) => setState(() => _receipts = v),
            ),
            const SizedBox(height: AetherSpacing.lg),
            Container(
              height: 0.5,
              color: AetherColors.void400,
            ),
            const SizedBox(height: AetherSpacing.lg),
            AetherToggle(
              label: 'Sync contacts',
              subtitle: 'This setting is disabled',
              value: false,
              enabled: false,
            ),
          ]),

          const SizedBox(height: AetherSpacing.xl5),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Вспомогательный виджет секции
// ─────────────────────────────────────────────────────────────

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AetherSpacing.lg,
        right: AetherSpacing.lg,
        bottom: AetherSpacing.xl3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: AetherTypography.labelSmall.copyWith(
              color: AetherColors.textTertiary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AetherSpacing.md),
          ...children,
        ],
      ),
    );
  }
}
