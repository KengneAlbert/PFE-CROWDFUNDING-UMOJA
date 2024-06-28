import "package:flutter/material.dart";
import "package:flutter_stripe/flutter_stripe.dart";

class CardPaymentStripe extends StatelessWidget{
const CardPaymentStripe({Key? key}):super (key: key);
@override
build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: const Text('pay with a credit card'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('card form', style: Theme.of(context).textTheme.headlineSmall,),
          const SizedBox(height:20),
          CardFormField(
            controller: CardFormEditController(),
          ),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: (){}, child: const Text('pay')),
        ],
      ),
    )
  );
}
}