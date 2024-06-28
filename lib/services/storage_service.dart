import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage;

  StorageService(this._firebaseStorage);

  Future<String> uploadFile(File file, String path) async {
    try {
      final storageRef = _firebaseStorage.ref().child(path);
      final uploadTask = await storageRef.putFile(file);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Error uploading file: $e');
    }
  }

  // Méthode pour télécharger un fichier depuis Firebase Storage
  Future<File?> downloadFile(String fileUrl) async {
    try {
      final ref = _firebaseStorage.refFromURL(fileUrl);
      final downloadUrl = await ref.getDownloadURL();
      final file = await ref.getData(); // Téléchargement du fichier
      final tempDir = await getTemporaryDirectory(); // Obtenir le répertoire temporaire
      final tempFile = File('${tempDir.path}/${fileUrl.split('/').last}');
      await tempFile.writeAsBytes(file!); // Écriture des données du fichier
      return tempFile; // Renvoi du fichier temporaire
    } catch (e) {
      print('Error downloading file: $e');
      return null;
    }
  }
}
