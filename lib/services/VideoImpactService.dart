import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:umoja/models/VideoImpact.dart';
// Assurez-vous de mettre le bon chemin d'importation pour votre modèle

class VideoImpactService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<VideoImpact>> getAllVideoImpacts() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('VideoImpact').get();
      return querySnapshot.docs.map((doc) {
        return VideoImpact.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Error getting video impacts: $e");
      return [];
    }
  }
}
