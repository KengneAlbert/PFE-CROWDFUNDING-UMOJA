import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/views/projectundervote/state/ContaintSeeAllVoteState.dart';

class SectionFundingCardSearch extends ConsumerWidget{
  const SectionFundingCardSearch({Key? key}) : super(key: key);
 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fundingCardSearch = ref.watch(ContaintSeeAllVoteStateProvider);
    return  Column(
        children: fundingCardSearch,
      );
  }
}