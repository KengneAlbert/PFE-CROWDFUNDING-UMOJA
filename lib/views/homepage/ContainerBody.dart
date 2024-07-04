import 'package:flutter/material.dart';
import 'package:umoja/views/homepage/SectionIncommingCard.dart';
import 'package:umoja/views/homepage/layouts/LineCathegoryButtonIncomming.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'layouts/WalletCard.dart';
import 'layouts/SlideCard.dart';
import 'layouts/CardVideo.dart';
import 'layouts/PrayerCard.dart';
import 'layouts/LineInfos.dart';
import 'layouts/LineCathegoryButton.dart';
import 'layouts/LineCathegoryButtonFunding.dart';
import 'layouts/FundingCard.dart';
import 'layouts/FundingCardVote.dart';
import 'SectionFundingCard.dart';
import 'SectionVoteCard.dart';
import 'SectionCardVideo.dart';
import '../projectundervote/ProjectUnderVotePage.dart';
import '../Comingtoanend/ComingToAnEndPage.dart';
import '../watchImpact/WatchImpact.dart';
import '../projectfundraising/ProjectFundraisingPage.dart';

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
                label: "Project Under Vote",
                label2: "See all",
                page: ProjectUnderVotePage(),
              ),

              SizedBox(height: 20),

              LineCathegoryButton(),

              SizedBox(height: 20),

              SectionVoteCard(),



              SizedBox(height: 20),

             LineInfos(
                label: "Project Under Funding",
                label2: "See all",
                page: ComingToAnEndPage(),
              ),

              SizedBox(height: 20),

              LineCathegoryButtonFunding(),


              SizedBox(height: 20,),

 
              SectionFundingCard(),
             
              
              SizedBox(height: 20,),

              LineInfos(
                label: "Project Incomming",
                label2: "See all",
                page: ProjectFundraisingPage(),
              ),

              SizedBox(height: 20,),

              LineCathegoryButtonIncomming(),


              SizedBox(height: 20,),

 
              SectionIncommingCard(),

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
                    pathMiniature:'assets/images/Group.png',
                  ),

                  SizedBox(width: 20,),

                  CardVideo(
                    pathMiniature:'assets/images/Group.png',
                  ),

                  SizedBox(width: 20,),

                  CardVideo(
                    pathMiniature:'assets/images/Group.png',
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