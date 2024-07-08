import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:umoja/main.dart';
import 'package:umoja/views/profile/settings_page.dart';
import 'package:umoja/views/profile/wallet_center_page.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset(
          'assets/icons/svg/logo.svg',
          width: 30,
          height: 30,
        ),
        title: Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
            icon: Icon(Icons.settings, color: Color(0xFF13B156)),
          ),
          SizedBox(width: 16),
          Icon(Icons.more_vert, color: Color(0xFF13B156)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: user?.profile_picture != null
                          ? Image.network(user!.profile_picture!).image
                          : AssetImage('assets/images/logo_mini.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF13B156),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.edit, color: Colors.white),
                          onPressed: () {
                            // Logique pour changer l'image d'avatar
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  "${user?.name}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("12"),
                      Text("Fundraising"),
                    ],
                  ),
                  Column(
                    children: [
                      Text("487"),
                      Text("Followers"),
                    ],
                  ),
                  Column(
                    children: [
                      Text("126"),
                      Text("Following"),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.account_balance_wallet, color: Color(0xFF13B156)),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\$349",
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "My wallet balance",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WalletCenterPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFF13B156),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFF13B156), width: 2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text("Top up"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                "About",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Text(
                    "Interest",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit, color: Color(0xFF13B156)),
                    onPressed: () {
                      // Logique pour éditer les centres d'intérêt
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
              SizedBox(
                height: 150,
                child: user?.interests != null
                    ? Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (var i in user!.interests!)
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF13B156),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                textStyle: TextStyle(fontSize: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text("${i}"),
                            ),
                        ],
                      )
                    : Text('Aucun centre d\'interet!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WithdrawSuccessPopup extends StatelessWidget {
  const WithdrawSuccessPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 24),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF13B156).withOpacity(0.4),
                ),
              ),
              Icon(
                Icons.check,
                size: 40,
                color: Colors.white,
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF13B156).withOpacity(0.3),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 10,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF13B156).withOpacity(0.3),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 50,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF13B156).withOpacity(0.3),
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
                right: 50,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF13B156).withOpacity(0.3),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Text(
            "Withdraw Successful!",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "You have successfully withdrawn your funds.",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF13B156),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              textStyle: TextStyle(fontSize: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:umoja/main.dart';
// import 'package:umoja/views/profile/settings_page.dart';
// import 'package:umoja/views/profile/wallet_center_page.dart';

// class ProfilePage extends ConsumerWidget {
//   const ProfilePage({super.key});
  
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(authViewModelProvider);
//     return Scaffold(
//       appBar: AppBar(
//         leading: SvgPicture.asset(
//                     'assets/icons/svg/logo.svg', 
//                     width: 30,
//                     height: 30,
//                   ),
//         title: Text("Profile"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
//           }, icon: Icon(Icons.settings, color: Color(0xFF13B156))),
//           SizedBox(width: 16),
//           Icon(Icons.more_vert,  color: Color(0xFF13B156)),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Stack(
//                   children: [
//                     CircleAvatar(
//                           radius: 60,
//                           backgroundImage: user?.profile_picture != null  ? Image.network(user!.profile_picture!).image : AssetImage('assets/images/logo_mini.png'), // Remplacez par l'image par défaut souhaitée
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Color(0xFF13B156),
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             child: IconButton(
//                               icon: Icon(Icons.edit, color: Colors.white),
//                               onPressed: () {
//                                 // Logique pour changer l'image d'avatar
//                                 // Par exemple, ouvrir une galerie d'images ou prendre une photo
//                               },
//                             ),
//                           ),
//                         ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 16),
//               Center(
//                 child: Text(
//                   "${user?.name}",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Column(
//                     children: [
//                       Text("12"),
//                       Text("Fundraising"),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Text("487"),
//                       Text("Followers"),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Text("126"),
//                       Text("Following"),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 24),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.grey[300]!,
//                     width: 1,
//                   ),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.account_balance_wallet, color: Color(0xFF13B156)),
//                         SizedBox(width: 8),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "\$349",
//                               style: TextStyle(
//                                 fontSize: 23,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               "My wallet balance",
//                               style: TextStyle(
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => WalletCenterPage()));
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: Color(0xFF13B156),
//                         padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                         textStyle: TextStyle(fontSize: 16),
//                         shape: RoundedRectangleBorder(
//                           side: BorderSide(color: Color(0xFF13B156), width: 2),
//                           borderRadius: BorderRadius.circular(50),
//                         ),
//                       ),
//                       child: Text("Top up"),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 24),
//               Text(
//                 "About",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
//               ),
//               SizedBox(height: 24),
//               Row(
//                 children: [
//                   Text(
//                     "Interest",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                  SizedBox(width: 8,),
//                  IconButton(
//                   icon: Icon(Icons.edit, color: Color(0xFF13B156)),
//                   onPressed: () {
        
//                   },
//                 ),
//                 ],
//               ),
//               SizedBox(height: 8),
//               SizedBox(
//                 height: 150,
//                 child: user?.interests != null ? Wrap(
//                   spacing: 8,
//                   runSpacing: 8,
//                   children: [
//                     for (var i in user!.interests!)
//                       ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xFF13B156),
//                           foregroundColor: Colors.white,
//                           padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                           textStyle: TextStyle(fontSize: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: Text("${i}"),
//                       ),
  
//                   ],
//                 ): Text('Aucun centre d\'interet!'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class WithdrawSuccessPopup extends StatelessWidget {
//   const WithdrawSuccessPopup({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SizedBox(height: 24),
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               Container(
//                 width: 100,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Color(0xFF13B156).withOpacity(0.4),
//                 ),
//               ),
//               Icon(
//                 Icons.check,
//                 size: 40,
//                 color: Colors.white,
//               ),
//               Positioned(
//                 top: 10,
//                 left: 10,
//                 child: Container(
//                   width: 10,
//                   height: 10,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color(0xFF13B156).withOpacity(0.3),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 40,
//                 right: 10,
//                 child: Container(
//                   width: 15,
//                   height: 15,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color(0xFF13B156).withOpacity(0.3),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 10,
//                 left: 50,
//                 child: Container(
//                   width: 10,
//                   height: 10,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color(0xFF13B156).withOpacity(0.3),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 40,
//                 right: 50,
//                 child: Container(
//                   width: 20,
//                   height: 20,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color(0xFF13B156).withOpacity(0.3),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 24),
//           Text(
//             "Withdraw Successful!",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 12),
//           Text(
//             "You have successfully withdraw from your wallet for \$300",
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 24),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color(0xFF13B156).withOpacity(0.4),
//               padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
//               textStyle: TextStyle(fontSize: 16, color: Colors.white),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: Text("OK"),
//           ),
//           SizedBox(height: 24),
//         ],
//       ),
//     );
//   }
// }