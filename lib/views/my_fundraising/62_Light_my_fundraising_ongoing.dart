import 'package:flutter/material.dart';
import 'package:umoja/views/my_fundraising/64_Light_my_fundraising_see_results_details.dart';
import 'package:umoja/views/my_fundraising/65_Light_my_fundraising_edit.dart';
import 'package:umoja/views/my_fundraising/68_Light_my_fundraising_activity_say_thanks.dart';
import 'package:umoja/views/my_fundraising/70_Light_my_fundraising_create_new_fundraising_filled_form_full_page.dart';



class MyFundraisingApp62 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyFundraising62(),
    );
  }
}

class MyFundraising62 extends StatefulWidget {
  const MyFundraising62({Key? key}) : super(key: key);
  @override
  _MyFundraisingState createState() => _MyFundraisingState();
}

class _MyFundraisingState extends State<MyFundraising62>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.people, color: Colors.green),
        title: Text('My Fundraising'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_downward, color: Colors.green),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'My Fundraising'),
            Tab(text: 'Activity'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FundraisingList(),
          // Center(
          //   child: Text('Activity'),
          // ),
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Today, December 25 2023',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DonationItem(
                key: UniqueKey(), // Use a unique key for each instance of DonationItem
                image: 'assets/images/Frame2.png',
                name: 'Jane Cooper',
                amount: 25,
                onPressed: () {},
              ),
              DonationItem(
                key: UniqueKey(), // Use a unique key for each instance of DonationItem
                image: 'assets/images/Frame2.png',
                name: 'Anonymous',
                amount: 21,
                onPressed: () {},
              ),
              DonationItem(
                key: UniqueKey(), // Use a unique key for each instance of DonationItem
                image: 'assets/images/Frame2.png',
                name: 'Jenny Wilson',
                amount: 17,
                onPressed: () {},
              ),
              DonationItem(
                key: UniqueKey(), // Use a unique key for each instance of DonationItem
                image: 'assets/images/Frame2.png',
                name: 'Anonymous',
                amount: 28,
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Yesterday, December 24 2023',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DonationItem(
                key: UniqueKey(), // Use a unique key for each instance of DonationItem
                image: 'assets/images/Frame2.png',
                name: 'Robert Hawkins',
                amount: 19,
                onPressed: () {},
              ),
              DonationItem(
                key: UniqueKey(), // Use a unique key for each instance of DonationItem
                image: 'assets/images/Frame2.png',
                name: 'Kristin Watson',
                amount: 15,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FundraisingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: TabBar(
          tabs: [
            Tab(text: 'All(25)'),
            Tab(text: 'Ongoing(3)'),
            Tab(text: 'Past(22)'),
            Tab(text: 'Pending(1)'),

          ],
        ),
        body: TabBarView(
          children: [
            // Center(
            //   child: Text('All'),
            // ),
            ListView(
              children: [
                FundraisingCard(
                  imageUrl: 'assets/images/Frame.png',
                  title: 'Help Victims of Flash Floods',
                  fundRaised: '\8.775',
                  totalFund: '\10.540',
                  donators: '4.471',
                  daysLeft: '9',
                ),
                FundraisingCard(
                  imageUrl: 'assets/images/Frame.png',
                  title: 'Help Improve Child Healthcare',
                  fundRaised: '\2.277',
                  totalFund: '\6.310',
                  donators: '938',
                  daysLeft: '21',
                ),
                FundraisingCard(
                  imageUrl: 'assets/images/Frame.png',
                  title: 'Help Victims of Earthquake',
                  fundRaised: '\4.378',
                  totalFund: '\7.380',
                  donators: '2,475',
                  daysLeft: '25',
                ),
              ],
            ),
            ListView(
              children: [
                FundraisingCard(
                  imageUrl: 'assets/images/Frame.png',
                  title: 'Help Victims of Flash Floods',
                  fundRaised: '\8.775',
                  totalFund: '\10.540',
                  donators: '4.471',
                  daysLeft: '9',
                ),
                FundraisingCard(
                  imageUrl: 'assets/images/Frame.png',
                  title: 'Help Improve Child Healthcare',
                  fundRaised: '\2.277',
                  totalFund: '\6.310',
                  donators: '938',
                  daysLeft: '21',
                ),
                FundraisingCard(
                  imageUrl: 'assets/images/Frame.png',
                  title: 'Help Victims of Earthquake',
                  fundRaised: '\4.378',
                  totalFund: '\7.380',
                  donators: '2,475',
                  daysLeft: '25',
                ),
              ],
            ),
            Center(
              child: Text('Past'),
            ),
            ListView(
              children: [
                FundraisingPendingCard(
                  imageUrl: 'assets/images/Frame2.png',
                  title: 'Help African Children\'s...',
                  fundsRequired: '7,560',
                  daysLeft: '30',
                  fundRaised: '\0.01',
                  totalFund: '\100',
                  status: 'Waiting for review...',
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
           // Naviguer vers la page du formulaire d'ajoute de fundraising
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => CreateNewFundraisingPage()),
            // );
          },
          child: Icon(Icons.add),
           backgroundColor: Colors.green,
          
        ),
        
      ),
    );
  }
}

class FundraisingCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String fundRaised;
  final String totalFund;
  final String donators;
  final String daysLeft;
  //final String fundsRequired;
  //final String status;

  FundraisingCard({
    required this.imageUrl,
    required this.title,
    required this.fundRaised,
    required this.totalFund,
    required this.donators,
    required this.daysLeft,
    //required this.fundsRequired,
    //required this.status,

  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Icon(
                  Icons.bookmark,
                  color: Color.fromARGB(255, 11, 184, 80),
                  size: 30,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                LinearProgressIndicator(
                  value: double.parse(fundRaised) / double.parse(totalFund),
                ),
                SizedBox(height: 8),
                Text(
                  '$fundRaised fund raised from $totalFund',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '$donators Donators',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '$daysLeft days left',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.green),
                      onPressed: () {
                        // Naviguer vers la deuxième page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditFundraisingPage()),
                        );
                      },

                    ),
                    
                    Text('Edit'),
                    IconButton(
                      icon: Icon(Icons.share, color: Colors.green),
                      onPressed: () {
                        // Naviguer vers la deuxième page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditFundraisingPage()),
                        );
                      },

                    ),
                    Text('Share'),

                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // Naviguer vers la deuxième page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ResultsPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Couleur de fond du bouton en vert
                      ),
                      child: Text('See Results'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FundraisingPendingCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String fundsRequired;
  final String daysLeft;
  final String status;
  final String fundRaised;
  final String totalFund;

  FundraisingPendingCard({
    required this.imageUrl,
    required this.title,
    required this.fundsRequired,
    required this.daysLeft,
    required this.status,
    required this.fundRaised,
    required this.totalFund,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Icon(
                  Icons.bookmark,
                  color: Color.fromARGB(255, 14, 194, 68),
                  size: 30,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                LinearProgressIndicator(
                  value: double.parse(fundRaised) / double.parse(totalFund),
                ),
                SizedBox(height: 8),
                Text(
                  '$fundsRequired funds required',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '$daysLeft Days',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
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
 class DonationItem extends StatelessWidget {
  final String image;
  final String name;
  final int amount;
  final Function onPressed;

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
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: ElevatedButton(
          //onPressed: onPressed,
          onPressed: () {
             // Naviguer vers la deuxième page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>DonationPage68()),
                        ); 
          },
          style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green, // Couleur de fond du bouton en vert
          ),
          child: Text('Say Thanks'),
        ),
      ),
    );
  }
}


class ActivityList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Activity List'),
    );
  }
}
  
 