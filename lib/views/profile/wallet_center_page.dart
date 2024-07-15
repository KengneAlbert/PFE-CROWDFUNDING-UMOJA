import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/views/profile/top_up_page.dart';
import 'package:umoja/views/profile/withdraw.dart';
import 'package:umoja/viewmodels/finance/wallet_viewModel.dart';

class WalletCenterPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallet = ref.watch(walletViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF13B156)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Wallet Center"),
        actions: [
          Icon(Icons.more_vert, color: Color(0xFF13B156)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Color(0xFF13B156),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "\$${wallet.balance}",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text("Balance"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TopUpPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF13B156),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.upload),
                        SizedBox(width: 8),
                        Text("Top Up"),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WithdrawPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF13B156),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.download),
                        SizedBox(width: 8),
                        Text("Withdraw"),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              // ... (Ajoutez l'affichage de l'historique des transactions)
              Text(
                "Activity",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text("Today, December 25 2023"),
              SizedBox(height: 16),
              ActivityItem(
                image: Image.asset("assets/images/Check.png"),
                title: "Top up Successful!",
                description:
                    "You have successfully top up your wallet in the amount of \$100",
              ),
              SizedBox(height: 16),
              ActivityItem(
                image: Image.asset("assets/images/Cancel.png"),
                title: "Donation Canceled!",
                description:
                    "You cancel donations for victims of natural disasters",
              ),
              SizedBox(height: 16),
              Text("Yesterday, December 24 2023"),
              SizedBox(height: 16),
              ActivityItem(
                image: Image.asset("assets/images/Check.png"),
                title: "Top up Successful!",
                description:
                    "You have successfully top up your wallet in the amount of \$120",
              ),
              SizedBox(height: 16),
              ActivityItem(
                image: Image.asset("assets/images/Cancel.png"),
                title: "Donation Canceled!",
                description:
                    "You cancel donations for victims of natural disasters",
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ActivityItem extends StatelessWidget {
  final Image image;
  final String title;
  final String description;

  const ActivityItem({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image,
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}