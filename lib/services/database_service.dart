
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  static FirebaseFirestore get instance => FirebaseFirestore.instance;

  Future<dynamic> create(String collectionPath, Map<String, dynamic> object) async{
    final collection = instance.collection(collectionPath);
    final ref = await collection.add(object);
    return await ref.get();
  }

  Future<void> update(String documentPath, Map<String, dynamic> object) async{
    final document = instance.doc(documentPath);
    await document.set(object);
  }
  
  Future<void> delete(String documentPath) async{
    final document = instance.doc(documentPath);
    await document.delete();
  }

  Future<Map<String,dynamic>?> fetchOne(String documentPath) async{
    final document = instance.doc(documentPath);
    final snapshot = await document.get();
    return snapshot.data();
  }

  Future<List<Map<String,dynamic>?>> fetchAll(String collectionPath) async{
    final collection = instance.collection(collectionPath);
    final snapshot = await collection.get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  Future<List<Map<String, dynamic>?>> fetchByCategorie(String collectionPath, int categorieId) async {
    final collection = instance.collection(collectionPath);
    final snapshot = await collection.where('CategorieId', isEqualTo: categorieId).get();
    return snapshot.docs.map((e) => e.data()).toList();
  }
  

}