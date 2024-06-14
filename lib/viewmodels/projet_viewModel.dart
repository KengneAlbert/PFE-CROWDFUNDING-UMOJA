import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/projet_model.dart';
import 'package:umoja/services/database_service.dart';
import 'package:umoja/services/storage_service.dart';

class ProjetViewModel extends StateNotifier<List<ProjetModel?>>{
  final DatabaseService projetService;
  bool _isLoading = false;

  ProjetViewModel({required this.projetService}):super([]);
  
  bool get isLoading => _isLoading;

  //   Future<void> setProjet({
  //   required String titre,
  //   required String description,
  //   required int montantTotal,
  //   required DateTime dateDebutCollecte,
  //   required DateTime dateFinCollecte,
  //   String? histoire,
  //   required int montantObtenu,
  //   required String categorieId,
  //   required String userId,
  //   required DateTime createdAt,
  //   required List<String> images,
  //   File? proposalDocument,
  //   File? medicalDocument, String? proposalDocumentUrl, String? medicalDocumentUrl,
  // }) async {
  //   _isLoading = true;
  //   state = [...state];

  //   try {
  //     final storageService = StorageService(FirebaseStorage.instance);

  //     // Upload images
  //     List<String> imageUrls = [];
  //     for (var image in images) {
  //       final imageUrl = await storageService.uploadFile(image, 'projects/images/${DateTime.now().millisecondsSinceEpoch}_${image.path.split('/').last}');
  //       imageUrls.add(imageUrl);
  //     }

  //     // Upload proposal document
  //     String? proposalDocumentUrl;
  //     if (proposalDocument != null) {
  //       proposalDocumentUrl = await storageService.uploadFile(proposalDocument, 'projects/documents/${DateTime.now().millisecondsSinceEpoch}_${proposalDocument.path.split('/').last}');
  //     }

  //     // Upload medical document
  //     String? medicalDocumentUrl;
  //     if (medicalDocument != null) {
  //       medicalDocumentUrl = await storageService.uploadFile(medicalDocument, 'projects/documents/${DateTime.now().millisecondsSinceEpoch}_${medicalDocument.path.split('/').last}');
  //     }

  //     // Create the project model
  //     final ProjetModel projetModel = ProjetModel(
  //       titre: titre,
  //       description: description,
  //       montantTotal: montantTotal,
  //       dateDebutCollecte: dateDebutCollecte,
  //       dateFinCollecte: dateFinCollecte,
  //       histoire: histoire ?? '',
  //       montantObtenu: montantObtenu,
  //       CategorieId: categorieId,
  //       userId: userId,
  //       createdAt: createdAt,
  //       imageUrls: imageUrls,
  //       proposalDocumentUrl: proposalDocumentUrl,
  //       medicalDocumentUrl: medicalDocumentUrl,
  //     );

  //     // Save project to Firestore
  //     await projetService.update("Projets", projetModel.toMap());
  //     await fetchAllProjets();
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     _isLoading = false;
  //   }
  // }

  Future<void> setProjet({
  required String titre,
  required String description,
  required int montantTotal,
  required DateTime dateDebutCollecte,
  required DateTime dateFinCollecte,
  required String histoire,
  required int montantObtenu,
  required String categorieId,
  required String userId,
  required DateTime createdAt,
  required List<String> imageUrls,  // Modifié
  String? proposalDocumentUrl,
  String? medicalDocumentUrl,
}) async {
  _isLoading = true;
  state = [...state];
  try {
    final ProjetModel projetModel = ProjetModel(
      titre: titre,
      description: description,
      montantTotal: montantTotal,
      dateDebutCollecte: dateDebutCollecte,
      dateFinCollecte: dateFinCollecte,
      montantObtenu: montantObtenu,
      categorieId: categorieId,
      userId: userId,
      createdAt: createdAt,
      imageUrls: imageUrls,  // Modifié
      proposalDocumentUrl: proposalDocumentUrl,
      medicalDocumentUrl: medicalDocumentUrl, 
      histoire: '',
    );
    await projetService.update("Projets", projetModel.toMap());
    await fetchAllProjets();
  } catch (e) {
    print(e);
  } finally {
    _isLoading = false;
  }
}


  // Future<void> setProjet(String titre, String description, int montantTotal, DateTime dateDebutCollecte, DateTime dateFinCollecte, String? histoire, int montantObtenu, String CategorieId, int userId, DateTime createdAt)async{
  //   _isLoading = true;
  //   state = [...state];
  //   try{
  //       final ProjetModel projetModel = ProjetModel(titre: titre, description: description, montantTotal: montantTotal, dateDebutCollecte: dateDebutCollecte, dateFinCollecte: dateFinCollecte, montantObtenu: montantObtenu, CategorieId: CategorieId, userId: userId, createdAt: createdAt);
  //       await projetService.update("Projets", projetModel.toMap());
  //       await fetchAllProjets();
  //   }catch (e){
  //     print(e);
  //   } finally {
  //     _isLoading = false;
  //   }
  // }

  Future<void> fetchAllProjets() async {
    _isLoading = true;
    state = [...state];
    try {
      final projets = await projetService.fetchAll('Projets');
      state = projets.map((e) => e != null ? ProjetModel.fromMap(e) : null ).toList();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }


  Future<void> fetchProjetsByCategorie(int categorieId) async {
    _isLoading = true;
    state = [...state];
    try {
      final projets = await projetService.fetchByCategorie('Projets', categorieId);
      state = projets.map((e) => e != null ? ProjetModel.fromMap(e) : null).toList();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }


  Future<void> updateProjet(String id, ProjetModel projet) async {
    _isLoading = true;
    state = [...state];
    try {
      await projetService.update('Projets/$id', projet.toMap());
      await fetchAllProjets();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> deleteProjet(String id) async {
    _isLoading = true;
    state = [...state];
    try {
      await projetService.delete('Projets/$id');
      await fetchAllProjets();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }

}
