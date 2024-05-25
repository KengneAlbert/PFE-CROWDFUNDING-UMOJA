import 'package:flutter/widgets.dart';
import 'package:umoja/search/layouts/FundingCardSearch.dart';
import '../generalLayouts/LineCathegoryButton.dart';
import '../generalLayouts/SearchBar.dart';
import '../generalLayouts/LineInfos.dart';
import '../generalLayouts/SectionFundingCardSearch.dart';


class ComingToAnEndContaint extends StatelessWidget {
    const ComingToAnEndContaint({Key? key}) : super(key: key);

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
                  child: SectionFundingCardSearch(
                    fundingCardSearch: [
                      FundingCardSearch(
                        ImagePath: "assets/images/3.jpg",
                        Title: "Lorem Ipsum Dolor Sit Amet",
                        MontFunding: "\$2,379",
                        TotalMontFunding: "\$4,000",
                        ValueFunding: 0.50,
                        NumberDonation: "4,143",
                        Day: "21",
                      ),

                      SizedBox(height: 10,),

                      FundingCardSearch(
                        ImagePath: "assets/images/3.jpg",
                        Title: "Lorem Ipsum Dolor Sit Amet",
                        MontFunding: "\$2,379",
                        TotalMontFunding: "\$4,000",
                        ValueFunding: 0.50,
                        NumberDonation: "4,143",
                        Day: "21",
                      ),

                      SizedBox(height: 10,),

                      FundingCardSearch(
                        ImagePath: "assets/images/3.jpg",
                        Title: "Lorem Ipsum Dolor Sit Amet",
                        MontFunding: "\$2,379",
                        TotalMontFunding: "\$4,000",
                        ValueFunding: 0.50,
                        NumberDonation: "4,143",
                        Day: "21",
                      ),
                    ],
                  ),

                ),



            
              ],
            ),
          ),
        ),
      );
  }
}