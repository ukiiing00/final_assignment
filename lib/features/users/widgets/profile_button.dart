import 'package:final_assignment/features/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    required this.profile,
  });

  final String profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          profile,
          style: const TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
