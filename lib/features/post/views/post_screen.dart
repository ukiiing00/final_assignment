import 'package:final_assignment/features/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  void _unFocusOf() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size72,
        horizontal: Sizes.size24,
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: GestureDetector(
          onTap: _unFocusOf,
          child: Scaffold(
            appBar: AppBar(
              leading: null,
              title: const Text(
                "How do you feel?",
                style: TextStyle(
                  fontSize: Sizes.size18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size14,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size20,
                      vertical: Sizes.size14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const TextField(
                      maxLines: 5,
                      minLines: 5,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
