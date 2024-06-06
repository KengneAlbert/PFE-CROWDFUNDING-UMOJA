import 'package:flutter/material.dart';

class SectionFundingCard extends StatelessWidget {

  final List<Widget> fundCard;

  const SectionFundingCard({
    required this.fundCard,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: fundCard,
            ),
          ),
        ),
      ],
    );
  }

}