import 'package:flutter/material.dart';

/// Enum to define avatar sizes
enum AvatarSize { small, medium, large }

class Avatar extends StatelessWidget {
  final String imageUrl;
  final AvatarSize size;

  const Avatar({
    Key? key,
    required this.imageUrl,
    this.size = AvatarSize.small,
  }) : super(key: key);

  double get _avatarDimension {
    switch (size) {
      case AvatarSize.small:
        return 40.0;
      case AvatarSize.medium:
        return 60.0;
      case AvatarSize.large:
        return 168.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double dimension = _avatarDimension;

    return Container(
      width: dimension,
      height: dimension,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(dimension / 2),
        ),
      ),
    );
  }
}
