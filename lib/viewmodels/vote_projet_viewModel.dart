import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/voter_projet_model.dart';
import 'package:umoja/services/database_service.dart';

class VoteProjetViewModel extends StateNotifier<List<VoteProjetModel?>> {
 final DatabaseService databaseService;
  bool _isLoading = false;

  VoteProjetViewModel({required this.databaseService}):super([]);

  bool get isLoading => _isLoading;

  Future<void> setVoteProjet(String projetId, String userId,DateTime dateVote)async{
    _isLoading = true;
    state = [...state];
    try{
        final  projetMap = { 'projetId' : projetId, 'userId' : userId, 'dateVote' : dateVote};
        await databaseService.update("Voter", projetMap);
        await fetchAllVoteProjets();
    }catch (e){
      print(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> fetchAllVoteProjets() async {
    _isLoading = true;
    state = [...state];
    try {
      final VoteProjets = await databaseService.fetchAll('Voter');
      state = VoteProjets.map((e) => e != null ? VoteProjetModel.fromMap(e) : null).toList();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }


  Future<void> updateVoteProjet(String id, VoteProjetModel vote) async {
    _isLoading = true;
    state = [...state];
    try {
      await databaseService.update('Voter/$id', vote.toMap());
      await fetchAllVoteProjets();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> deleteProjet(String id) async {
    _isLoading = true;
    state = [...state];
    try {
      await databaseService.delete('Voter/$id');
      await fetchAllVoteProjets();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }
}