import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/projet_vote_model.dart';
import 'package:umoja/services/CategoryService.dart';
import 'package:umoja/services/ProjetVoteService.dart';
import 'package:umoja/views/bookmark/layouts/FundingCard.dart';
import 'package:umoja/views/bookmark/layouts/FundingCardVote.dart';
import 'package:umoja/views/bookmark/layouts/ShowBookmark.dart';
import 'package:umoja/views/bookmark/state/ButtonBookmarkState.dart';
import 'package:umoja/views/bookmark/state/ContaintBookmarkState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LineCathegoryButton extends ConsumerWidget {
  const LineCathegoryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedButton = ref.watch(buttonBookmarkStateProvider);

    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 5,
              children: [
                _buildButton(ref, 'All', selectedButton),
                _buildButton(ref, 'Agriculture', selectedButton),
                _buildButton(ref, 'Education', selectedButton),
                _buildButton(ref, 'Cause Sociale', selectedButton),
                _buildButton(ref, 'Medical', selectedButton),
                _buildButton(ref, 'Technologie', selectedButton),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ElevatedButton _buildButton(WidgetRef ref, String text, String selectedButton) {
    final isSelected = text == selectedButton;
    return ElevatedButton(
      onPressed: () async {
        ref.read(buttonBookmarkStateProvider.notifier).selectButton(text);
        try {
          final cards = await _getCardsForCategory(text);
          ref.read(containtBookmarkStateProvider.notifier).updateCards(cards);
        } catch (e) {
          print("Error fetching cards for category $text: $e");
        }
      },
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.green,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.green : Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(
            color: Colors.green,
            width: 3,
          ),
        ),
      ),
    );
  }

  Future<List<Widget>> _getCardsForCategory(String category) async {
  final projectService = ProjetVoteService();
  final categoryService = CategoryService();
  final int votes = 0;

  
  List<ProjetVoteModel> filteredProjects = [];
  List<String> favory = await projectService.getUserFavorites('bkqNhz3pigQFm05XMIOLutyivEx1');
  List<ProjetVoteModel> projects = [];

  try {
   

    if (category == 'All') {
      // Utiliser les projets avec peu de likes
      projects = await projectService.getProjetsByIds(favory);
    } else {
      // Récupérer l'ID de la catégorie
      final categoryId = await categoryService.getCategoryIDByName(category);

      // Filtrer les projets avec peu de likes par catégorie
      filteredProjects = projects.where((projet) {
        return projet.categorieId == categoryId;
      }).toList();
      
    }

    // Utiliser filteredProjects ou projects selon la condition
    final displayProjects = category == 'All' ? projects : filteredProjects;

    List<Widget> cards = await Future.wait(displayProjects.map((project) async {
        int votes = await projectService.getTotalLikes(project.id);

        if (votes <= 3) {
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
        }else {
          return FundingCard(
            projectId: project.id,
            ImagePath: project.imageUrls.isNotEmpty ? project.imageUrls[0] : 'default_image_path',
            Title: project.titre,
            TitleFunding: '\$ ${project.montantObtenu} fund raised from \$ ${project.montantTotal}',
            ValueFunding: project.montantObtenu / project.montantTotal,
            NumberDonation: 'Unknown Donators', // À ajuster selon votre structure de données
            Day: 'gfgfg',
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
      }
    }).toList());
        
    

      return cards;
    } catch (e) {
      print("Error fetching projects: $e");
      return [];
    }
  }

}
