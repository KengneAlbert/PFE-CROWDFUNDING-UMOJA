// lib/services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:umoja/models/document_projet_model.dart';
import 'package:umoja/models/projet_vote_model.dart';
import 'package:umoja/models/user_model.dart';

class ProjetVoteService {

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//retourne tous les projets de la collection Projets 
Future<List<ProjetVoteModel>> getProjets() async {
  List<ProjetVoteModel> projets = [];

  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Projets') // Assurez-vous que le nom de la collection est correct
        .get();

    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      ProjetVoteModel projet = ProjetVoteModel.fromMap(doc.id, data);
      projets.add(projet);
    }
  } catch (e) {
    print('Error ..........................: $e');
  }

  return projets;
}

//retourne tous les projets eyant moins de trois likes en gros les projets en cours de vote
Future<List<ProjetVoteModel>> getProjetsWithFewLikes(int maxLikes) async {
  List<ProjetVoteModel> projets = [];

  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Projets') // Assurez-vous que le nom de la collection est correct
        .get();

    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      ProjetVoteModel projet = ProjetVoteModel.fromMap(doc.id, data);
      if (projet.likes.isNotEmpty && projet.likes.length <= maxLikes) {
        projets.add(projet);
      }
    }
  } catch (e) {
    print('Error getting projects with few likes: $e');
  }

  return projets;
}

//retourne tous les projets eyant plus de trois likes en gros les projets en cours de financement
Future<List<ProjetVoteModel>> getProjetsWithMoreThanLikes(int minLikes) async {
    List<ProjetVoteModel> projets = [];

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Projets') // Assurez-vous que le nom de la collection est correct
          .get();

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        ProjetVoteModel projet = ProjetVoteModel.fromMap(doc.id, data);
        if (projet.likes.length > minLikes) {
          projets.add(projet);
        }
      }
    } catch (e) {
      print('Error getting projects with more than $minLikes likes: $e');
    }

    return projets;
  }

  //recupere les projets qui n'ont pas de likes

  Future<List<ProjetVoteModel>> getProjectsWithNoLikes() async {
    
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('Projets')
          .where('likes', isEqualTo: [])
          .get();
      return snapshot.docs.map((doc) {
        return ProjetVoteModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching projects with no likes: $e');
      return [];
    }
  }

//recupere le nombre total de like

Future<int> getTotalLikes(String projectId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('Projets').doc(projectId).get();
      if (doc.exists) {
        List<dynamic> likes = doc['likes'] ?? [];
        return likes.length;
      } else {
        print('Project not found');
        return 0;
      }
    } catch (e) {
      print('Error fetching total likes: $e');
      return 0;
    }
  }

  //recupere les favory d'un users

  Future<List<String>> getUserFavorites(String userId) async {
    try {
      // Récupérer le document utilisateur de Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

      if (userDoc.exists) {
        // Convertir le document en instance de UserModel
        UserModel user = UserModel.fromMap(userDoc.data() as Map<String, dynamic>, userId);

        // Retourner la liste des favory
        return user.favory ?? [];
      } else {
        print('User not found');
        return [];
      }
    } catch (e) {
      print('Error fetching user favorites: $e');
      return [];
    }
  }

  //recupere tous les projets en fonction de leurs ID

  Future<List<ProjetVoteModel>> getProjetsByIds(List<String> ids) async {
  List<ProjetVoteModel> projets = [];

  try {
    for (String id in ids) {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection('Projets').doc(id).get();

      if (docSnapshot.exists) {
        projets.add(ProjetVoteModel.fromMap(docSnapshot.id, docSnapshot.data() as Map<String, dynamic>));
      }
    }
  } catch (e) {
    print('Error fetching projects: $e');
  }

  return projets;
}

//recupere un projet a partir de son ID

Future<ProjetVoteModel?> getProjetById(String id) async {
  final CollectionReference projetsCollection = FirebaseFirestore.instance.collection('Projets');
    try {
      DocumentSnapshot doc = await projetsCollection.doc(id).get();

      if (doc.exists) {
        return ProjetVoteModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      } else {
        print('No project found for the given ID');
        return null;
      }
    } catch (e) {
      print('Error getting project by ID: $e');
      return null;
    }
  }

  //listes des documents 

  Future<List<DocumentProjetModel>> getDocumentsByProjectId(String projectId) async {
  try {
    // Accédez à la collection "projets" et à la sous-collection "documentProjets"
    final snapshot = await FirebaseFirestore.instance
        .collection('projets')
        .doc(projectId)
        .collection('DocumentProjet')
        .get();

    // Transformez chaque document en un objet DocumentProjetModel
    List<DocumentProjetModel> documents = snapshot.docs.map((doc) {
      return DocumentProjetModel.fromMap(doc.data());
    }).toList();

    return documents;
  } catch (e) {
    print('Error fetching documents: $e');
    return [];
  }
}

}


