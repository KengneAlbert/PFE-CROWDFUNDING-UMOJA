import 'package:flutter/material.dart';
import 'package:umoja/models/VideoImpact.dart';
import 'package:umoja/services/VideoImpactService.dart';
import 'package:umoja/views/homepage/layouts/CardVideo.dart';
 // Mettez le bon chemin d'importation

class SectionCardVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<VideoImpact>>(
      future: VideoImpactService().getAllVideoImpacts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Aucune vidéo trouvée'));
        } else {
          final videoImpacts = snapshot.data!;
          return Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: videoImpacts.map((videoImpact) {
                      return Row(
                        children: [
                          CardVideo(
                            pathMiniature: videoImpact.miniature,
                            video: videoImpact.video,
                          ),
                          SizedBox(width: 20),
                        ],
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
