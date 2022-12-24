import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class ImageInputRaw {
  // final void Function() onSelectImage;
  // ImageInputRaw({required this.onSelectImage});

  static Future<File?> takeVideoAndPicture() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'gif', 'jpg', 'jpeg', 'mp4']);

    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    } else {
      return null;
    }
  }

  static Future<File?> takePicture() async {
    final picker = ImagePicker();
    File platformFile;
    // ignore: deprecated_member_use
    final imageFile = await picker.getImage(
        source: ImageSource.gallery, maxWidth: 1280, imageQuality: 40);
    if (imageFile == null) {
      return null;
    }
    platformFile = File(
      imageFile.path,
    );
    return platformFile;
  }
}
