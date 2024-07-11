import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/main.dart';
import 'package:umoja/models/partage_model.dart';
import 'package:umoja/models/projet_model.dart';
import 'package:umoja/viewmodels/partager_projet_viewModel.dart';
import 'package:umoja/views/my_fundraising/64_Light_my_fundraising_see_results_details.dart';
import 'package:umoja/views/my_fundraising/65_Light_my_fundraising_edit.dart';
import 'package:umoja/views/my_fundraising/68_Light_my_fundraising_activity_say_thanks.dart';
import 'package:umoja/views/my_fundraising/70_Light_my_fundraising_create_new_fundraising_filled_form_full_page.dart';
// import 'package:umoja/viewmodels/projet_viewModel.dart';
import 'package:umoja/viewmodels/contribution_projet_viewModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_plus/share_plus.dart';

class MyFundraisingApp62 extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: MyFundraising62(),
    );
  }
}

class MyFundraising62 extends ConsumerStatefulWidget {
  const MyFundraising62({Key? key}) : super(key: key);

  @override
  _MyFundraisingState createState() => _MyFundraisingState();
}

class _MyFundraisingState extends ConsumerState<MyFundraising62>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Appel à fetchAllProjets() lors de l'initialisation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(projetViewModelProvider.notifier).fetchAllProjets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.people, color: Colors.green),
        title: const Text('Mes Collectes de Fonds'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_downward, color: Colors.green),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Mes Collectes de Fonds'),
            Tab(text: 'Activité'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FundraisingList(),
          ActivityList(),
        ],
      ),
    );
  }
}

class FundraisingList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projetViewModel = ref.watch(projetViewModelProvider);
    final projetNotifier = ref.read(projetViewModelProvider.notifier);
    final contributionViewModel = ref.watch(contributionProjetViewModelProvider);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Tout (25)'),
              Tab(text: 'En cours (3)'),
              Tab(text: 'Passées (22)'),
              Tab(text: 'Vote (1)'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            if (projetNotifier.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (projetNotifier.error != null)
              Center(child: Text('Erreur: ${projetNotifier.error}'))
            else if (projetViewModel.isEmpty)
              const Center(child: Text('Pas de projets'))
            else
              ListView.builder(
                itemCount: projetViewModel.length,
                itemBuilder: (context, index) {
                  final projet = projetViewModel[index];
                  if (projet != null) {
                    int montantObtenu = contributionViewModel.contributions
                        .where((contribution) =>
                            contribution != null &&
                            contribution!.projetId == projet.id)
                        .map((contribution) => contribution!.montant)
                        .fold(0, (a, b) => a + b);
                    int donateurs = contributionViewModel.contributions
                        .where((contribution) =>
                            contribution != null &&
                            contribution!.projetId == projet.id)
                        .map((contribution) => contribution!.userId)
                        .toSet()
                        .length;
                    int daysLeft = projet.dateFinCollecte.difference(DateTime.now()).inDays;

                    return FundraisingCard(
                      projet: projet,
                      montantObtenu: montantObtenu,
                      donateurs: donateurs,
                      daysLeft: daysLeft,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            Center(child: const Text('En cours')),
            Center(child: const Text('Passées')),
            Center(child: const Text('Vote')),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateNewFundraisingPage()),
            );
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}




class FundraisingCard extends ConsumerWidget {
  final dynamic projet;
  final int montantObtenu;
  final int donateurs;
  final int daysLeft;

  const FundraisingCard({
    Key? key,
    required this.projet,
    required this.montantObtenu,
    required this.donateurs,
    required this.daysLeft,
  }) : super(key: key);

   void _shareProject(BuildContext context, WidgetRef ref) {
    final String shareText = 'Découvrez mon projet ${projet.titre} sur Umoja et aidez-nous à atteindre notre objectif! ${projet.description}';
    Share.share(shareText, subject: 'Soutenez mon projet sur Umoja');
    
    // Appeler la fonction pour enregistrer le partage
    ref.read(partageProjetViewModelProvider(projet.id).notifier).setPartageProjet('Share', ''); // URL vide pour le moment
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: projet.imageUrls.isNotEmpty?Image.network(
                    projet.imageUrls.first,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ) :  Image.asset(
                    'assets/images/logo_mini.png', // Remplacez par l'image par défaut
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              projet.titre,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.bookmark_border),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Text(
                        '\$$montantObtenu fund raised from \$${projet.montantTotal}',
                        style: TextStyle(color: Colors.green, fontSize: 16),
                      ),
                      LinearProgressIndicator(
                        value: montantObtenu / projet.montantTotal,
                        backgroundColor: Colors.grey[300],
                        color: Colors.green,
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('$donateurs Donors', style: TextStyle(color: Colors.grey[700])),
                          Text('$daysLeft days left', style: TextStyle(color: Colors.green)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: () {
                    //  Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => EditFundraisingPage(projectId: projet.id),
                    //   ),
                    // );
                  },
                  icon: Icon(Icons.edit, color: Colors.green),
                  label: Text('Edit', style: TextStyle(color: Colors.green)),
                ),
                TextButton.icon(
                  onPressed: () {
                     _shareProject(context, ref);
                  },
                  icon: Icon(Icons.share, color: Colors.green),
                  label: Text('Share', style: TextStyle(color: Colors.green)),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text('See Results'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class DonationItem extends StatelessWidget {
  final String image;
  final String name;
  final int amount;
  final VoidCallback onPressed;

  DonationItem({
    required Key key,
    required this.image,
    required this.name,
    required this.amount,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(image),
        ),
        title: Text(
          '$name has donated \$' + amount.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: const Text('Say Thanks'),
        ),
      ),
    );
  }
}

class ActivityList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contributionState = ref.watch(contributionProjetViewModelProvider);
    final contributionNotifier = ref.read(contributionProjetViewModelProvider.notifier);

    if (contributionState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (contributionState.hasError) {
      return Center(child: Text('Erreur: ${contributionState.error}'));
    } else {
      return ListView.builder(
        itemCount: contributionState.contributions.length,
        itemBuilder: (context, index) {
          final contribution = contributionState.contributions[index];
          if (contribution != null) {
            return DonationItem(
              key: UniqueKey(),
              image: 'assets/images/Frame2.png',
              name: contribution.userId,
              amount: contribution.montant,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonationPage68()),
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );
    }
  }
}

final partageProjetViewModelProvider = StateNotifierProvider.family<PartageProjetViewModel, List<PartageProjetModel?>, String>((ref, projetId) {
  final databaseService = ref.read(databaseServiceProvider);
  return PartageProjetViewModel(projetId, databaseService: databaseService);
});
