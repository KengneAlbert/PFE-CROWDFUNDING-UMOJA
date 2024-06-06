import 'package:flutter/widgets.dart';
import '../../generalLayouts/LineCathegoryButton.dart';
import 'SectionBookmarkFundingCard.dart';
import 'layouts/BookmarkFundingCard.dart';

class BookmarkPageContaint extends StatelessWidget {
    const BookmarkPageContaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: 20,),

                Container(
                  child: LineCathegoryButton(),
                ),

                SizedBox(height: 25,),

                SectionBookmarkFundingCard(
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