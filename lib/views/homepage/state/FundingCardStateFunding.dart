import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:umoja/models/projet_vote_model.dart';
import 'package:umoja/services/ProjetVoteService.dart';
import '../layouts/FundingCard.dart';

class FundingCardStateFunding extends StateNotifier<List<Widget>> {
  final projectService = ProjetVoteService();
  FundingCardStateFunding() : super([]){
    loadProjects();
  }

  Future<void> loadProjects() async {
    try {
      List<ProjetVoteModel> projects = await projectService.getProjetsWithMoreThanLikes(3); // Récupérez tous les projets depuis votre service
      state = projects.map((project) => FundingCard(
        //projectId: project.id,
        ImagePath: project.imageUrls[0],
        Title: project.titre,
        TitleFunding: '\$ ${project.montantObtenu} fund raised from \$ ${project.montantTotal}',
        ValueFunding: project.montantObtenu / project.montantTotal,
        NumberDonation: 'Unknown Donators', // À ajuster selon votre structure de données
        Day: "12 day",
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

final fundingCardStateProvider = StateNotifierProvider<FundingCardStateFunding, List<Widget>>((ref) {
  return FundingCardStateFunding();
});
