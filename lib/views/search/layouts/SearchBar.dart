import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget{
  const SearchBar({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: Color(0xFFF4F6F9),
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.search, color: Colors.green),
          hintText: 'Search...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
        ),

        onChanged: (query) {
          // Handle search query change
          print('Search query: $query');
        }
      ),
    );
  }
}
  