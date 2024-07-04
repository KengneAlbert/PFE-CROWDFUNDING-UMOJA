
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../layouts/FundingCardVote.dart';

class IncommingCardState extends StateNotifier<List<Widget>> {
  
  IncommingCardState() : super([

    
  ]);

  void updateCards(List<Widget> newCards) {
    state = newCards;
  }
}

final fundingCardStateProvider = StateNotifierProvider<IncommingCardState, List<Widget>>((ref) {
  return IncommingCardState();
});
