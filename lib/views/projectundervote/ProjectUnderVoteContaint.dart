import 'package:flutter/widgets.dart';
import 'package:umoja/views/generalLayouts/FundingCardSearch.dart';
import 'package:umoja/views/projectundervote/SectionFundingCardSearch.dart';
import 'package:umoja/views/projectundervote/layouts/FundingCardSearchVote.dart';
import 'package:umoja/views/projectundervote/layouts/LineCathegoryButton.dart';
import '../generalLayouts/SearchBar.dart';
import '../generalLayouts/LineInfos.dart';


class ProjectUnderVoteContaint extends StatelessWidget {
    const ProjectUnderVoteContaint({Key? key}) : super(key: key);

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

           
                Padding(
                  padding: EdgeInsets.all(5),
                  child: SectionFundingCardSearch(),

                ),



            
              ],
            ),
          ),
        ),
      );
  }
}