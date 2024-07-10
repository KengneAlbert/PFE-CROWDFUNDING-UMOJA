import 'package:flutter/widgets.dart';
import 'package:umoja/views/bookmark/layouts/LineCathegoryButton.dart';
import 'SectionBookmarkFundingCard.dart';


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

                SectionBookmarkFundingCard(),

            
              ],
            ),
          ),
        ),
      );
  }
}