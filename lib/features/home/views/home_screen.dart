import 'package:final_assignment/features/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MOODMODU",
          style: TextStyle(
            fontSize: Sizes.size20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
