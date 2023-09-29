import 'package:final_assignment/features/authentication/view_models/sign_out_view_model.dart';
import 'package:final_assignment/features/constants/gaps.dart';
import 'package:final_assignment/features/constants/sizes.dart';
import 'package:final_assignment/features/users/view_models.dart/user_view_model.dart';
import 'package:final_assignment/features/users/widgets/avatar.dart';
import 'package:final_assignment/features/users/widgets/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({
    super.key,
  });

  static const routeUrl = "/profile";
  static const routeName = "profile";

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _logOut() {
    ref.read(signOutProvider.notifier).signOut();
  }

  @override
  Widget build(BuildContext context) {
    final isLeaving = ref.watch(signOutProvider).isLoading;
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: isLeaving ? null : _logOut,
                    icon: isLeaving
                        ? const CircularProgressIndicator.adaptive()
                        : const Icon(
                            Icons.logout,
                          ),
                  ),
                ],
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size14,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          data.name,
                          style: const TextStyle(
                            fontSize: Sizes.size22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              data.email,
                              style: const TextStyle(
                                fontSize: Sizes.size16,
                              ),
                            ),
                            Gaps.h4,
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.withOpacity(0.2),
                              ),
                              child: const Text(
                                "threads.net",
                                style: TextStyle(
                                  fontSize: Sizes.size11,
                                ),
                              ),
                            )
                          ],
                        ),
                        trailing: SizedBox(
                          width: 60,
                          height: 60,
                          child: Avatar(
                            name: data.name,
                            hasAvatar: data.hasAvatar,
                            uid: data.uid,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
  }
}
