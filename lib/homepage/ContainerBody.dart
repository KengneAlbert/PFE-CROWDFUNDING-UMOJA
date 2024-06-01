import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'layouts/WalletCard.dart';
import 'layouts/SlideCard.dart';
import 'layouts/CardVideo.dart';
import 'layouts/PrayerCard.dart';
import 'layouts/LineInfos.dart';
import '../generalLayouts/LineCathegoryButton.dart';
import 'layouts/FundingCard.dart';
import 'SectionFundingCard.dart';
import 'SectionCardVideo.dart';
import '../urgentFundraising/UrgentFundraisingPage.dart';
import '../Comingtoanend/ComingToAnEndPage.dart';
import '../watchImpact/WatchImpact.dart';

class ContainerBody extends StatelessWidget {
  const ContainerBody({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
    color: Colors.white,  
    child:Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              WalletCard(),

              SizedBox(height: 20),
              
              SlideCard(),

              SizedBox(height: 20),

              LineInfos(
                label: "Urgent Fundraising",
                label2: "See all",
                page: UrgentFundraisingPage(),
              ),

              SizedBox(height: 20),

              LineCathegoryButton(),

              SizedBox(height: 20),

              SectionFundingCard(
                fundCard: [
                  FundingCard(
                    ImagePath:"assets/images/3.jpg",
                    Title: "Help Orphanage Children to...",
                    TitleFunding:"\$2,379 fund raised from \$4,200" ,
                    ValueFunding:0.56 ,
                    NumberDonation: "1,280 Donators",
                    Day: "19 days left",
                  ),
                  FundingCard(
                    ImagePath:"assets/images/3.jpg",
                    Title: "Help Orphanage Children to...",
                    TitleFunding:"\$2,379 fund raised from \$4,200" ,
                    ValueFunding:0.56 ,
                    NumberDonation: "1,280 Donators",
                    Day: "19 days left",
                  ),
                ]
              ),



              SizedBox(height: 20),

             LineInfos(
                label: "Coming to an end",
                label2: "See all",
                page: ComingToAnEndPage(),
              ),


              SizedBox(height: 20,),

              SectionFundingCard(
                  fundCard: [
                    FundingCard(
                      ImagePath:"assets/images/3.jpg",
                      Title: "Help Orphanage Children to...",
                      TitleFunding:"\$2,379 fund raised from \$4,200" ,
                      ValueFunding:0.50 ,
                      NumberDonation: "1,280 Donators",
                      Day: "19 days left",
                    ),
                    FundingCard(
                      ImagePath:"assets/images/3.jpg",
                      Title: "Help Orphanage Children to...",
                      TitleFunding:"\$2,379 fund raised from \$4,200" ,
                      ValueFunding:0.50 ,
                      NumberDonation: "1,280 Donators",
                      Day: "19 days left",
                    ),
                  ],
              ),

             
              
              SizedBox(height: 20,),

              LineInfos(
                label: "Watch the Impact of Your Donation",
                label2: "See all",
                page: WatchImpact(),
              ),

              SizedBox(height: 20,),

              SectionCardVideo(
                cardVideo: [

                  CardVideo(
                    pathMiniature:'assets/images/téléchargement (5).jfif',
                  ),

                  SizedBox(width: 20,),

                  CardVideo(
                    pathMiniature:'assets/images/téléchargement (5).jfif',
                  )

                ],
              ),

              SizedBox(height: 20,),
            
              PrayerCard(),

            ],
          ),
        ),
      ),
    ),
    );
    
  }
}