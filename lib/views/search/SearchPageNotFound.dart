import 'package:flutter/widgets.dart';
import '../generalLayouts/LineCathegoryButton.dart';
import 'layouts/SearchBar.dart';
import 'layouts/LineInfos.dart';

class SearchPageNotFound extends StatelessWidget {
    const SearchPageNotFound({Key? key}) : super(key: key);

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

                SizedBox(height: 100,),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/anysearch.png"
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