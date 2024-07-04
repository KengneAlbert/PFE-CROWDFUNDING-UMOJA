// category_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getCategoryIDByName(String categoryName) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('Categorie')
          .where('titre', isEqualTo: categoryName).limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        print('Category not found');
        return null;
      }
    } catch (e) {
      print('Error fetching category ID: $e');
      return null;
    }
  }

}
