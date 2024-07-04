import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state/FundingCardStateFunding.dart';  // Assurez-vous que le chemin est correct

class SectionFundingCard extends ConsumerWidget {
  const SectionFundingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fundCard = ref.watch(fundingCardStateProvider);

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
