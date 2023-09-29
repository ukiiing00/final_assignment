import 'package:final_assignment/features/authentication/view_models/sign_up_view_model.dart';
import 'package:final_assignment/features/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpButton extends ConsumerWidget {
  const SignUpButton({
    super.key,
    required this.onSubmitTap,
  });

  final Function onSubmitTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(signUpProvider).isLoading;
    return GestureDetector(
      onTap: isLoading ? null : () => onSubmitTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size14,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator.adaptive()
              : const Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: Sizes.size22,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
