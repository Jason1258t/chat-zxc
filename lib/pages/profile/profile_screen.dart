import 'dart:developer';

import 'package:chat_zxc/entities/user/profile.dart';
import 'package:chat_zxc/feature/auth/auth_controller.dart';
import 'package:chat_zxc/feature/profile/profile_controller.dart';
import 'package:chat_zxc/shared/components/aether_button.dart';
import 'package:chat_zxc/shared/theme/aether.dart';
import 'package:chat_zxc/shared/utils/hex_to_color.dart';
import 'package:chat_zxc/shared/utils/time_ago.dart';
import 'package:chat_zxc/widgets/avatar.dart';
import 'package:chat_zxc/widgets/profile_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    ref.read(profileControllerProvider.notifier).refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AetherSpacing.xl2),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildProfile(profileAsync),
                const SizedBox(height: AetherSpacing.xl),
                AetherButton.outlined(
                  label: "Log out",
                  onPressed: () => ref.read(authRepositoryProvider).signOut(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfile(AsyncValue<UserProfile> profileAsync) {
    return profileAsync.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) {
        log('Error loading profile: $error');
        return const ProfilePlaceholder();
      },
      data: (profile) => ProfileCard(profile: profile),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        Avatar(
          size: 120,
          displayName: profile.displayName,
          color: profile.color != null
              ? hexToColor(profile.color!)
              : AetherColors.violet600,
          avatarUrl: profile.avatarUrl,
        ),
        const SizedBox(height: 12),
        Text(
          profile.displayName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          profileActivityTime(profile.lastSeen),
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        SizedBox(height: AetherSpacing.xl4),
        Row(),
        SizedBox(height: AetherSpacing.xl4),
        ProfileInfoCard(
          phone: profile.phone,
          bio: profile.bio,
          username: profile.username,
          birthday: profile.birthday,
        ),
      ],
    );
  }

  String profileActivityTime(DateTime? lastSeen) {
    if (lastSeen == null) return 'last seen recently';
    if (DateTime.now().difference(lastSeen) < Duration(seconds: 30)) {
      return 'online';
    }
    return timeAgo(lastSeen);
  }
}

class ProfilePlaceholder extends StatelessWidget {
  const ProfilePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
