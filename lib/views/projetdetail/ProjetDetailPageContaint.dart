import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProjetDetailPageContaint extends StatelessWidget{
  const ProjetDetailPageContaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Row(
          children: [
            
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Défilement horizontal
                  child:  Container(
                    child: Wrap(
                      children: [
                        Text(
                          "Help Siamese Twins Surgerydfdfdf",
                          style: TextStyle(
                            fontSize: 29,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis, // Ajouter des points de suspension en cas de dépassement
                          maxLines: 1,
                        ),
                      ],
                    )
                  ),
                ),
              ),
            ),

            SizedBox(height: 10,),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Défilement horizontal
                  child:  Container(
                    child: Wrap(
                      children: [
                        Text(
                          "Help Siamese Twins Surgerydfdfdf",
                          style: TextStyle(
                            fontSize: 29,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis, // Ajouter des points de suspension en cas de dépassement
                          maxLines: 1,
                        ),
                      ],
                    )
                  ),
                ),
              ),
            ),

          
     
          ],
        ),
      ),
    );
  }
}