import 'package:flutter/widgets.dart';
import 'package:umoja/views/causesocial/SectionCauseSocialCardSearch.dart';
import 'package:umoja/views/generalLayouts/LineInfos.dart';
import 'package:umoja/views/generalLayouts/SearchBar.dart';




class CauseSocialContaint extends StatelessWidget {
    const CauseSocialContaint({Key? key}) : super(key: key);

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

              

           
                Padding(
                  padding: EdgeInsets.all(5),
                  child: SectionCauseSocialCardSearch(),

                ),



            
              ],
            ),
          ),
        ),
      );
  }
}