import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:umoja/views/generalLayouts/PrayerCardN.dart';
import 'package:umoja/views/projetdetail/layouts/CardProjet.dart';
import 'package:umoja/views/projetdetail/layouts/CardProjetHome.dart';
import 'package:umoja/views/projetdetail/layouts/LineInfos.dart';
import 'package:umoja/views/projetdetail/layouts/LineInfosbutton.dart';
import 'package:umoja/views/projetdetail/layouts/ProjetCard.dart';


class ProjetDetailPageContaint extends StatelessWidget{
  const ProjetDetailPageContaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [

            ProjetCard(
              Title: "Help Siamese Twins Surgery",
              TitleFunding: "\$6,679 fund raised from \$8,200",
              ValueFunding: 0.5,
              NumberDonation: "3,438 Donators",
              Day: "11 days left",
            ),

            SizedBox(height: 20,),

            Text(
              'Fundraiser',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(5),
              child: CardProjetHome(
                imagePath: "assets/images/health.png",
                title: 'Healthy Home',
                smallTitle: 'Verified',
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(
                left: 15,
              ),
              child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  'Patient',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.all(5),
              child: CardProjet(
                imagePath: "assets/images/health.png",
                title: 'Alice Wilson',
                smallTitle: 'Identity ',
              ),
            ),

            Padding(
              padding: EdgeInsets.all(5),
              child: CardProjet(
                imagePath: "assets/images/health.png",
                title: 'Post Craniotomy EDH + ICH',
                smallTitle: 'Accompanied',
              ),
            ),

            SizedBox(
              height: 10,
            ),

            LineInfosbutton(
              label: 'Fund Usage Plan',
            ),

            SizedBox(
              height: 15,
            ),

            Padding(
              padding: EdgeInsets.only(
                left: 15,
              ),
              child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  'Story',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 15,
            ),

            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut Read more...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            LineInfos(
              label: 'Prayers',
              label2: 'See all',
            ),

            SizedBox(
              height: 15,
            ),

            Padding(
              padding: EdgeInsets.only(
                left: 5,
              ),

              child: Stack(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          PrayerCardN(),
                          PrayerCardN(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
             


            

                                        
          ],
        ),
      ),
    );
  }
}