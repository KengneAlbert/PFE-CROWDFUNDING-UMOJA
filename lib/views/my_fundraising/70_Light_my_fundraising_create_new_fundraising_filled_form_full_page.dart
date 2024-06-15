import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umoja/main.dart';
import 'package:umoja/models/projet_model.dart';
import 'package:umoja/services/database_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:umoja/services/storage_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:umoja/viewmodels/categorie_viewModel.dart';

class CreateNewFundraisingPage extends ConsumerStatefulWidget {
  @override
  _CreateNewFundraisingPageState createState() => _CreateNewFundraisingPageState();
}

class _CreateNewFundraisingPageState extends ConsumerState<CreateNewFundraisingPage> {
  final _formKey = GlobalKey<FormState>();
  final _titreController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _montantTotalController = TextEditingController();
  final _histoireController = TextEditingController();
  final _recipientsNameController = TextEditingController();
  DateTime? _dateDebutCollecte;
  DateTime? _dateFinCollecte;
  List<File> _images = [];
  File? _proposalDocument;
  File? _medicalDocument;
  String? _category;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final projetViewModel = ref.watch(projetViewModelProvider.notifier);
    final categorieProviderValue = ref.watch(categorieProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Fundraising'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Picker
                  GestureDetector(
                    onTap: () async {
                      final picker = ImagePicker();
                      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setState(() {
                          _images.add(File(pickedFile.path));
                        });
                      }
                    },
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: _images.isEmpty
                          ? Center(child: Text('Add Cover Photos'))
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _images.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.file(_images[index]),
                                );
                              },
                            ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Project Title
                  TextFormField(
                    controller: _titreController,
                    decoration: InputDecoration(labelText: 'Title'),
                    validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
                  ),
                  SizedBox(height: 16),
                  // Category Dropdown
                  categorieProviderValue.when(
                    data: (categories) => DropdownButtonFormField<String>(
                      value: _category,
                      onChanged: (newValue) => setState(() => _category = newValue),
                      items: categories.map((category) => DropdownMenuItem(value: category.id, child: Text(category.titre))).toList(),
                      decoration: InputDecoration(labelText: 'Category'),
                      validator: (value) => value == null ? 'Please select a category' : null,
                    ),
                    loading: () => CircularProgressIndicator(),
                    error: (error, stack) => Text('Error: $error'),
                  ),
                  SizedBox(height: 16),
                  // Total Donation Amount
                  TextFormField(
                    controller: _montantTotalController,
                    decoration: InputDecoration(labelText: 'Total Donation Required'),
                    keyboardType: TextInputType.number,
                    validator: (value) => value!.isEmpty ? 'Please enter a total donation amount' : null,
                  ),
                  SizedBox(height: 16),
                  // Donation Start Date Picker
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _dateDebutCollecte = pickedDate;
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Choose Donation Start Date'),
                        controller: TextEditingController(text: _dateDebutCollecte == null ? '' : _dateDebutCollecte.toString().substring(0, 10)),
                        validator: (value) => _dateDebutCollecte == null ? 'Please choose a start date' : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Donation Expiration Date Picker
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _dateFinCollecte = pickedDate;
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Choose Donation Expiration Date'),
                        controller: TextEditingController(text: _dateFinCollecte == null ? '' : _dateFinCollecte.toString().substring(0, 10)),
                        validator: (value) => _dateFinCollecte == null ? 'Please choose an expiration date' : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Project Description
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Fund Usage Plan'),
                    maxLines: 3,
                    validator: (value) => value!.isEmpty ? 'Please enter a fund usage plan' : null,
                  ),
                  SizedBox(height: 16),
                  // Name of Recipients
                  TextFormField(
                    controller: _recipientsNameController,
                    decoration: InputDecoration(labelText: 'Name of Recipients (People/Organization)'),
                    validator: (value) => value!.isEmpty ? 'Please enter the name of recipients' : null,
                  ),
                  SizedBox(height: 16),
                  // Donation Proposal Document Picker
                  GestureDetector(
                    onTap: () async {
                      final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
                      if (result != null && result.files.single.path != null) {
                        setState(() {
                          _proposalDocument = File(result.files.single.path!);
                        });
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: Center(
                        child: Text(_proposalDocument == null ? 'Upload Donation Proposal Documents' : _proposalDocument!.path.split('/').last),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Medical Documents Picker
                  GestureDetector(
                    onTap: () async {
                      final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
                      if (result != null && result.files.single.path != null) {
                        setState(() {
                          _medicalDocument = File(result.files.single.path!);
                        });
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: Center(
                        child: Text(_medicalDocument == null ? 'Upload Medical Documents (optional for medical)' : _medicalDocument!.path.split('/').last),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Project Story
                  TextFormField(
                    controller: _histoireController,
                    decoration: InputDecoration(labelText: 'Story'),
                    maxLines: 3,
                    validator: (value) => value!.isEmpty ? 'Please enter the story of donation recipients' : null,
                  ),
                  SizedBox(height: 16),
                  // Terms and Conditions Checkbox
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (value) {}),
                      Expanded(child: Text('By checking this, you agree to the terms & conditions that apply to us.')),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Create & Submit Button
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => _isLoading = true);

                            try {
                              final storageService = StorageService(FirebaseStorage.instance);
                              List<String> imageUrls = [];
                              for (var image in _images) {
                                String imageUrl = await storageService.uploadFile(image, 'projets/images/${image.path.split('/').last}');
                                imageUrls.add(imageUrl);
                              }
                              String? proposalDocumentUrl;
                              if (_proposalDocument != null) {
                                proposalDocumentUrl = await storageService.uploadFile(_proposalDocument!, 'projets/documents/${_proposalDocument!.path.split('/').last}');
                              }
                              String? medicalDocumentUrl;
                              if (_medicalDocument != null) {
                                medicalDocumentUrl = await storageService.uploadFile(_medicalDocument!, 'projets/medical/${_medicalDocument!.path.split('/').last}');
                              }

                              await projetViewModel.setProjet(
                                titre: _titreController.text,
                                description: _descriptionController.text,
                                montantTotal: int.parse(_montantTotalController.text),
                                dateDebutCollecte: _dateDebutCollecte!,
                                dateFinCollecte: _dateFinCollecte!,
                                histoire: _histoireController.text,
                                montantObtenu: 0, // montantObtenu initially 0
                                categorieId: _category!, // CategorieId from dropdown
                                createdAt: DateTime.now(),
                                imageUrls: imageUrls,
                                proposalDocumentUrl: proposalDocumentUrl,
                                medicalDocumentUrl: medicalDocumentUrl,
                              );

                              setState(() => _isLoading = false);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Project created successfully')));
                            } catch (e) {
                              setState(() => _isLoading = false);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                            }
                          }
                        },
                        child: Text('Create & Submit'),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Draft'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}





// import 'package:flutter/material.dart';

// class CreateNewFundraisingPage extends StatefulWidget {
//   @override
//   _CreateNewFundraisingPageState createState() =>
//       _CreateNewFundraisingPageState();
// }

// class _CreateNewFundraisingPageState
//     extends State<CreateNewFundraisingPage> {
//   final _formKey = GlobalKey<FormState>();
//   String? _title;
//   String? _category = 'Education';
//   String? _totalDonationRequired;
//   DateTime? _donationExpirationDate;
//   String? _fundUsagePlan;
//   String? _recipientName;
//   String? _donationProposalDocument;
//   String? _medicalDocument;
//   String? _story;
//   bool _termsAndConditionsAgreed = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.green),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text('Create New Fundraising'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Campaign Image
//                 Image.asset(
//                   'assets/images/Frame2.png',
//                   height: 200,
//                   fit: BoxFit.cover,
//                 ),
//                 SizedBox(height: 16),
//                 // Image Thumbnails
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _buildThumbnailImage(
//                         'assets/images/Frame2.png'),
//                     _buildThumbnailImage(
//                         'assets/images/Frame2.png'),
//                     _buildThumbnailImage(
//                         'assets/images/Frame2.png'),
//                     _buildThumbnailImage(
//                         'assets/images/Frame2.png'),
//                   ],
//                 ),
//                 SizedBox(height: 24),
//                 // Fundraising Details
//                 Text(
//                   'Fundraising Details',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 // Title
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Title *',
//                     border: OutlineInputBorder(),
//                   ),
//                   initialValue: 'Help African Children\'s Education',
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a title';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _title = value;
//                   },
//                 ),
//                 SizedBox(height: 16),
//                 // Category
//                 DropdownButtonFormField<String>(
//                   decoration: InputDecoration(
//                     labelText: 'Category *',
//                     border: OutlineInputBorder(),
//                   ),
//                   value: _category,
//                   items: <String>['Education', 'Disaster', 'Healthcare']
//                   .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value                     ,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _category = value;
//                     });
//                   },
//                 ),
//                 SizedBox(height: 16),
//                 // Total Donation Required
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Total Donation Required *',
//                     border: OutlineInputBorder(),
//                     suffixIcon: Icon(Icons.attach_money),
//                   ),
//                   keyboardType: TextInputType.number,
//                   initialValue: '8,200',
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the total donation required';
//                     }
//                     if (int.tryParse(value) == null) {
//                       return 'Please enter a valid number';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _totalDonationRequired = value;
//                   },
//                 ),
//                 SizedBox(height: 16),
//                 // Choose Donation Expiration Date
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Choose Donation Expiration Date *',
//                     border: OutlineInputBorder(),
//                     suffixIcon: Icon(Icons.calendar_today),
//                   ),
//                   readOnly: true,
//                   onTap: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime.now(),
//                       lastDate: DateTime(2100),
//                     );
//                     if (pickedDate != null) {
//                       setState(() {
//                         _donationExpirationDate = pickedDate;
//                       });
//                     }
//                   },
//                   controller: TextEditingController(
//                     text: _donationExpirationDate != null
//                         ? _donationExpirationDate!.toString()
//                         : 'December 20, 2024',
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 // Fund Usage Plan
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Fund Usage Plan *',
//                     border: OutlineInputBorder(),
//                   ),
//                   initialValue:
//                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud. ut labore et dolore magna aliqua. Ut enim ad minim.',
//                   maxLines: 4,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a fund usage plan';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _fundUsagePlan = value;
//                   },
//                 ),
//                 SizedBox(height: 24),
//                 // Donation Recipient Details
//                 Text(
//                   'Donation Recipient Details',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 // Name of Recipients
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Name of Recipients (People/Organization) *',
//                     border: OutlineInputBorder(),
//                   ),
//                   initialValue: 'African Children',
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the recipient name';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _recipientName = value;
//                   },
//                 ),
//                 SizedBox(height: 16),
//                 // Upload Donation Proposal Documents
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Upload Donation Proposal Documents *',
//                     border: OutlineInputBorder(),
//                     suffixIcon: Icon(Icons.cloud_upload),
//                   ),
//                   readOnly: true,
//                   onTap: () {
//                     // Handle file selection
//                     setState(() {
//                       _donationProposalDocument = 'Proposal African Children Education.pdf';
//                     });
//                   },
//                   controller: TextEditingController(
//                     text: _donationProposalDocument ?? '',
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 // Upload Medical Documents (optional)
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Upload Medical Documents (optional for medical)',
//                     border: OutlineInputBorder(),
//                     suffixIcon: Icon(Icons.cloud_upload),
//                   ),
//                   readOnly: true,
//                   onTap: () {
//                     // Handle file selection
//                     setState(() {
//                       _medicalDocument = 'Medical Documents.pdf';
//                     });
//                   },
//                   controller: TextEditingController(
//                     text: _medicalDocument ?? '',
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 // Story
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Story *',
//                     border: OutlineInputBorder(),
//                   ),
//                   initialValue:
//                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud. ut labore et dolore magna aliqua. Ut enim ad minim.',
//                   maxLines: 4,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a story';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _story = value;
//                   },
//                 ),
//                 SizedBox(height: 16),
//                 // Terms and Conditions
//                 Row(
//                   children: [
//                     Checkbox(
//                       value: _termsAndConditionsAgreed,
//                       onChanged: (value) {
//                         setState(() {
//                           _termsAndConditionsAgreed = value!;
//                         });
//                       },
//                     ),
//                     Expanded(
//                       child: Text(
//                         'By checking this, you agree to the terms & conditions that apply to us.',
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 24),
//                 // Buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         // Handle Draft button press
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(Icons.drafts),
//                           SizedBox(width: 8),
//                           Text('Draft'),
//                         ],
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           _formKey.currentState!.save();
//                           // Handle form submission
//                           print('Title: $_title');
//                           print('Category: $_category');
//                           print('Total Donation Required: $_totalDonationRequired');
//                           print('Donation Expiration Date: $_donationExpirationDate');
//                           print('Fund Usage Plan: $_fundUsagePlan');
//                           print('Recipient Name: $_recipientName');
//                           print('Donation Proposal Document: $_donationProposalDocument');
//                           print('Medical Document: $_medicalDocument');
//                           print('Story: $_story');
//                           print('Terms and Conditions Agreed: $_termsAndConditionsAgreed');
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                       ),
//                       child: Text('Create & Submit'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildThumbnailImage(String imageUrl) {
//     return Container(
//       width: 80,
//       height: 80,
//       child: Image.asset(
//         imageUrl,
//         fit: BoxFit.cover,
//       ),
//     );
//   }
// }