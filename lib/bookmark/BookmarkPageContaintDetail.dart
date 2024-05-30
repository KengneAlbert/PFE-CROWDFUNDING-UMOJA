import 'package:flutter/material.dart';
import '../generalLayouts/ContainerBottom.dart';
import 'BookmarkPageNotFound.dart';
import 'BookmarkPageContaint.dart';
import 'layouts/ContainerBottomBooKmarkDetail.dart';
import 'layouts/BookmarkPageContaintDetailBody.dart';


class BookmarkPageContaintDetail extends StatelessWidget{
  const BookmarkPageContaintDetail({Key? key}) : super(key: key);

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
          'Bookmark',
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
      
      body:BookmarkPageContaintDetailBody() ,

      bottomNavigationBar: ContainerBottomBooKmarkDetail(),
      
    );
  }
}