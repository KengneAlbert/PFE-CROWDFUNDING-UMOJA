import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:umoja/models/projet_vote_model.dart';
import 'package:umoja/services/ProjetVoteService.dart';
import 'package:umoja/views/generalLayouts/PrayerCardN.dart';
import 'package:umoja/views/projetdetail/layouts/LineInfos.dart';
import 'package:umoja/views/projetdetail/layouts/ProjetCard.dart';
import 'package:umoja/views/projetdetailvote/layouts/LineInfosSimple.dart';
import 'package:umoja/views/projetdocument/ProjectDocument.dart';
import 'package:umoja/views/projetmedia/ProjectMedia.dart';

class ProjetDetailPageContaint extends StatelessWidget {
  final String projectId;

  ProjetDetailPageContaint({required this.projectId});

  @override
  Widget build(BuildContext context) {
    final projectService = ProjetVoteService();

    return FutureBuilder<ProjetVoteModel?>(
      future: projectService.getProjetById(projectId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading project'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No project found'));
        } else {
          final project = snapshot.data!;
          final daysRemaining = project.dateFinCollecte.difference(project.dateDebutCollecte).inDays;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ProjetCard(
                  Title: project.titre + " " * 20,
                  TitleFunding: "${project.montantObtenu} fund raised from ${project.montantTotal}",
                  ValueFunding: project.montantObtenu / project.montantTotal,
                  NumberDonation: "0 contributors",
                  Day: "$daysRemaining days remaining",
                  projectId: projectId,
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
                    project.histoire,
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
                    project.description,
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
                  label: 'Media',
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
              ],
            ),
          );
        }
      },
    );
  }
}
