import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:umoja/models/projet_vote_model.dart';
import 'package:umoja/services/ProjetVoteService.dart';
import 'package:umoja/views/search/layouts/FundingCardSearch.dart';


class FundingCardSearchState extends StateNotifier<List<Widget>> {
  final projectService = ProjetVoteService();
  FundingCardSearchState() : super([]){
    loadProjects();
  }

  Future<void> loadProjects() async {
    try {
      List<ProjetVoteModel> projects = await projectService.getProjetsWithMoreThanLikes(3); // Récupérez tous les projets depuis votre service
      state = projects.map((project) => FundingCardSearch(
        MontFunding: "${project.montantObtenu}",
        TotalMontFunding: "${project.montantTotal}",
        //projectId: project.id,
        ImagePath: project.imageUrls[0],
        Title: project.titre,
        //TitleFunding: '\$ ${project.montantObtenu} fund raised from \$ ${project.montantTotal}',
        ValueFunding: project.montantObtenu / project.montantTotal,
        NumberDonation: '0', // À ajuster selon votre structure de données
        Day: "${project.dateFinCollecte.difference(project.dateDebutCollecte).inDays}",
        //LikeProjet: "Votes",
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

final FundingCardSearchStateProvider = StateNotifierProvider<FundingCardSearchState, List<Widget>>((ref) {
  return FundingCardSearchState();
});
