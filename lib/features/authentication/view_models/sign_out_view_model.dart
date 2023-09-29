import 'dart:async';

import 'package:final_assignment/features/authentication/repos/authentication_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignOutViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      _authRepo.signOut();
    });
  }
}

final signOutProvider = AsyncNotifierProvider<SignOutViewModel, void>(
  () => SignOutViewModel(),
);
