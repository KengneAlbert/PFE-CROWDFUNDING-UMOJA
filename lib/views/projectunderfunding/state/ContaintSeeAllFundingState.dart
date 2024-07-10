import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:umoja/models/projet_model.dart';
import 'package:umoja/services/ProjetVoteService.dart';
import 'package:umoja/views/projectunderfunding/layouts/FundingCardSearch.dart';




class ContaintSeeAllFundingState extends StateNotifier<List<Widget>> {
  final projectService = ProjetVoteService(); // Initialisez votre service de projets
  ContaintSeeAllFundingState() : super([]){
    loadProjects();
  }

  Future<void> loadProjects() async {
    try {
      List<ProjetModel> projects = (await projectService.getProjetsWithMoreThanLikes(3)).cast<ProjetModel>(); // Récupérez tous les projets depuis votre service
      state = projects.map((project) => FundingCardSearch(
        MontFunding: "${project.montantObtenu}",
        TotalMontFunding: "${project.montantTotal}",
        ValueFunding: project.montantObtenu / project.montantTotal,
        Day: "${project.createdAt}",
        NumberDonation: "19 dfdf",
        projectId: project.id,
        ImagePath: project.imageUrls[0],
        Title: project.titre,
      )).toList();
    } catch (e) {
      print('Error loading projects: $e');
      // Gérez les erreurs ici si nécessaire
    }
  }

  void updateCards(List<Widget> newCards) {
    state = newCards;
  }
}

final ContaintSeeAllFundingStateProvider = StateNotifierProvider<ContaintSeeAllFundingState, List<Widget>>((ref) {
  return ContaintSeeAllFundingState();
});
