import 'package:final_assignment/firebase_options.dart';
import 'package:final_assignment/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(),
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.white,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        splashFactory: NoSplash.splashFactory,
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.black,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedIconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
        bottomAppBarTheme:
            const BottomAppBarTheme(elevation: 0, color: Colors.black),
      ),
    );
  }
}
