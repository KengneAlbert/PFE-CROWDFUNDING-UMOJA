import 'package:flutter/material.dart';

class SectionBookmarkFundingCard extends StatelessWidget {

  final List<Widget> fundCard;

  const SectionBookmarkFundingCard({
    required this.fundCard,
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
              children: fundCard,
            );
  }

}