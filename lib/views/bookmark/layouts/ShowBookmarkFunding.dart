import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/views/bookmark/layouts/ActionButton.dart';
import 'package:umoja/views/bookmark/layouts/BookmarkFundingCard.dart';
import 'package:umoja/views/bookmark/layouts/FundingCardD.dart';
import 'package:umoja/views/bookmark/layouts/FundingCardVote.dart';
import 'package:umoja/views/bookmark/layouts/FundingCardVoteD.dart';

class ShowBookmarkFunding extends ConsumerWidget{

  final String projectId;
  final String ImagePath;
  final String Title;
  final String TitleFunding;
  final double ValueFunding;
  final String NumberDonation;
  final String LikeProjet;
  final DateTime Day;

  const ShowBookmarkFunding({
    required this.projectId,
    required this.ImagePath,
    required this.Title,
    required this.TitleFunding,
    required this.ValueFunding,
    required this.NumberDonation,
    required this.LikeProjet,
    required this.Day
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        children: [

          FundingCardD(
            ImagePath: ImagePath,
            Title: Title,
            TitleFunding: TitleFunding ,
            ValueFunding: ValueFunding,
            NumberDonation: NumberDonation,
            Day: '$Day',
            projectId: projectId,
          ) ,

          SizedBox(height: 20,),

          Center(
           child:  Text('Remove from your bookmark?'),
          ),

          SizedBox(height: 20,),

          ActionButton(),

        ],
      )
      );
  }

}