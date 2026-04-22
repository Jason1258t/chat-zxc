import 'package:chat_zxc/shared/theme/aether.dart';
import 'package:chat_zxc/shared/utils/birthday_date.dart';
import 'package:flutter/material.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({
    super.key,
    required this.phone,
    required this.bio,
    required this.username,
    required this.birthday,
  });

  final String? phone;
  final String? bio;
  final String username;
  final DateTime? birthday;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AetherGlassStyle.medium,
      child: Column(
        children: [
          _ProfileInfoCardItem(
            value: phone == null ? 'hidden' : phone!,
            label: 'Mobile',
          ),
          if (bio != null) ...[_ProfileInfoCardItem(value: bio!, label: 'Bio')],
          _ProfileInfoCardItem(value: username, label: 'Username'),
          if (birthday != null) ...[
            _ProfileInfoCardItem(
              value: birthDayDate(birthday!),
              label: 'Birthday',
            ),
          ],
        ],
      ),
    );
  }
}

class _ProfileInfoCardItem extends StatelessWidget {
  const _ProfileInfoCardItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(value, style: AetherTypography.bodyMedium),
        const SizedBox(height: 4),
        Text(label, style: AetherTypography.labelMedium),
      ],
    );
  }
}
