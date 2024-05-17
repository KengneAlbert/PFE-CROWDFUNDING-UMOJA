import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:umoja/inbox/inbox_page.dart';
import 'package:umoja/my_donation/59_Light_my_donation_empty.dart';
import 'package:umoja/my_donation/60_Light_my_donation_ist.dart';
import 'package:umoja/profile/profile_page.dart';

// Widgets personnalisés

class UmojaAppBar extends StatelessWidget implements PreferredSizeWidget{
  const UmojaAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const Icon(
        Icons.people,
        color: Colors.green,
        size: 32,
      ),
      title: const Text(
        'UMOJA',
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.green),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.green),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.bookmark, color: Colors.green),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class WalletCard extends StatelessWidget {
  const WalletCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '\$349',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('My wallet balance'),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
            ),
            child: const Text(
              'Top up',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class UrgentFundraisingSection extends StatelessWidget {
  const UrgentFundraisingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Urgent Fundraising',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  ),
                  child: const Text(
                    'All',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  ),
                  child: const Text('Medical'),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  ),
                  child: const Text('Disaster'),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  ),
                  child: const Text('Education'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          // Ajouter la section de la liste de campagnes ici
          const _FundraisingList(
            title: 'Help Orphanage Children to...',
            amount: '2.379',
            donators: '1.280',
            daysLeft: '19',
            imageUrl: 'assets/images/logo_mini.png',
          ),
          const SizedBox(height: 16.0),
          const _FundraisingList(
            title: 'Assist with Surgery',
            amount: '3.287',
            donators: '1.376',
            daysLeft: null,
            imageUrl: 'assets/images/logo_mini.png',
          ),
          const SizedBox(height: 16.0),
          const Text(
            'See all',
            style: TextStyle(color: Colors.green),
          ),
        ],
      ),
    );
  }
}

class _FundraisingList extends StatelessWidget {
  final String title;
  final String amount;
  final String donators;
  final String? daysLeft;
  final String imageUrl;

  const _FundraisingList({
    Key? key,
    required this.title,
    required this.amount,
    required this.donators,
    required this.daysLeft,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '$amount fund raised from 4,200',
                  style: const TextStyle(color: Colors.green),
                ),
                const SizedBox(height: 8.0),
                LinearProgressIndicator(
                  value: double.parse(amount) / 4200,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Text(
                      '$donators Donators',
                      style: const TextStyle(color: Colors.green),
                    ),
                    const SizedBox(width: 16.0),
                    if (daysLeft != null)
                      Text(
                        '$daysLeft days left',
                        style: const TextStyle(color: Colors.green),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Image.asset(imageUrl),
          ),
        ],
      ),
    );
  }
}

class ComingToEndSection extends StatelessWidget {
  const ComingToEndSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Coming to an end',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          // Ajouter la section de la liste de campagnes ici
          const _FundraisingList(
            title: 'Helping Earthquake Victims...',
            amount: '4.259',
            donators: '2.367',
            daysLeft: '4',
            imageUrl: 'assets/images/logo_mini.png',
          ),
          const SizedBox(height: 16.0),
          const _FundraisingList(
            title: 'Assist with Surgery',
            amount: '3.462',
            donators: '1.859',
            daysLeft: null,
            imageUrl: 'assets/images/logo_mini.png',
          ),
          const SizedBox(height: 16.0),
          const Text(
            'See all',
            style: TextStyle(color: Colors.green),
          ),
        ],
      ),
    );
  }
}

class WatchImpactSection extends StatelessWidget {
  const WatchImpactSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Watch the Impact of Your Donation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          // Ajouter la section de la liste de campagnes ici
          const _ImpactList(
            title: 'Sarah\'s Surgery Was Successful',
            imageUrl: 'assets/images/logo_mini.png',
          ),
          const SizedBox(height: 16.0),
          const _ImpactList(
            title: 'Siamese Twins Surgery Was Successful',
            imageUrl: 'assets/images/logo_mini.png',
          ),
          const SizedBox(height: 16.0),
          const Text(
            'See all',
            style: TextStyle(color: Colors.green),
          ),
        ],
      ),
    );
  }
}

class _ImpactList extends StatelessWidget {
  final String title;
  final String imageUrl;

  const _ImpactList({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Image.asset(imageUrl),
          ),
        ],
      ),
    );
  }
}

class PrayersFromGoodPeopleSection extends StatelessWidget {
  const PrayersFromGoodPeopleSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Prayers from Good People',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          // Ajouter la section de la liste de prières ici
          const _PrayerList(
            name: 'Esther Howard',
            date: 'Today',
            message: 'Hopefully Audrey can get surgery soon, recover from her illness, and play with her friends.',
            donators: '48',
            imageUrl: 'assets/images/logo_mini.png',
          ),
          const SizedBox(height: 16.0),
          const _PrayerList(
            name: 'Robert',
            date: 'Today',
            message: 'Hopefully Audrey can get surgery soon, recover from her illness, and play with her friends.',
            donators: '39',
            imageUrl: 'assets/images/logo_mini.png',
          ),
          const SizedBox(height: 16.0),
          const Text(
            'See all',
            style: TextStyle(color: Colors.green),
          ),
        ],
      ),
    );
  }
}

class _PrayerList extends StatelessWidget {
  final String name;
  final String date;
  final String message;
  final String donators;
  final String imageUrl;

  const _PrayerList({
    Key? key,
    required this.name,
    required this.date,
    required this.message,
    required this.donators,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(imageUrl),
                    const SizedBox(width: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          date,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(message),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const Icon(Icons.favorite, color: Colors.green),
                    Text('Aamiin'),
                    const SizedBox(width: 16.0),
                    const Icon(Icons.share, color: Colors.green),
                    Text('Share'),
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


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    // Utilisez les widgets personnalisés pour chaque section
    Scaffold(
      appBar: const UmojaAppBar(), 
      body:  SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              UrgentFundraisingSection(),
              ComingToEndSection(),
              WatchImpactSection(),
              PrayersFromGoodPeopleSection(),
            ],
          ),
        ),
      ),
    ),
    MyDonationScreen2(),
    const Center(child: Text('Calendar Page')),
    const InboxPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(0.0),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed, // Important for fixed-size items
          backgroundColor: Color(0xFF13B156), // Background color of the bar
          selectedItemColor: Colors.white, // Selected item text color
          unselectedItemColor: Colors.black, 
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,),
              label: 'Home',
              // Background color for selected item
              backgroundColor: const Color(0xFF13B156), 
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search,),
              label: 'Search',
              // Background color for selected item
              backgroundColor: const Color(0xFF13B156), 
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today,),
              label: 'Calendar',
              // Background color for selected item
              backgroundColor: const Color(0xFF13B156), 
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat,),
              label: 'Chat',
              // Background color for selected item
              backgroundColor: const Color(0xFF13B156), 
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,),
              label: 'Profile',
              // Background color for selected item
              backgroundColor: const Color(0xFF13B156), 
            ),
          ],
        ),
      ),
    );
  }
}
