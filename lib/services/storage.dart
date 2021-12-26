import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class Storage {
  static Future<String> uploadImage({
    required File image,
    required String id,
  }) async {
    final Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(id);
    UploadTask uploadTask = firebaseStorageRef.putFile(image);
    TaskSnapshot storageSnapshot = await uploadTask;
    return await storageSnapshot.ref.getDownloadURL();
  }
}
