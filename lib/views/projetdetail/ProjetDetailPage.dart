import 'package:flutter/material.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:umoja/models/projet_vote_model.dart';
import 'package:umoja/services/ProjetVoteService.dart';
import 'package:umoja/views/homepage/HomePage.dart';
import 'package:umoja/views/projetdetail/ProjetDetailPageContaint.dart';
import '../generalLayouts/ContainerBottom.dart';

class ProjetDetailPage extends StatelessWidget {
  final String projectId;

  ProjetDetailPage({required this.projectId});

  @override
  Widget build(BuildContext context) {
    final projectService = ProjetVoteService();

    return FutureBuilder<ProjetVoteModel?>(
      future: projectService.getProjetById(projectId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Loading...'),
            ),
            body: Center(child: CircularProgressIndicator(
              color: Colors.green,
              backgroundColor: Color(0x13B1561A),
            )),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Error'),
            ),
            body: Center(child: Text('Error loading project')),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text('No Project'),
            ),
            body: Center(child: Text('No project found')),
          );
        } else {
          final ProjetVoteModel? project = snapshot.data;
          final imageUrls = project?.imageUrls ?? [];
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 350.0,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    //title: Text('Projet Detail Vote'),
                    background: AnotherCarousel(
                      indicatorBgPadding: 10.0,
                      images: imageUrls.map((url) {
                        return ClipRRect(
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/available.png',
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => HomePage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white, // Couleur de fond
                          borderRadius: BorderRadius.circular(12), // Bordure arrondie
                        ),
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white, // Couleur de fond
                            borderRadius: BorderRadius.circular(12), // Bordure arrondie
                          ),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: Icon(
                              Icons.share,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white, // Couleur de fond
                            borderRadius: BorderRadius.circular(12), // Bordure arrondie
                          ),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: Icon(
                              Icons.bookmark_border,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: ProjetDetailPageContaint(projectId: projectId),
                ),
              ],
            ),
            bottomNavigationBar: ContainerBottom(),
          );
        }
      },
    );
  }
}
