import 'package:final_assignment/features/authentication/repos/authentication_repo.dart';
import 'package:final_assignment/features/authentication/views/sign_in_screen.dart';
import 'package:final_assignment/features/authentication/views/sign_up_screen.dart';
import 'package:final_assignment/features/main/views/main_navigation_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider(
  (ref) {
    ref.watch(authState);
    return GoRouter(
      initialLocation: "/",
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        if (!isLoggedIn) {
          if (state.fullPath == SignUpScreen.routeUrl) {
            return SignUpScreen.routeUrl;
          } else {
            return SignInScreen.routeUrl;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          path: SignUpScreen.routeUrl,
          name: SignUpScreen.routeName,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          path: SignInScreen.routeUrl,
          name: SignInScreen.routeName,
          builder: (context, state) => const SignInScreen(),
        ),
        GoRoute(
          path: "/:tab(|search|activity|profile)",
          name: MainNavigationScreen.routeName,
          builder: (context, state) {
            final tab = state.pathParameters["tab"]!;
            return MainNavigationScreen(tab: tab);
          },
        ),
      ],
    );
  },
);
