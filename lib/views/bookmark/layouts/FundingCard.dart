//import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/views/homepage/state/FavoryButtonState.dart';
import 'package:umoja/views/projetdetail/ProjetDetailPage.dart';

class FundingCard extends ConsumerWidget {
  final String projectId;
  final String ImagePath;
  final String Title;
  final String TitleFunding;
  final double ValueFunding;
  final String NumberDonation;
  final String Day;
  final Widget ShowBookmark;

     const FundingCard(
      {
         required this.projectId,
         required this.ImagePath,
         required this.Title, 
         required this.TitleFunding, 
         required this.ValueFunding, 
         required this.NumberDonation, 
         required this.Day, 
         required this.ShowBookmark,
     }
     );

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

  @override 
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorised = ref.watch(favoryProvider).containsKey(projectId) && ref.watch(favoryProvider)[projectId]!;
    _getfavories(context, ref);
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) =>   ProjetDetailPage(projectId: projectId,),
          )
        );
      },
      child: Card(
                            child: Container(
                                width: 380,
                                height: 300,
                                child:Column(
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
                                        child:Image.network(
                                          ImagePath,
                                          height: 160,
                                          width: 380,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/notfoundimage.png', // Chemin vers votre image par défaut
                                              height: 160,
                                              width: 380,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                      ),
                                      Positioned(
                                          top: 10,
                                          right: 8,
                                          child:GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(context: context, builder: (ctx) => ShowBookmark);
                                            },
                                            child:  Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF13B156).withOpacity(1), // Couleur de fond
                                                borderRadius: BorderRadius.circular(12), // Bordure arrondie
                                              ),
                                              child: Center(
                                                child: SizedBox(
                                                width: 24,
                                                height: 24,
                                                child: Icon(
                                                  Icons.bookmark,
                                                  color: Colors.white,
                                                  size: 25,
                                                  ), 
                                                ),
                                              )
                                            ),
                                          ),
                                      ),
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
                                        SizedBox(height: 8),
                                        Text(
                                          TitleFunding,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.green,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        LinearProgressIndicator(
                                          value: ValueFunding, // Calculate the percentage raised
                                          backgroundColor: Colors.grey[300],
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              NumberDonation,
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              Day,
                                              style: TextStyle(
                                                fontSize: 14,
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