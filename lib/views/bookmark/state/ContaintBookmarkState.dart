import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:umoja/models/projet_vote_model.dart';
import 'package:umoja/services/ProjetVoteService.dart';
import 'package:umoja/views/bookmark/layouts/FundingCard.dart';
import 'package:umoja/views/bookmark/layouts/ShowBookmark.dart';
import 'package:umoja/views/bookmark/layouts/ShowBookmarkFunding.dart';
import '../layouts/FundingCardVote.dart';

class ContaintBookmarkState extends StateNotifier<List<Widget>> {
  final projectService = ProjetVoteService(); // Initialisez votre service de projets
  ContaintBookmarkState() : super([]){
    loadProjects();
  }

  Future<void> loadProjects() async {
    try {
      List<String> favory = await projectService.getUserFavorites('bkqNhz3pigQFm05XMIOLutyivEx1');
      List<ProjetVoteModel> projects = await projectService.getProjetsByIds(favory); // Récupérez tous les projets depuis votre service
      
      state = projects.map((project) {
      if (project.likes.length <= 3) {
        return FundingCardVote(
          projectId: project.id,
          ImagePath: project.imageUrls.isNotEmpty ? project.imageUrls[0] : 'default_image_path',
          Title: project.titre,
          TitleFunding: '\$ ${project.montantObtenu} fund raised from \$ ${project.montantTotal}',
          ValueFunding: project.montantObtenu / project.montantTotal,
          NumberDonation: 'Unknown Donators', // À ajuster selon votre structure de données
          LikeProjet: "Votes",
          ShowBookmark: ShowBookmark(
            projectId: project.id,
            ImagePath: project.imageUrls.isNotEmpty ? project.imageUrls[0] : 'default_image_path',
            Title: project.titre,
            TitleFunding: '\$ ${project.montantObtenu} fund raised from \$ ${project.montantTotal}',
            ValueFunding: project.montantObtenu / project.montantTotal,
            NumberDonation: 'Unknown Donators',
            LikeProjet: "Votes",
          ),
        );
      } else {
        return FundingCard(
          projectId: project.id,
          ImagePath: project.imageUrls.isNotEmpty ? project.imageUrls[0] : 'default_image_path',
          Title: project.titre,
          TitleFunding: '\$ ${project.montantObtenu} fund raised from \$ ${project.montantTotal}',
          ValueFunding: project.montantObtenu / project.montantTotal,
          NumberDonation: 'Unknown Donators', // À ajuster selon votre structure de données
          Day: 'gfgfg',
          ShowBookmark: ShowBookmarkFunding(
            projectId: project.id,
            ImagePath: project.imageUrls.isNotEmpty ? project.imageUrls[0] : 'default_image_path',
            Title: project.titre,
            TitleFunding: '\$ ${project.montantObtenu} fund raised from \$ ${project.montantTotal}',
            ValueFunding: project.montantObtenu / project.montantTotal,
            NumberDonation: 'Unknown Donators',
            LikeProjet: "Votes",
            Day: project.createdAt
          ),
        );
      }
    }).toList();
    
    } catch (e) {
      print('Error loading projects: $e');
      // Gérez les erreurs ici si nécessaire
    }
  }

  void updateCards(List<Widget> newCards) {
    state = newCards;
  }
}

final containtBookmarkStateProvider = StateNotifierProvider<ContaintBookmarkState, List<Widget>>((ref) {
  return ContaintBookmarkState();
});
