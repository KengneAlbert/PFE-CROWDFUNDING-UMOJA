import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:readmore/readmore.dart';
import 'package:umoja/models/projet_vote_model.dart';
import 'package:umoja/services/ProjetVoteService.dart';
import 'package:umoja/views/generalLayouts/PrayerCardN.dart';
import 'package:umoja/views/projetdetailvote/layouts/LineInfos.dart';
import 'package:umoja/views/projetdetailvote/layouts/LineInfosSimple.dart';
import 'package:umoja/views/projetdocument/ProjectDocument.dart';
import 'package:umoja/views/projetmedia/ProjectMedia.dart';

class ProjetDetailVotePageContaint extends StatelessWidget {
  final String projectId;

  const ProjetDetailVotePageContaint({required this.projectId});

  @override
  Widget build(BuildContext context) {
    final projectService = ProjetVoteService();

    return FutureBuilder<ProjetVoteModel?>(
      future: projectService.getProjetById(projectId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(
            color: Colors.green,
            backgroundColor: Color(0x13B1561A),
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('An error occurred: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No project found'));
        }

        final project = snapshot.data!;
        final titre = project.titre;
        final story = project.histoire;
        final description = project.description;

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: 50, // Hauteur du conteneur pour le texte défilant
                width: double.infinity, // Largeur du conteneur
                child: Marquee(
                  text: titre + " " * 20,
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w600,
                  ),
                  scrollAxis: Axis.horizontal, // Définit l'axe de défilement
                  blankSpace: 20.0, // Espace blanc entre les répétitions de texte
                  velocity: 50.0, // Vitesse de défilement
                  pauseAfterRound: Duration(seconds: 1), // Pause après chaque passage complet
                  startPadding: 10.0, // Espace avant le début du texte
                  accelerationDuration: Duration(seconds: 1), // Durée d'accélération
                  accelerationCurve: Curves.linear, // Courbe d'accélération
                  decelerationDuration: Duration(milliseconds: 500), // Durée de décélération
                  decelerationCurve: Curves.easeOut, // Courbe de décélération
                ),
              ),

              SizedBox(height: 20),

              Text(
                'Story Of Project',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 20),

              Padding(
                padding: EdgeInsets.all(5),
                child: ReadMoreText(
                  story,
                  trimLines: 3,
                  colorClickableText: Colors.blue,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Read more',
                  trimExpandedText: 'Read less',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  moreStyle: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
                  lessStyle: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 20),

              Text(
                'Description Of Project',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 20),

              Padding(
                padding: EdgeInsets.all(5),
                child: ReadMoreText(
                  description,
                  trimLines: 3,
                  colorClickableText: Colors.blue,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Read more',
                  trimExpandedText: 'Read less',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  moreStyle: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
                  lessStyle: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 20),

              Padding(
                padding: EdgeInsets.all(5),
                child: LineInfos(
                  label: 'Authors',
                  label2: 'See infos',
                  page: ProjectDocument(projectId: project.id),
                ),
              ),

              SizedBox(height: 20),

              Padding(
                padding: EdgeInsets.all(5),
                child: LineInfos(
                  label: 'Documents',
                  label2: 'See All',
                  page: ProjectDocument(projectId: project.id),
                ),
              ),

              SizedBox(height: 20),

              Padding(
                padding: EdgeInsets.all(5),
                child: LineInfos(
                  label: 'Medias',
                  label2: 'See All',
                  page: ProjectMedia(projectId: project.id),
                ),
              ),

              SizedBox(height: 20),

               Padding(
                padding: EdgeInsets.all(3),
                child: LineInfosSimple(
                  label: 'Create The',
                  label2: '${project.createdAt.day}/' + '${project.createdAt.month}/' + '${project.createdAt.year}',
                 
                ),
              ),

              SizedBox(height: 20),

              Padding(
                padding: EdgeInsets.all(3),
                child: LineInfosSimple(
                  label: 'Start of collection',
                  label2: '${project.dateDebutCollecte.day}/' + '${project.dateDebutCollecte.month}/' + '${project.dateDebutCollecte.year}',
                  
                ),
              ),

              SizedBox(height: 20),

              Padding(
                padding: EdgeInsets.all(3),
                child: LineInfosSimple(
                  label: 'End of collection',
                  label2: '${project.dateFinCollecte.day}/' + '${project.dateFinCollecte.month}/' + '${project.dateFinCollecte.year}',
                  
                ),
              ),

              SizedBox(height: 20),

              Padding(
                padding: EdgeInsets.all(3),
                child: LineInfosSimple(
                  label: 'Total Amount To Finance',
                  label2: '${project.montantTotal} FCFA',
                 
                ),
              ),
              

              SizedBox(height: 15),


              Padding(
                padding: EdgeInsets.only(left: 5),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      PrayerCardN(),
                      PrayerCardN(),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              
              
            ],
          ),
        );
      },
    );
  }
}
