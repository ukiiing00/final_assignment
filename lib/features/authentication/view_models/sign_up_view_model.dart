import 'dart:async';
import 'package:final_assignment/features/authentication/repos/authentication_repo.dart';
import 'package:final_assignment/features/users/view_models.dart/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp() async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpFormProvider.notifier).state;
    final users = ref.read(usersProvider.notifier);
    state = await AsyncValue.guard(
      () async {
        final usersCredential = await _authRepo.signUp(
          form['email'],
          form['password'],
        );
        users.createProfile(usersCredential, form["nickname"]);
      },
    );
  }
}

final signUpFormProvider = StateProvider((ref) => {});
final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
