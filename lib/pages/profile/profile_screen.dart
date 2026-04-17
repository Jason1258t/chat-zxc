import 'package:chat_zxc/feature/auth/auth_controller.dart';
import 'package:chat_zxc/shared/components/aether_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: AetherButton.outlined(
          label: "Log out",
          onPressed: () => ref.read(authRepositoryProvider).signOut(),
        ),
      ),
    );
  }
}
