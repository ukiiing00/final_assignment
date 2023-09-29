import 'package:final_assignment/features/users/view_models.dart/avatar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Avatar extends ConsumerWidget {
  final String name;
  final bool hasAvatar;
  final String uid;

  const Avatar({
    super.key,
    required this.name,
    required this.hasAvatar,
    required this.uid,
  });

  // Future<void> _onAvatarTap(WidgetRef ref) async {
  //   final xfile = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 40,
  //     maxHeight: 150,
  //     maxWidth: 150,
  //   );
  //   if (xfile != null) {
  //     final file = File(xfile.path);
  //     await ref.read(avatarProvider.notifier).uploadAvatar(file);
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(avatarProvider).isLoading;
    return GestureDetector(
      // onTap: isLoading ? null : () => _onAvatarTap(ref),
      child: isLoading
          ? Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const CircularProgressIndicator(),
            )
          : Center(
              child: CircleAvatar(
                radius: 40,
                foregroundImage: hasAvatar
                    ? NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/twitter-clone-uk.appspot.com/o/avatars%2F$uid?alt=media")
                    : null,
                child: const FaIcon(
                  FontAwesomeIcons.person,
                ),
              ),
            ),
    );
  }
}
