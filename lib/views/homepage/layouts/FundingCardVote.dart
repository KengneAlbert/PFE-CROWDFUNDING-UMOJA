import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/views/homepage/layouts/BookmarkButton.dart';
import 'package:umoja/views/homepage/state/LikeButtonState.dart';
import 'package:umoja/views/projetdetailvote/ProjetDetailVotePage.dart';
import '../../bookmark/BookmarkPage.dart';

class FundingCardVote extends ConsumerWidget {
  final String projectId;
  final String ImagePath;
  final String Title;
  final String TitleFunding;
  final double ValueFunding;
  final String NumberDonation;
  final String LikeProjet;

  const FundingCardVote({
    required this.projectId,
    required this.ImagePath,
    required this.Title,
    required this.TitleFunding,
    required this.ValueFunding,
    required this.NumberDonation,
    required this.LikeProjet,
  });

  Future<void> _handleLikeButtonPress(BuildContext context, WidgetRef ref) async {
    final userId = 'bkqNhz3pigQFm05XMIOLutyivEx1'; // Remplacez par l'ID utilisateur approprié
    final projectDoc = FirebaseFirestore.instance.collection('Projets').doc(projectId);

    try {
      final projectSnapshot = await projectDoc.get();
      final projectData = projectSnapshot.data() as Map<String, dynamic>;
      List<dynamic> likes = projectData['likes'] ?? [];

      if (likes.contains(userId)) {
        // Remove like
        ref.read(likeProvider.notifier).firstLike(projectId);
        likes.remove(userId);
      } else {
        // Add like
        likes.add(userId);
      }

      await projectDoc.update({'likes': likes});

      // Toggle the icon state
      ref.read(likeProvider.notifier).toggleLike(projectId);
    } catch (e) {
      print('Error updating likes: $e');
    }

  }

  Future<void> _getlikes(BuildContext context, WidgetRef ref) async {
    final userId = 'bkqNhz3pigQFm05XMIOLutyivEx1';
    final projectDoc = FirebaseFirestore.instance.collection('Projets').doc(projectId);
    final projectSnapshot = await projectDoc.get();
    final projectData = projectSnapshot.data() as Map<String, dynamic>;
    List<dynamic> likes = projectData['likes'] ?? [];

    if (likes.contains(userId)) {
        // Remove like
        ref.read(likeProvider.notifier).setLike(projectId,true);
      } else {
        // Add like
        //ref.read(likeProvider.notifier).setLike(projectId,false);
      }
  }

  Future<String> _getLikesCount() async {
    final projectDoc = FirebaseFirestore.instance.collection('Projets').doc(projectId);
    final projectSnapshot = await projectDoc.get();
    final projectData = projectSnapshot.data() as Map<String, dynamic>;
    List<dynamic> likes = projectData['likes'] ?? [];
    return "${likes.length} Votes";
  }
  
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLiked = ref.watch(likeProvider).containsKey(projectId) && ref.watch(likeProvider)[projectId]!;
    _getlikes(context, ref);
    
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => ProjetDetailVotePage(),
          ),
        );
      },
      child: Card(
        child: Container(
          width: 290,
          height: 260,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                    child: Image.network(
                      ImagePath,
                      height: 160,
                      width: 290,
                      fit: BoxFit.cover,
                    ),
                  ),
                  BookmarkButton()
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      Title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Wrap(
                          children: [
                            GestureDetector(
                              onTap: () => _handleLikeButtonPress(context, ref),
                              child: Icon(
                                isLiked ? Icons.thumb_up : Icons.thumb_up_off_alt,
                                color: Colors.green,
                                size: 25,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              LikeProjet,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => ProjetDetailVotePage(),
                              ),
                            );
                          },
                          child: Text(
                            'See all Detail',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
