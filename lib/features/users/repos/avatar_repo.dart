import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AvatarRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> uploadAvatar(File file, String fileName) async {
    final fileRef = _storage.ref().child("avatars/$fileName");
    await fileRef.putFile(file);
  }
}

final avatarRepo = Provider((ref) => AvatarRepository());
