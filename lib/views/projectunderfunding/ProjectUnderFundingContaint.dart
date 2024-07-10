import 'package:flutter/widgets.dart';
import 'package:umoja/views/generalLayouts/LineInfos.dart';
import 'package:umoja/views/generalLayouts/SearchBar.dart';
import 'package:umoja/views/projectunderfunding/SectionFundingCardSearch.dart';
import 'package:umoja/views/projectunderfunding/layouts/LineCathegoryButton.dart';



class ProjectUnderFundingContaint extends StatelessWidget {
    const ProjectUnderFundingContaint({Key? key}) : super(key: key);

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