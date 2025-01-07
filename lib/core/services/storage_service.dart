import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadEventThumbnail(File image) async {
    try {
      String filePath = 'event_thumbnails/${DateTime.now()}.png';
      UploadTask uploadTask = _storage.ref().child(filePath).putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }
}
