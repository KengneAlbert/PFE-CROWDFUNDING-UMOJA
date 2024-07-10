import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/projet_vote_model.dart';
import 'package:umoja/services/CategoryService.dart';
import 'package:umoja/services/ProjetVoteService.dart';
import 'package:umoja/views/search/layouts/FundingCardSearch.dart';
import 'package:umoja/views/search/state/FundingCardSearchState.dart';
import 'package:umoja/views/search/state/SearchState.dart';

class LineCathegoryButtonFunding extends ConsumerWidget {
  const LineCathegoryButtonFunding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedButton = ref.watch(SearchStateProvider);

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
        ref.read(SearchStateProvider.notifier).selectButton(text);
        try {
          final cards = await _getCardsForCategory(text);
          ref.read(FundingCardSearchStateProvider.notifier).updateCards(cards);
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
      List<ProjetVoteModel> projetsAvecPeuDeLikes = await projectService.getProjets();

      if (category == 'All') {
        projects = projetsAvecPeuDeLikes;
      } else {
        final categoryId = await categoryService.getCategoryIDByName(category);
        filteredProjects = projetsAvecPeuDeLikes.where((projet) {
          return projet.categorieId == categoryId;
        }).toList();
      }

      final displayProjects = category == 'All' ? projects : filteredProjects;

      return displayProjects.map((project) {
        return FundingCardSearch(
          ImagePath: project.imageUrls[0],
          Title: project.titre,
          MontFunding: "${project.montantObtenu}",
          TotalMontFunding: "${project.montantTotal}",
          ValueFunding: project.montantObtenu / project.montantTotal,
          NumberDonation: '0',
          Day: "${project.dateFinCollecte.difference(project.dateDebutCollecte).inDays}",
        );
      }).toList();
    } catch (e) {
      print("Error fetching projects: $e");
      return [];
    }
  }
}
