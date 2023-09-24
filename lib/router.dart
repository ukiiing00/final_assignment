import 'package:final_assignment/features/main/screens/my_home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';

final routerProvider = Provider((ref) => GoRouter(routes: [
      GoRoute(
        path: MyHomePage.routeUrl,
        name: MyHomePage.routeName,
        builder: (context, state) =>
            const MyHomePage(title: "Final Assignment"),
      )
    ]));
