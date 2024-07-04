import 'package:flutter/material.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:umoja/views/homepage/HomePage.dart';
import 'package:umoja/views/projetdetail/ProjetDetailPageContaint.dart';
import '../generalLayouts/ContainerBottom.dart';



class ProjetDetailPage extends StatelessWidget{
  const ProjetDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(350), // Définir la hauteur souhaitée de l'AppBar
          child: AppBar(
            leading: GestureDetector(
              onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>  HomePage()
                    )
                  );
                },
              child: Padding(
                padding: EdgeInsets.all(5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) =>  HomePage()
                      )
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white, // Couleur de fond
                      borderRadius: BorderRadius.circular(12), // Bordure arrondie
                    ),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.green,
                      ), 
                    ),
                  ),
                ),
              ),
            ),

            actions: [
          
              Padding(
                padding: EdgeInsets.all(5),
                child: GestureDetector(
                  onTap: () {
                  
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white, // Couleur de fond
                      borderRadius: BorderRadius.circular(12), // Bordure arrondie
                    ),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Icon(
                        Icons.share,
                        color: Colors.green,
                      ), 
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: GestureDetector(
                  onTap: () {
                  
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white, // Couleur de fond
                      borderRadius: BorderRadius.circular(12), // Bordure arrondie
                    ),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Icon(
                        Icons.bookmark_border,
                        color: Colors.green,
                      ), 
                    ),
                  ),
                ),
              )

            ],

            flexibleSpace: AnotherCarousel(
              indicatorBgPadding: 10.0,
                        images: [
                           ClipRRect(
                            child: Image.asset(
                              'assets/images/proje.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          ClipRRect(
                            child: Image.asset(
                              'assets/images/2.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          ClipRRect(
                            child: Image.asset(
                              'assets/images/3.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
            )

            ),
            
          ),
          
          body: ProjetDetailPageContaint(),
          
          bottomNavigationBar: ContainerBottom(),
        );
  }
}