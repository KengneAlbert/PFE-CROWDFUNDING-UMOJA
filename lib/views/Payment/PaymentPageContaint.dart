import 'package:flutter/material.dart';
import 'package:umoja/views/Payment/layouts/PayementCard.dart';
import 'layouts/LineInfos.dart';

class PaymentPageContaint extends StatelessWidget{
  const PaymentPageContaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        SizedBox(height: 10,),

        LineInfos(
          label: "Select Payment Method",
          label2: "Add New Card",
        ),

        SizedBox(height: 10,),

        PayementCard(),

      ],
    );
  }
}