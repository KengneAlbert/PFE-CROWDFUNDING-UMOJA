import 'package:flutter/material.dart';

class SectionFundingCardSearch extends StatelessWidget{
  final List<Widget>  fundingCardSearch;

    const SectionFundingCardSearch({
      required this.fundingCardSearch,
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: fundingCardSearch,
      );
  }
}