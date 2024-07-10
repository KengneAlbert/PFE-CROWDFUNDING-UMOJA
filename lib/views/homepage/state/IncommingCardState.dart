
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:umoja/models/projet_vote_model.dart';
import 'package:umoja/services/ProjetVoteService.dart';
import '../layouts/FundingCardVote.dart';

class IncommingCardState extends StateNotifier<List<Widget>> {
  final projectService = ProjetVoteService();
  IncommingCardState() : super([]){
    loadProjects();
  }

  Future<void> loadProjects() async {
    try {
      List<ProjetVoteModel> projects = await projectService.getProjectsWithNoLikes(); // Récupérez tous les projets depuis votre service
      state = projects.map((project) => FundingCardVote(
        projectId: project.id,
        ImagePath: project.imageUrls[0],
        Title: project.titre,
        TitleFunding: '\$ ${project.montantObtenu} fund raised from \$ ${project.montantTotal}',
        ValueFunding: project.montantObtenu / project.montantTotal,
        NumberDonation: 'Unknown Donators', // À ajuster selon votre structure de données
        LikeProjet: "0 Votes",
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

final fundingCardStateProvider = StateNotifierProvider<IncommingCardState, List<Widget>>((ref) {
  return IncommingCardState();
});
