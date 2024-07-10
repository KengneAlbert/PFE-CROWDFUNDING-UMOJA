import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/main.dart';
import 'package:umoja/models/projet_model.dart';
import 'package:umoja/services/database_service.dart';

class ProjetViewModel extends StateNotifier<List<ProjetModel?>> {
  final DatabaseService projetService;
  bool _isLoading = false;
  String? _error;

  ProjetViewModel({required this.projetService}) : super([]);

  bool get isLoading => _isLoading;
  String? get error => _error;
  String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

  bool get hasError => error != null;

  // Function to create a new project
  Future<void> setProjet({
    required String titre,
    required String description,
    required int montantTotal,
    required DateTime dateDebutCollecte,
    required DateTime dateFinCollecte,
    required String histoire,
    required int montantObtenu,
    required String categorieId,
    required DateTime createdAt,
    required List<String> imageUrls,
    required List<String> likes,
    String? businessModelDocumentUrl,
    String? businessPlanDocumentUrl,
    String? videoUrl,
  }) async {
    _setLoading(true);
    try {
      final projetModel = ProjetModel(
        id: '',
        titre: titre,
        description: description,
        montantTotal: montantTotal,
        dateDebutCollecte: dateDebutCollecte,
        dateFinCollecte: dateFinCollecte,
        histoire: histoire,
        montantObtenu: montantObtenu,
        categorieId: categorieId,
        userId: uid,
        createdAt: createdAt,
        imageUrls: imageUrls,
        likes: likes,
        businessModelDocumentUrl: businessModelDocumentUrl,
        businessPlanDocumentUrl: businessPlanDocumentUrl,
        videoUrl: videoUrl,
      );

      // Add the project to Firestore
      final docRef = await projetService.create('Projets', projetModel.toMap());
      final projectId = docRef.id;

      // Update the state with the new project
      await fetchAllProjets();
    } catch (e) {
      _setError(e.toString());
      print('Error in setProjet: $_error');
    } finally {
      _setLoading(false);
    }
  }

  // Fonction pour récupérer un projet par son ID
  Future<ProjetModel?> fetchProjectById(String projectId) async {
    try {
      final projectData = await projetService.fetchOne('Projets/$projectId');
      if (projectData != null) {
        return ProjetModel.fromMap(projectData);
      }
    } catch (e) {
      print('Error fetching project by ID: $e');
    }
    return null;
  }

  Future<void> fetchAllProjets() async {
    _setLoading(true);
    try {
      print('Fetching projects for user: $uid'); // Log pour vérifier l'exécution
      final projets = await projetService.fetchAll('Projets');
      state = projets.map((e) => e != null ? ProjetModel.fromMap(e) : null).toList();
      if (state.isEmpty) {
        print('No projects found for user: $uid');
      } else {
        print('Projects loaded successfully');
      }
    } catch (e) {
      _setError(e.toString());
      print('Error fetching projects: ${e.toString()}'); // Log pour afficher l'erreur
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchProjetsByCategorie(int categorieId) async {
    _setLoading(true);
    try {
      final projets = await projetService.fetchByCategorie('Projets', categorieId);
      state = projets.map((e) => e != null ? ProjetModel.fromMap(e) : null).toList();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

Future<bool> updateProject(String id, ProjetModel projet) async {
  _setLoading(true);
  try {
    await projetService.update('Projets/$id', projet.toMap());
    await fetchAllProjets();
    return true;
  } catch (e) {
    _setError(e.toString());
    return false;
  } finally {
    _setLoading(false);
  }
}


  Future<void> deleteProjet(String id) async {
    _setLoading(true);
    try {
      await projetService.delete('Projets/$id');
      await fetchAllProjets();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool isLoading) {
    _isLoading = isLoading;
    state = [...state];
  }

  void _setError(String error) {
    _error = error;
    state = [...state];
  }
}


final projetViewModelProvider = StateNotifierProvider<ProjetViewModel, List<ProjetModel?>>(
  (ref) => ProjetViewModel(projetService: ref.watch(databaseServiceProvider)),
);
