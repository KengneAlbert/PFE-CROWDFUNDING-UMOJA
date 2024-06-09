import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:umoja/generalLayouts/LineCathegoryButton.dart';
import '../SectionBookmarkFundingCard.dart';
import 'BookmarkFundingCard.dart';

class BookmarkPageContaintDetailBody extends StatelessWidget {
    const BookmarkPageContaintDetailBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
        child: Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(height: 20,),

                Container(
                  child: const LineCathegoryButton(),
                ),

                const SizedBox(height: 25,),

                const SectionBookmarkFundingCard(
                  fundCard: [
                    BookmarkFundingCard(
                      ImagePath:"assets/images/3.jpg",
                      Title: "Help Orphanage Children to...",
                      TitleFunding:"\$2,379 fund raised from \$4,200" ,
                      ValueFunding:0.56 ,
                      NumberDonation: "1,280 Donators",
                      Day: "19 days left",
                    ),

                    BookmarkFundingCard(
                      ImagePath:"assets/images/3.jpg",
                      Title: "Help Orphanage Children to...",
                      TitleFunding:"\$2,379 fund raised from \$4,200" ,
                      ValueFunding:0.56 ,
                      NumberDonation: "1,280 Donators",
                      Day: "19 days left",
                    ),
                  ],
                ),

            
              ],
            ),
          ),
        ),
      );
  }
}