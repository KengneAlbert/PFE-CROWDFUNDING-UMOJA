import 'package:flutter/material.dart';
import '../../generalLayouts/LineCathegoryButton.dart';

class BookmarkPageNotFound extends StatelessWidget{
  const BookmarkPageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            SizedBox(height: 20,),

            Container(
              child: LineCathegoryButton(),
            ),

            SizedBox(height: 150,),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/anybookmark.png"
                ),
       
              ],
            )
          ],
        )
      );
  }
}
  