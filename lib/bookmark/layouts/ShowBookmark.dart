import 'package:flutter/material.dart';
import 'package:umoja/bookmark/layouts/ActionButton.dart';
import 'package:umoja/bookmark/layouts/BookmarkFundingCard.dart';

class ShowBookmark extends StatelessWidget {

  const ShowBookmark ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

          BookmarkFundingCard(
            ImagePath:"assets/images/3.jpg",
            Title: "Help Orphanage Children to...",
            TitleFunding:"\$2,379 fund raised from \$4,200" ,
            ValueFunding:0.56 ,
            NumberDonation: "1,280 Donators",
            Day: "19 days left",
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