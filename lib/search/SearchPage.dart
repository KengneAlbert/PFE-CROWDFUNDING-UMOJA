import 'package:flutter/material.dart';
import 'package:umoja/search/SearchPageContaint.dart';
import '../generalLayouts/ContainerBottom.dart';



class SearchPage extends StatelessWidget{
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.green,
          size: 24,
        ),
        title: Text(
          'Search',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {}, 
            child: Icon(
              Icons.more_vert,
              color: Colors.green,
            ),
          )
        ],
      ),
      
      body: SearchPageContaint(),
      //SearchPageNotFound() ,

      bottomNavigationBar: ContainerBottom(),
      
    );
  }
}