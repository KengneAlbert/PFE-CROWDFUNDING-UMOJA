import 'package:flutter/material.dart';
import 'layouts/TopUpSuccess.dart';
import 'layouts/DonationCanceled.dart';
import 'layouts/FeaturesAvailable.dart';

class NotificationPageContaint extends StatelessWidget{
  const NotificationPageContaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [

              Container(
                child:Text(
                "Today, December 25 2023",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400
                 ),
                ),
              ),

              SizedBox(height: 20,),

              TopUpSuccess(
                title: 'Top up Successful!',
                containt: 'You have successfully top up your wallet in the amount of \$100',
              ),

              SizedBox(height: 20,),

              DonationCanceled(
                title: 'Donation Canceled!',
                containt : 'You cancel donations for victims of natural disasters',
              ),
              

              SizedBox(height: 20,),


              Container(
                child:Text(
                "Yesterday, December 24 2023",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400
                 ),
                ),
              ),

              SizedBox(height: 20,),

              FeaturesAvailable(
                title: 'New Features Available',
                containt: 'You can now invite your friends to join donation with you',
              ),


              SizedBox(height: 20,),


               Container(
                child:Text(
                "Monday, December 23 2023",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400
                 ),
                ),
              ),

              SizedBox(height: 20,),


              TopUpSuccess(
                title: 'Top up Successful!',
                containt: 'You have successfully top up your wallet in the amount of \$80',
              ),

              SizedBox(height: 20,),

              DonationCanceled(
                title: 'Donation Canceled!',
                containt : 'You cancel donations for victims of natural disasters',
              ),

            ],
          ),
        ),
      ),
    );
  }

}