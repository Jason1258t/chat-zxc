import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_zxc/shared/theme/aether.dart';
import 'package:chat_zxc/shared/utils/initials.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.displayName,
    required this.color,
    required this.avatarUrl,
    this.size = 80,
  });

  final String displayName;
  final Color color;
  final String? avatarUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return avatarUrl != null
        ? CachedNetworkImage(
            imageUrl: avatarUrl!,
            imageBuilder: (context, imageProvider) =>
                _imageAvatar(imageProvider),
            placeholder: (context, url) => _simpleAvatar(),
            errorWidget: (context, url, error) => _errorContainer(),
          )
        : _simpleAvatar();
  }

  Widget _imageAvatar(ImageProvider image) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        image: DecorationImage(image: image, fit: BoxFit.cover),
      ),
    );
  }

  Widget _simpleAvatar() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      alignment: Alignment.center,
      child: Text(
        getInitials(displayName),
        style: AetherTypography.avatarInitials.copyWith(
          color: Colors.white,
          fontSize: size * 0.4,
        ),
      ),
    );
  }

  Widget _errorContainer() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      alignment: Alignment.center,
      child: Icon(CupertinoIcons.nosign),
    );
  }
}
