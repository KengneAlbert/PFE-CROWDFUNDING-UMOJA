import 'package:flutter/material.dart';
import 'package:umoja/account_setup/profile_test.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';

//import 'select_interest.dart';

class SelectCountryPage extends StatefulWidget {
  @override
  _SelectCountryPageState createState() => _SelectCountryPageState();
}

class _SelectCountryPageState extends State<SelectCountryPage> {
  List<Map<String, String>> countries = [
    {"name": "Afghanistan", "code": "AF"},
    // {"name": "Albania", "code": "AL"},
    // {"name": "Algeria", "code": "DZ"},
    // {"name": "Andorra", "code": "AD"},
    // {"name": "Angola", "code": "AO"},
    // {"name": "Argentina", "code": "AR"},
    // {"name": "Armenia", "code": "AM"},
    // Add more countries here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Your Country"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return ListTile(
                    leading: Image.asset(
                      'assets/flags/${country['code']!.toLowerCase()}.png',
                      // package: 'country_icons',
                      width: 32,
                      height: 24,
                    ),
                    title: Text(country['name']!),
                    trailing: Radio(
                      value: country['code'],
                      groupValue: null, // Vous devez gérer la sélection ici
                      onChanged: (value) {
                        // Gérer la sélection du pays ici
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              
              child: CustomBouton(
                label: "Continue",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context) => FillProfilePage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}