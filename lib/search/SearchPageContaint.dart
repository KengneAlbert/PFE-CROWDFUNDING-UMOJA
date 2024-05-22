import 'package:flutter/widgets.dart';
import 'package:umoja/search/layouts/FundingCardSearch.dart';
import '../generalLayouts/LineCathegoryButton.dart';
import 'layouts/SearchBar.dart';
import 'layouts/LineInfos.dart';

class SearchPageContaint extends StatelessWidget {
    const SearchPageContaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: 20,),


                SearchBar(),

                SizedBox(height: 25,),

                LineInfos(
                  label: '0 found',
                ),


                SizedBox(height: 25,),

                Container(
                  child: LineCathegoryButton(),
                ),

                SizedBox(height: 25,),

                FundingCardSearch(),




            
              ],
            ),
          ),
        ),
      );
  }
}