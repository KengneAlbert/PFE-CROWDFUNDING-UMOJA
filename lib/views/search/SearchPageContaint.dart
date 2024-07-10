import 'package:flutter/material.dart';
import 'package:umoja/models/projet_vote_model.dart';
import 'package:umoja/services/ProjetVoteService.dart';
import 'package:umoja/views/search/layouts/FundingCardSearch.dart';
import 'package:umoja/views/search/layouts/LineCathegoryButton.dart';
import 'layouts/SearchBar.dart' as custom;
import 'layouts/LineInfos.dart';


class SearchPageContaint extends StatefulWidget {
  const SearchPageContaint({Key? key}) : super(key: key);

  @override
  _SearchPageContaintState createState() => _SearchPageContaintState();
}

class _SearchPageContaintState extends State<SearchPageContaint> {
  final ProjetVoteService _projectService = ProjetVoteService();
  List<ProjetVoteModel> _projects = [];
  List<ProjetVoteModel> _filteredProjects = [];

  @override
  void initState() {
    super.initState();
    _fetchProjects();
  }

  Future<void> _fetchProjects() async {
    try {
      List<ProjetVoteModel> projects = await _projectService.getProjets();
      setState(() {
        _projects = projects;
        _filteredProjects = projects;
      });
    } catch (e) {
      print("Error fetching projects: $e");
    }
  }

  void _filterProjects(String query) {
    final filtered = _projects.where((project) {
      final titleLower = project.titre.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      _filteredProjects = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20),
          custom.SearchBar(onSearch: _filterProjects),
          SizedBox(height: 25),
          LineInfos(label: '${_filteredProjects.length} found'),
          SizedBox(height: 25),
          LineCathegoryButtonFunding(),
          SizedBox(height: 25),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProjects.length,
              itemBuilder: (context, index) {
                final project = _filteredProjects[index];
                return FundingCardSearch(
                  ImagePath: project.imageUrls[0],
                  Title: project.titre,
                  MontFunding: "${project.montantObtenu}",
                  TotalMontFunding: "${project.montantTotal}",
                  ValueFunding: project.montantObtenu / project.montantTotal,
                  NumberDonation: '0', // Ajustez selon votre structure de données
                  Day: "${project.dateFinCollecte.difference(project.dateDebutCollecte).inDays}",
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
