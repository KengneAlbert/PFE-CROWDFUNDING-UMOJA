// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

class My_donation_60 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Donation',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyDonationScreen(),
    );
  }
}

class MyDonationScreen extends StatefulWidget {
  @override
  _MyDonationScreenState createState() => _MyDonationScreenState();
}

class _MyDonationScreenState extends State<MyDonationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Donation'),
        leading: Icon(Icons.people),
        actions: [
          // Placeholder for the green icon, replace with the actual icon
          Icon(Icons.account_balance_wallet),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Calendar
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'December 2023',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Table(
                        defaultColumnWidth: FixedColumnWidth(40.0),
                        children: [
                          TableRow(
                            children: [
                              Text('Mo'),
                              Text('Tu'),
                              Text('We'),
                              Text('Th'),
                              Text('Fr'),
                              Text('Sa'),
                              Text('Su'),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text('1'),
                              Text('2'),
                              Text('3'),
                              Text('4'),
                              Text('5'),
                              Text('6'),
                              Text('7'),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text('8'),
                              Text('9'),
                              Text('10'),
                              Text('11'),
                              Text('12'),
                              Text('13'),
                              Text('14'),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text('15'),
                              Text('16'),
                              Text('17'),
                              Text('18'),
                              Text('19'),
                              Text('20'),
                              Text('21'),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text('22'),
                              Text('23'),
                              Text('24'),
                              Text('25'),
                              Text('26'),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                child: Text(
                                  '27',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text('28'),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text('29'),
                              Text('30'),
                              Text('31'),
                              Text('1'),
                              Text('2'),
                              Text('3'),
                              Text('5'),


                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'My Donation (7)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Donation Card 1
              DonationCard(
                imageUrl: 'assets/images/Frame.png',
                title: 'Help Victims of Flash Floods',
                fundRaised: '\8775',
                totalFund: '\10540',
                donators: 4471,
                daysLeft: 9,
                donationAmount: '\22',
              ),
              SizedBox(height: 16),
              // Donation Card 2
              DonationCard(
                imageUrl: 'assets/images/Frame.png',
                title: 'Help Improve Child Healthcare',
                fundRaised: '\2277',
                totalFund: '\6310',
                donators: 938,
                daysLeft: 29,
                donationAmount: '\26',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.yellow,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.green
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class DonationCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String fundRaised;
  final String totalFund;
  final int donators;
  final int daysLeft;
  final String donationAmount;

  const DonationCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.fundRaised,
    required this.totalFund,
    required this.donators,
    required this.daysLeft,
    required this.donationAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              alignment: Alignment.topRight,
              children: [
                Image.asset(imageUrl),
                Icon(
                  Icons.bookmark,
                  color: Colors.white,
                  size: 32,
                ),
              ],
            ),
            SizedBox(height: 16),
            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Fund raised
            Row(
              children: [
                Text(
                  '$fundRaised fund raised from $totalFund',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            // Progress bar
            LinearProgressIndicator(
              value: double.parse(fundRaised) / double.parse(totalFund),
              backgroundColor: Colors.grey.withOpacity(0.2),
            ),
            SizedBox(height: 8),
            // Donators & days left
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$donators Donators',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  '$daysLeft days left',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // You have donated
            Text(
              'You have donated $donationAmount',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(height: 16),
            // Donate again button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text('Donate Again'),
            ),
          ],
        ),
      ),
    );
  }
}