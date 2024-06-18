// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:file_picker/file_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mime/mime.dart';

// class PublishProjectPage extends ConsumerStatefulWidget {
//   const PublishProjectPage({Key? key}) : super(key: key);

//   @override
//   ConsumerState<PublishProjectPage> createState() => _PublishProjectPageState();
// }

// class _PublishProjectPageState extends ConsumerState<PublishProjectPage> {
//   final _projectTitleController = TextEditingController();
//   final _projectDescriptionController = TextEditingController();
//   File? _selectedFile;
//   String _selectedFileType = '';
//   bool _isLoading = false;
//   String _status = 'En cours de vérification';
//   List<Map<String, String>> _chatMessages = [];

//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'mp4', 'mov'],
//     );

//     if (result != null) {
//       setState(() {
//         _selectedFile = File(result.files.single.path!);
//         _selectedFileType = result.files.single.extension!;
//       });
//     }
//   }

//   Future<void> _submitProject() async {
//     setState(() {
//       _isLoading = true;
//     });

//     final result = await verifyProject(
//       _projectTitleController.text,
//       _projectDescriptionController.text,
//       _selectedFile,
//       _selectedFileType,
//     );

//     setState(() {
//       _isLoading = false;
//       _status = result['status'];
//       _chatMessages.addAll(result['chatMessages']);
//     });
//   }

//   Future<Map<String, dynamic>> verifyProject(String title, String description, File? file, String fileType) async {
//     var request = http.MultipartRequest('POST', Uri.parse('https://api.gemini.com/verify'));
//     request.headers.addAll({
//       'Content-Type': 'multipart/form-data',
//       'Authorization': 'Bearer YOUR_API_KEY',
//     });
//     request.fields['title'] = title;
//     request.fields['description'] = description;
//     request.fields['context'] = 'Votre contexte personnalisé';

//     if (file != null) {
//       String? mimeType = lookupMimeType(file.path);
//       if (mimeType != null) {
//         request.files.add(await http.MultipartFile.fromPath(
//           'file',
//           file.path,
//           contentType: MediaType.parse(mimeType),
//         ));
//       }
//     }

//     var response = await request.send();
//     var responseData = await http.Response.fromStream(response);

//     if (responseData.statusCode == 200) {
//       final data = jsonDecode(responseData.body);
//       return {
//         'status': data['status'],
//         'chatMessages': List<Map<String, String>>.from(data['chatMessages']),
//       };
//     } else {
//       return {
//         'status': 'Rejeté',
//         'chatMessages': [
//           {
//             'role': 'system',
//             'content': 'Une erreur est survenue lors de la vérification.'
//           }
//         ],
//       };
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Publier un Projet'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _projectTitleController,
//               decoration: InputDecoration(labelText: 'Titre du Projet'),
//             ),
//             TextField(
//               controller: _projectDescriptionController,
//               decoration: InputDecoration(labelText: 'Description du Projet'),
//               maxLines: 5,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickFile,
//               child: Text('Sélectionner un fichier'),
//             ),
//             if (_selectedFile != null)
//               Text('Fichier sélectionné: ${_selectedFile!.path}'),
//             SizedBox(height: 20),
//             if (_isLoading)
//               CircularProgressIndicator()
//             else
//               ElevatedButton(
//                 onPressed: _submitProject,
//                 child: Text('Soumettre'),
//               ),
//             SizedBox(height: 20),
//             Text('Statut : $_status'),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _chatMessages.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(_chatMessages[index]['role']!),
//                     subtitle: Text(_chatMessages[index]['content']!),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
