import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/views/homepage/state/FavoryButtonState.dart';
import 'package:umoja/views/homepage/state/LikeButtonState.dart';

class FundingCardSearchVote extends ConsumerWidget{

  final String ImagePath;
  final String Title;
  final String projectId;
  final String LikeProjet;

       const FundingCardSearchVote(
        {
          required this.ImagePath,
          required this.Title, 
          required this.projectId,
          required this.LikeProjet,
          
      }
     );

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

  Future<void> _addFavorite(BuildContext context, WidgetRef ref) async {
    final userId = 'bkqNhz3pigQFm05XMIOLutyivEx1'; // Remplacez par l'ID utilisateur approprié
    final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

    try {
      final userSnapshot = await userDoc.get();
      final userData = userSnapshot.data() as Map<String, dynamic>;
      List<dynamic> favory = userData['favory'] ?? [];

      if (favory.contains(projectId)) {
        // Remove like
        ref.read(favoryProvider.notifier).firstFavory(projectId);
        favory.remove(projectId);
      } else {
        // Add like
        favory.add(projectId);
      }

      await userDoc.update({'favory': favory});

      // Toggle the icon state
      ref.read(favoryProvider.notifier).toggleFavory(projectId);
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

  Future<void> _getfavories(BuildContext context, WidgetRef ref) async {
    final userId = 'bkqNhz3pigQFm05XMIOLutyivEx1';
    final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
    final userSnapshot = await userDoc.get();
    final userData = userSnapshot.data() as Map<String, dynamic>;
    List<dynamic> favory = userData['favory'] ?? [];

    if (favory.contains(projectId)) {
        // Remove like
        ref.read(favoryProvider.notifier).setFavory(projectId,true);
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
    final isFavorised = ref.watch(favoryProvider).containsKey(projectId) && ref.watch(favoryProvider)[projectId]!;
    _getlikes(context, ref);
    _getfavories(context, ref);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
          children: [
            Container(
              width: 120,
              height: 131.53846740722656,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.zero,
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.zero,
                ),
                child: Image.network(
                  ImagePath,
                  width: 120,
                  height: 131.53846740722656,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/notfoundimage.png', // Chemin vers votre image par défaut
                      width: 120,
                      height: 131.53846740722656,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),

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

                  

                ],
              ),
            ),
          ],
        ),
      
    );


   }
}