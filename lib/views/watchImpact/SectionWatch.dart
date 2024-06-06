import 'package:flutter/material.dart';

class SectionWatch extends StatelessWidget{
  final List<Widget>  cardVideo;

    const SectionWatch({
      required this.cardVideo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 20,
              children: cardVideo,
            ),
          ),
      ]
    );
  }
}