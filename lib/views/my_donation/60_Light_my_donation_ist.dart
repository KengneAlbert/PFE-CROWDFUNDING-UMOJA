// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

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
      home: MyDonationScreen2(),
    );
  }
}

class MyDonationScreen2 extends StatefulWidget {
  const MyDonationScreen2({Key? key}) : super(key: key);

  @override
  _MyDonationScreenState createState() => _MyDonationScreenState();
}

class _MyDonationScreenState extends State<MyDonationScreen2> {
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
              TableCalendar(
                // locale: 'fr_FR', 
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
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
                      color: Color.fromARGB(255, 48, 182, 86),
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
                  color: Color(0xFF13B156),
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