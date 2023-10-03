import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

mixin PickMediaMixin {
  final ImagePicker _imagePicker = ImagePicker();
  Future<String> pickSingleImage(ImageSource imageSource) async {
    try {
      final result = await _imagePicker.pickImage(source: imageSource);

      if (result == null) {
        return '';
      } else {
        return result.path;
      }
    } on PlatformException catch (err) {
      print(err);
      return '';
    } catch (e) {
      return '';
    }
  }

  Future<List<String>> pickMultiImage() async {
    try {
      final result = await _imagePicker.pickMultiImage();

      if (result.isEmpty) {
        return [];
      } else if (result.isNotEmpty) {
        return List<String>.from(result.map((e) => e.path));
      }
    } on PlatformException catch (err) {
      print(err);
    } catch (e) {
      print(e);
    }
    return [];
  }
}
