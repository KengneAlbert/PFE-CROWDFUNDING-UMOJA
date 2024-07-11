import 'package:flutter/material.dart';
import 'package:umoja/main.dart';
import 'package:umoja/views/causesocial/CauseSocialPage.dart';
import 'package:umoja/views/homepage/SectionCauseSocial.dart';
import 'package:umoja/views/homepage/SectionIncommingCard.dart';
import 'package:umoja/views/homepage/layouts/LineCathegoryButtonIncomming.dart';
import 'package:umoja/views/projectfundraising/ProjectFundraisingPage.dart';
import 'package:umoja/views/projectunderfunding/ProjectUnderFundingPage.dart';
import 'package:umoja/views/projectundervote/ProjectUnderVotePage.dart';
import 'package:umoja/views/watchImpact/WatchImpact.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'layouts/WalletCard.dart';
import 'layouts/SlideCard.dart';
import 'layouts/CardVideo.dart';
import 'layouts/PrayerCard.dart';
import 'layouts/LineInfos.dart';
import 'layouts/LineCathegoryButton.dart';
import 'layouts/LineCathegoryButtonFunding.dart';
import 'SectionFundingCard.dart';
import 'SectionVoteCard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'SectionCardVideo.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ContainerBody extends ConsumerStatefulWidget {
  const ContainerBody({super.key});

  @override
  _ContainerBodyState createState() => _ContainerBodyState();
}

class _ContainerBodyState extends ConsumerState<ContainerBody> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authViewModelProvider);
    String uid = FirebaseAuth.instance.currentUser!.uid;

    return Container(
    color: Colors.white,  
    child:Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              WalletCard(userId: uid),

              SizedBox(height: 20),
              
              SlideCard(),

              SizedBox(height: 20),

              LineInfos(
                label: "Projects Votes",
                label2: "See all",
                page: ProjectUnderVotePage(),
              ),

              SizedBox(height: 20),

              LineCathegoryButton(),

              SizedBox(height: 20),

              SectionVoteCard(),



              SizedBox(height: 20),

             LineInfos(
                label: "Projects Funding",
                label2: "See all",
                page: ProjectUnderFundingPage(),
              ),

              SizedBox(height: 20),

              LineCathegoryButtonFunding(),


              SizedBox(height: 20,),

 
              SectionFundingCard(),

              SizedBox(height: 20),

              LineInfos(
                  label: "Social Projects",
                  label2: "See all",
                  page: CauseSocialPage(),
                ),


              SizedBox(height: 20,),

              
              SectionCauseSocial(),  
             
              
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

              SectionCardVideo(),

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