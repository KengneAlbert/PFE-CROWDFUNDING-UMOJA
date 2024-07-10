import 'package:flutter/material.dart';
import 'package:umoja/models/projet_vote_model.dart';
import 'package:umoja/services/CategoryService.dart';
import 'package:umoja/services/ProjetVoteService.dart';
import 'package:umoja/views/homepage/layouts/FundingCard.dart';

class SectionCauseSocial extends StatelessWidget {
  const SectionCauseSocial({Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
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
          return Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: displayProjects.map((project) {
                      return FundingCard(
                        projectId: project.id,
                        ImagePath: project.imageUrls.isNotEmpty ? project.imageUrls[0] : 'assets/images/default_image.jpg',
                        Title: project.titre,
                        TitleFunding: '\$ ${project.montantObtenu} fund raised from \$ ${project.montantTotal}',
                        ValueFunding: project.montantObtenu / project.montantTotal,
                        NumberDonation: '0 contributors', // Ajustez selon votre structure de données
                        Day: "${project.dateFinCollecte.difference(project.dateDebutCollecte).inDays} Day Missing", // Ajustez selon votre structure de données
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
