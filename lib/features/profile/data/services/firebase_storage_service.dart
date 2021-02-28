import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:leaps/core/constants/leaps_strings.dart';

class FirebaseStorageService {
  Future<String> uploadAvatar(
          {@required String uId, @required File file}) async =>
      await uploadFIle(
          uId: uId,
          file: file,
          path: '${UserConstants.avatarPath(uId)}/avatar.png',
          contentType: 'image/png');

  Future<String> uploadFIle(
      {@required String uId,
      @required File file,
      @required String path,
      @required String contentType}) async {
    print('Uploading to: $path');
    final storageReference = FirebaseStorage.instance.ref().child(path);
    final uploadTask = storageReference.putFile(
        file, StorageMetadata(contentType: contentType));
    final snapshot = await uploadTask.onComplete;
    if (snapshot.error != null) {
      print('Upload error code: ${snapshot.error}');
      throw snapshot.error;
    }
    final downloadUrl = await snapshot.ref.getDownloadURL();
    print('donwloadUrl: $downloadUrl');
    return downloadUrl;
  }
}
