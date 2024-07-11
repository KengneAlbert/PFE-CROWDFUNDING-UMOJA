import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/projet_vote_model.dart';
import 'package:umoja/services/CategoryService.dart';
import 'package:umoja/services/ProjetVoteService.dart';
import 'package:umoja/views/homepage/layouts/FundingCardVote.dart';
import '../state/ButtonStateNotifier.dart';
import '../state/FundingCardStateNotifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LineCathegoryButton extends ConsumerWidget {
  const LineCathegoryButton({Key? key}) : super(key: key);

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
  final int votes = 0;

  List<ProjetVoteModel> projects = [];
  List<ProjetVoteModel> filteredProjects = [];

  try {
    // Récupérer les projets avec moins de 3 likes
    List<ProjetVoteModel> projetsAvecPeuDeLikes = await projectService.getProjetsWithFewLikes(3);

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

    List<Widget> cards = await Future.wait(displayProjects.map((project) async {
        int votes = await projectService.getTotalLikes(project.id);
        return FundingCardVote(
          projectId: project.id,
          ImagePath: project.imageUrls[0],
          Title: project.titre,
          TitleFunding: '\$ ${project.montantObtenu} fund raised from \$ ${project.montantTotal}',
          ValueFunding: project.montantObtenu / project.montantTotal,
          NumberDonation: '0 Donators', // Ajustez selon votre structure de données
          LikeProjet: "$votes Votes",
        );
      }).toList());

      return cards;
    } catch (e) {
      print("Error fetching projects: $e");
      return [];
    }
  }

}
