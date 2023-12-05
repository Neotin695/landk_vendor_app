import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:vendor_app/models/img_model.dart';

mixin ImageUploader {
  Future<List<ImgModel>> uploadMultiImg<T extends List>(
      FirebaseStorage storage, String folderName, T paths) async {
    final storageRef = storage.ref(folderName);
    final String imgId = const Uuid().v1();
    List<ImgModel> imgList = [];
    if (paths is List<Uint8List>) {
      for (var path in paths) {
        final task = await storageRef.child('$imgId.png').putData(path);
        if (task.state == TaskState.success) {
          imgList
              .add(ImgModel(url: (await task.ref.getDownloadURL()), id: imgId));
        } else {
          return [];
        }
      }
    } else if (paths is List<String>) {
      for (var path in paths) {
        final task = await storageRef.child('$imgId.png').putFile(File(path));
        if (task.state == TaskState.success) {
          imgList
              .add(ImgModel(url: (await task.ref.getDownloadURL()), id: imgId));
        } else {
          return [];
        }
      }
    }
    return imgList;
  }

  Future<ImgModel> uploadSingleImg<T>(
      FirebaseStorage storage, String folderName, T path) async {
    final storageRef = storage.ref(folderName);
    final String imgId = const Uuid().v1();
    if (path is Uint8List) {
      final task = await storageRef.child('$imgId.png').putData(path);
      if (task.state == TaskState.success) {
        return ImgModel(url: (await task.ref.getDownloadURL()), id: imgId);
      } else {
        return ImgModel.empty();
      }
    } else if (path is String) {
      final task = await storageRef.child('$imgId.png').putFile(File(path));
      if (task.state == TaskState.success) {
        return ImgModel(url: (await task.ref.getDownloadURL()), id: imgId);
      } else {
        return ImgModel.empty();
      }
    }
    return ImgModel.empty();
  }
}
