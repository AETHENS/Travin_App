import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PickImage {
  PickImage._();

  static Future<XFile?> selectImageFromGaleri() async {
    return await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
  }

  static Future<File?> cropSelectedImage(String filepath) async {
    return await ImageCropper().cropImage(
        sourcePath: filepath,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        iosUiSettings: const IOSUiSettings(
            title: 'Crop Image',
            aspectRatioLockEnabled: true,
            minimumAspectRatio: 1.0,
            aspectRatioPickerButtonHidden: true));
  }
}
