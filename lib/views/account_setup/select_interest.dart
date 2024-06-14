// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:umoja/custom_widgets/custom_bouton.dart';
// import 'package:umoja/viewmodels/registration_notifier.dart';
// import 'package:umoja/viewmodels/user_viewModel.dart';
// import 'package:umoja/views/account_setup/create_ping.dart';

// class SelectInterestPage extends ConsumerWidget {
//   final UserService userService;
//   const SelectInterestPage(this.userService, {super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final registrationState = ref.watch(registrationProvider);
//     final registrationNotifier = ref.read(registrationProvider.notifier);
//     final selectedInterests = registrationState['interests'] ?? [];

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text('Select Your Interest'),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               const Text(
//                 'Choose your interest to donate. Don\'t worry, you can always change it later.',
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 32.0),
//               GridView.count(
//                 shrinkWrap: true,
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 16.0,
//                 mainAxisSpacing: 16.0,
//                 padding: const EdgeInsets.all(16.0),
//                 children: <Widget>[
//                   _buildInterestButton(context, Icons.school, 'Education', registrationNotifier, selectedInterests),
//                   _buildInterestButton(context, Icons.eco, 'Environment', registrationNotifier, selectedInterests),
//                   _buildInterestButton(context, Icons.people, 'Social', registrationNotifier, selectedInterests),
//                   _buildInterestButton(context, Icons.child_care, 'Sick child', registrationNotifier, selectedInterests),
//                   _buildInterestButton(context, Icons.medical_services, 'Medical', registrationNotifier, selectedInterests),
//                   _buildInterestButton(context, Icons.apartment, 'Infrastructure', registrationNotifier, selectedInterests),
//                   _buildInterestButton(context, Icons.palette, 'Art', registrationNotifier, selectedInterests),
//                   _buildInterestButton(context, Icons.waves, 'Disaster', registrationNotifier, selectedInterests),
//                   _buildInterestButton(context, Icons.forest, 'Animal', registrationNotifier, selectedInterests),
//                 ],
//               ),
//               const SizedBox(height: 32.0),
//               CustomBouton(
//                 label: "Continue",
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => SetPinCodePage(userService: userService,)));
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInterestButton(
//     BuildContext context,
//     IconData icon,
//     String label,
//     RegistrationNotifier registrationNotifier,
//     List<String> selectedInterests,
//   ) {
//     final isSelected = selectedInterests.contains(label);

//     return ElevatedButton(
//       onPressed: () {
//         if (isSelected) {
//           selectedInterests.remove(label);
//         } else {
//           selectedInterests.add(label);
//         }
//         registrationNotifier.updateData('interests', List.from(selectedInterests));
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: isSelected ? Colors.green : Colors.white,
//         foregroundColor: isSelected ? Colors.white : Colors.green,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
//           side: const BorderSide(color: Colors.green),
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Icon(icon, size: 32),
//           const SizedBox(height: 8.0),
//           Text(
//             label,
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }
