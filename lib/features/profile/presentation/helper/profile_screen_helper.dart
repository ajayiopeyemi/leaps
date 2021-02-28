import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leaps/core/utils/leaps_user_details_util.dart';
import 'package:leaps/features/authentication/data/services/user_services.dart';
import 'package:leaps/features/profile/data/services/firebase_storage_service.dart';
import 'package:leaps/features/profile/data/services/image_picker_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> chooseAvatar(BuildContext context) async {
  try {
    final imagePicker = Provider.of<ImagePickerService>(context);
    final file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final storage = Provider.of<FirebaseStorageService>(context);
      final downloadUrl = await storage.uploadAvatar(
        uId: AppState.userDetails.uId,
        file: file,
      );
      final database = Provider.of<UserService>(context);
      await database.setAvatarReference(downloadUrl);
      await file.delete();
    }
  } catch (e) {
    print('The error: $e');
  }
}

launchURL() async {
  const url = 'https://www.leapsgcrf.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
