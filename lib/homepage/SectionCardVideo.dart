import 'package:flutter/material.dart';

class SectionCardVideo extends StatelessWidget {

  final List<Widget> cardVideo;

  const SectionCardVideo({
    required this.cardVideo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: cardVideo
            )
          )
        )
      ]
    );
  }

}