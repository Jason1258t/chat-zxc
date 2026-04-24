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
      width: double.infinity,
      padding: EdgeInsetsGeometry.all(16),
      child: Column(
        children: _addSSpacing(
          children: [
            _ProfileInfoCardItem(
              value: phone == null ? 'hidden' : formatPhoneNumber(phone!),
              label: 'Mobile',
            ),
            if (bio != null) ...[
              _ProfileInfoCardItem(value: bio!, label: 'Bio'),
            ],
            _ProfileInfoCardItem(value: username, label: 'Username'),
            if (birthday != null) ...[
              _ProfileInfoCardItem(
                value: birthDayDate(birthday!),
                label: 'Birthday',
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _addSSpacing({required List<Widget> children}) =>
      children.expand((c) => [c, _profileCardSpacer()]).toList()..removeLast();

  Widget _profileCardSpacer() => const SizedBox(height: 16);

  String formatPhoneNumber(String rawDigits) {
    // Удаляем всё, кроме цифр
    String cleaned = rawDigits.replaceAll(RegExp(r'\D'), '');

    // Если номер из 11 цифр и начинается с 7 или 8
    if (cleaned.length == 11 && RegExp(r'^[78]').hasMatch(cleaned)) {
      String countryCode = cleaned[0] == '8' ? '7' : cleaned[0];
      String rest = cleaned.substring(1);
      return '+$countryCode (${rest.substring(0, 3)}) ${rest.substring(3, 6)}-${rest.substring(6, 8)}-${rest.substring(8, 10)}';
    }

    // fallback: возвращаем исходную строку, если формат не подходит
    return rawDigits;
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
        Text(
          value,
          style: AetherTypography.figtree.copyWith(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6, width: double.infinity),
        Text(
          label,
          style: AetherTypography.labelMedium.copyWith(
            color: Color(0xff7c7c7c),
          ),
        ),
      ],
    );
  }
}
