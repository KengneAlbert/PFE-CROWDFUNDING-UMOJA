import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:umoja/models/projet_model.dart';
import 'package:umoja/services/ProjetVoteService.dart';
import 'package:umoja/views/projectundervote/layouts/FundingCardSearchVote.dart';

class ContaintSeeAllVoteState extends StateNotifier<List<Widget>> {
  final ProjetVoteService projectService = ProjetVoteService();
  bool _isLoading = true;

  ContaintSeeAllVoteState() : super([]) {
    loadProjects();
  }

  Future<void> loadProjects() async {
    try {
      _isLoading = true;
      state = [];
      
      List<ProjetModel> projects = (await projectService.getProjetsWithFewLikes(3)).cast<ProjetModel>();

      List<Widget> widgets = await Future.wait(projects.map((project) async {
        int votes = await projectService.getTotalLikes(project.id);
        return FundingCardSearchVote(
          projectId: project.id,
          ImagePath: project.imageUrls.isNotEmpty ? project.imageUrls[0] : '',
          Title: project.titre,
          LikeProjet: "$votes",
        );
      }));

      state = widgets;
    } catch (e) {
      print('Error loading projects: $e');
      // Handle errors here if needed
    } finally {
      _isLoading = false;
      state = state; // Trigger a rebuild
    }
  }

  bool get isLoading => _isLoading;

  void updateCards(List<Widget> newCards) {
    state = newCards;
  }
}

final ContaintSeeAllVoteStateProvider = StateNotifierProvider<ContaintSeeAllVoteState, List<Widget>>((ref) {
  return ContaintSeeAllVoteState();
});

class ContaintSeeAllVote extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ContaintSeeAllVoteStateProvider);
    final notifier = ref.read(ContaintSeeAllVoteStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Projects'),
      ),
      body: notifier.isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.green,))
          : ListView(
              children: state,
            ),
    );
  }
}
