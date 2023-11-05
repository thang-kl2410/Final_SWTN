import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

Future<String?> uploadFile(File file) async {
  try {
    DateTime now = DateTime.now();
    int milliseconds = now.millisecondsSinceEpoch;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference = storage.ref().child("uploads/${milliseconds}.jpg");

    UploadTask uploadTask = storageReference.putFile(file);

    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadURL = await storageReference.getDownloadURL();
    print("File uploaded: ${taskSnapshot.totalBytes} bytes");
    return downloadURL;
  } catch (e) {
    print("Error uploading file: $e");
  }
}

Future<List<String>> uploadMultiFile(List<XFile> fileNames) async {
  List<String> downloadURLs = [];
  try {
    FirebaseStorage storage = FirebaseStorage.instance;

    for (XFile file in fileNames) {
      DateTime now = DateTime.now();
      int milliseconds = now.millisecondsSinceEpoch;
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference = storage.ref().child("uploads/${milliseconds}.jpg");

      UploadTask uploadTask = storageReference.putFile(File(file.path));

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await storageReference.getDownloadURL();
      print("File uploaded: ${taskSnapshot.totalBytes} bytes");
      downloadURLs.add(downloadURL);
    }

    return downloadURLs;
  } catch (e) {
    print("Error downloading files: $e");
    return [];
  }
}