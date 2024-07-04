import 'package:flutter/widgets.dart';
import 'package:umoja/views/generalLayouts/PrayerCardN.dart';



class PrayersPageContaint extends StatelessWidget {
    const PrayersPageContaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
              children: [
               SizedBox(height: 10,),

               PrayerCardN(),

               SizedBox(height: 10,),

               PrayerCardN(),

               SizedBox(height: 10,),

               PrayerCardN(),

               SizedBox(height: 10,),

               PrayerCardN(),


              ],
             ),
            ),
          ),
        ),
      );
  }
}