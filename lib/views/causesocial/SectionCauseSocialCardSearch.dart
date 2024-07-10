import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/projet_vote_model.dart';
import 'package:umoja/services/CategoryService.dart';
import 'package:umoja/services/ProjetVoteService.dart';
import 'package:umoja/views/projectunderfunding/layouts/FundingCardSearch.dart';
import 'package:umoja/views/projectunderfunding/state/ContaintSeeAllFundingState.dart';


class SectionCauseSocialCardSearch extends ConsumerWidget{
  const SectionCauseSocialCardSearch({Key? key}) : super(key: key);
 
 Future<List<ProjetVoteModel>> _loadProjects() async {
    final projectService = ProjetVoteService();
    final categoryService = CategoryService();

    List<ProjetVoteModel> projetsAvecPeuDeLikes = await projectService.getProjets();
    final categoryId = await categoryService.getCategoryIDByName('Cause Sociale');

    List<ProjetVoteModel> filteredProjects = projetsAvecPeuDeLikes.where((projet) {
      return projet.categorieId == categoryId;
    }).toList();

    return filteredProjects;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fundingCardSearch = ref.watch(ContaintSeeAllFundingStateProvider);
    return FutureBuilder<List<ProjetVoteModel>>(
      future: _loadProjects(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(
            color: Colors.green,
            //backgroundColor: Colors.green,
            ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading projects'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No projects found'));
        } else {
          List<ProjetVoteModel> displayProjects = snapshot.data!;
          return Column(
            children: 
              displayProjects.map((project) {
                return FundingCardSearch(
                        TotalMontFunding: "${project.montantTotal}",
                        MontFunding:  "${project.montantObtenu}",
                        projectId: project.id,
                        ImagePath: project.imageUrls.isNotEmpty ? project.imageUrls[0] : 'assets/images/default_image.jpg',
                        Title: project.titre,
                        //TitleFunding: '\$ ${project.montantObtenu} fund raised from \$ ${project.montantTotal}',
                        ValueFunding: project.montantObtenu / project.montantTotal,
                        NumberDonation: 'Unknown Donators', // Ajustez selon votre structure de données
                        Day: '18 jun', // Ajustez selon votre structure de données
                      );
              }).toList(),
            
          );
        }
      }
    );
    
  }
}