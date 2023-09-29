import 'dart:async';
import 'dart:io';

import 'package:final_assignment/features/authentication/repos/authentication_repo.dart';
import 'package:final_assignment/features/users/repos/avatar_repo.dart';
import 'package:final_assignment/features/users/view_models.dart/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final AvatarRepository _avatarRepository;
  @override
  FutureOr<void> build() {
    _avatarRepository = ref.read(avatarRepo);
  }

  Future<void> uploadAvatar(File file) async {
    state = const AsyncValue.loading();
    final fileName = ref.read(authRepo).user!.uid;
    state = await AsyncValue.guard(
      () async {
        await _avatarRepository.uploadAvatar(file, fileName);
        await ref.read(usersProvider.notifier).onAvatarUpload();
      },
    );
  }
}

final avatarProvider = AsyncNotifierProvider<AvatarViewModel, void>(
  () => AvatarViewModel(),
);
