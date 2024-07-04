
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/projet_vote_model.dart';
import 'package:umoja/views/homepage/layouts/FundingCard.dart';
import 'package:umoja/views/homepage/layouts/FundingCardVote.dart';
import "package:umoja/services/ProjetVoteService.dart";
import "package:umoja/services/CategoryService.dart";
import '../state/ButtonStateIncomming.dart';
import '../state/IncommingCardState.dart';

class LineCathegoryButtonIncomming extends ConsumerWidget {
  const LineCathegoryButtonIncomming({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedButton = ref.watch(buttonStateProvider);

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
        ref.read(buttonStateProvider.notifier).selectButton(text);
        try {
          final cards = await _getCardsForCategory(text);
          ref.read(fundingCardStateProvider.notifier).updateCards(cards);
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

  List<ProjetVoteModel> projects = [];
  List<ProjetVoteModel> filteredProjects = [];

  try {
    // Récupérer les projets no projets
    List<ProjetVoteModel> projetsAvecPeuDeLikes = await projectService.getProjectsWithNoLikes();

    if (category == 'All') {
      // Utiliser les projets avec peu de likes
      projects = projetsAvecPeuDeLikes;
    } else {
      // Récupérer l'ID de la catégorie
      final categoryId = await categoryService.getCategoryIDByName(category);

      // Filtrer les projets avec peu de likes par catégorie
      filteredProjects = projetsAvecPeuDeLikes.where((projet) {
        return projet.categorieId == categoryId;
      }).toList();
      
    }

    // Utiliser filteredProjects ou projects selon la condition
    final displayProjects = category == 'All' ? projects : filteredProjects;

    return displayProjects.map((project) {
      return FundingCardVote(
        projectId: project.id,
        ImagePath: project.imageUrls[0],
        Title: project.titre,
        TitleFunding: '\$ ${project.montantObtenu} fund raised from \$ ${project.montantTotal}',
        ValueFunding: project.montantObtenu / project.montantTotal,
        NumberDonation: 'Unknown Donators', // Ajustez selon votre structure de données
        LikeProjet: "Votes",
      );
    }).toList();
  } catch (e) {
    print("Error fetching projects: $e");
    return [];
  }
}


}