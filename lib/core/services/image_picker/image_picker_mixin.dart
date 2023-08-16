import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

mixin PickMediaMixin {
  final ImagePicker _imagePicker = ImagePicker();
  Future<String?> pickSingleImage(ImageSource imageSource) async {
    try {
      final result = await _imagePicker.pickImage(
          source: imageSource);

      if (result == null) {
        return null;
      } else {
        return result.path;
      }
    } on PlatformException catch (err) {
      print(err);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Uint8List>?> pickMultiImage() async {
    try {
      final result = await _imagePicker.pickMultiImage();

      if (result.isEmpty) {
        return null;
      } else if (result.isNotEmpty) {
        return List<Uint8List>.from(result.map((e) => e.readAsBytes()));
      }
    } on PlatformException catch (err) {
      print(err);
    } catch (e) {
      print(e);
    }
    return null;
  }
}
