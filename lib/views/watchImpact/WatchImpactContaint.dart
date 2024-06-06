import 'package:flutter/material.dart';
import '../../generalLayouts/ContainerBottom.dart';
import 'SectionWatch.dart';
import '../../generalLayouts/CardVideo.dart';

class WatchImpactContaint extends StatelessWidget{
  const WatchImpactContaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.all(5),
              child:  SectionWatch(
                cardVideo: [
                  CardVideo(),

                  SizedBox(width: 10,),

                  CardVideo(),

                  SizedBox(width: 10,),

                  CardVideo(),

                  SizedBox(width: 10,),

                  CardVideo(),

                  SizedBox(width: 10,),

                  CardVideo(),

                  SizedBox(width: 10,),

                  CardVideo(),

                  SizedBox(width: 10,),
                ],
              )
            ),
          )
        )
    );
  }

}