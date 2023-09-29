import 'dart:async';
import 'package:final_assignment/features/authentication/repos/authentication_repo.dart';
import 'package:final_assignment/features/users/view_models.dart/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signIn() async {
    state = const AsyncValue.loading();
    final form = ref.read(loginFormProvider.notifier).state;
    final user = ref.read(usersProvider.notifier);
    state = await AsyncValue.guard(
      () async {
        final userCredential = await _authRepo.signIn(
          form['email'],
          form['password'],
        );
        user.userProfileFind(userCredential.user!.uid);
      },
    );
  }
}

final signInProvider = AsyncNotifierProvider<SignInViewModel, void>(
  () => SignInViewModel(),
);

final loginFormProvider = StateProvider((ref) => {});
