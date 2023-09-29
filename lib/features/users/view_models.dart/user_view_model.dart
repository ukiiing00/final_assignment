import 'dart:async';
import 'package:final_assignment/features/users/models/user_profile_model.dart';
import 'package:final_assignment/features/users/repos/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UsersRepository _usersRepository;

  @override
  FutureOr<UserProfileModel> build() {
    _usersRepository = ref.read(usersRepo);

    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential, String nickname) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      uid: credential.user!.uid,
      email: credential.user!.email ?? "anon@anon.com",
      bio: "undefined",
      name: credential.user!.displayName ?? nickname,
      link: "undefined",
      hasAvatar: false,
    );
    await _usersRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> userProfileFind(String uid) async {
    final json = await _usersRepository.findProfile(uid);
    if (json != null) {
      final profile = UserProfileModel.fromJson(json);
      state = AsyncValue.data(profile);
    }
  }

  Future<void> onAvatarUpload() async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));
    await _usersRepository.updateUser(state.value!.uid, {"hasAvatar": true});
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
