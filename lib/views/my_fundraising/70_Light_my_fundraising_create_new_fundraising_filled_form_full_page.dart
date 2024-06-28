// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:umoja/main.dart';
// import 'package:umoja/models/projet_model.dart';
// import 'package:umoja/services/database_service.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:umoja/services/storage_service.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:umoja/viewmodels/categorie_viewModel.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class CreateNewFundraisingPage extends ConsumerStatefulWidget {
//   @override
//   _CreateNewFundraisingPageState createState() => _CreateNewFundraisingPageState();
// }

// class _CreateNewFundraisingPageState extends ConsumerState<CreateNewFundraisingPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _titreController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _montantTotalController = TextEditingController();
//   final _histoireController = TextEditingController();
//   final _recipientsNameController = TextEditingController();
//   DateTime? _dateDebutCollecte;
//   DateTime? _dateFinCollecte;
//   List<File> _images = [];
//   File? _proposalDocument;
//   File? _medicalDocument;
//   String? _category;
//   bool _isLoading = false;

//   // Gemini API configuration
//   final String _geminiMultimodalUrl = 'https://api.geminiai.com/multimodal'; 
//   final String _geminiApiKey = 'YOUR_GEMINI_API_KEY'; // Replace with your Gemini API key

//   @override
//   Widget build(BuildContext context) {
//     final projetViewModel = ref.watch(projetViewModelProvider.notifier);
//     final categorieProviderValue = ref.watch(categorieProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create New Fundraising'),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Image Picker
//                   GestureDetector(
//                     onTap: () async {
//                       final picker = ImagePicker();
//                       final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//                       if (pickedFile != null) {
//                         setState(() {
//                           _images.add(File(pickedFile.path));
//                         });
//                       }
//                     },
//                     child: Container(
//                       height: 200,
//                       width: double.infinity,
//                       color: Colors.grey[200],
//                       child: _images.isEmpty
//                           ? Center(child: Text('Add Cover Photos'))
//                           : ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: _images.length,
//                               itemBuilder: (context, index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Image.file(_images[index]),
//                                 );
//                               },
//                             ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // Project Title
//                   TextFormField(
//                     controller: _titreController,
//                     decoration: InputDecoration(labelText: 'Title'),
//                     validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
//                   ),
//                   SizedBox(height: 16),
//                   // Category Dropdown
//                   categorieProviderValue.when(
//                     data: (categories) => DropdownButtonFormField<String>(
//                       value: _category,
//                       onChanged: (newValue) => setState(() => _category = newValue),
//                       items: categories.map((category) => DropdownMenuItem(value: category.id, child: Text(category.titre))).toList(),
//                       decoration: InputDecoration(labelText: 'Category'),
//                       validator: (value) => value == null ? 'Please select a category' : null,
//                     ),
//                     loading: () => CircularProgressIndicator(),
//                     error: (error, stack) => Text('Error: $error'),
//                   ),
//                   SizedBox(height: 16),
//                   // Total Donation Amount
//                   TextFormField(
//                     controller: _montantTotalController,
//                     decoration: InputDecoration(labelText: 'Total Donation Required'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) => value!.isEmpty ? 'Please enter a total donation amount' : null,
//                   ),
//                   SizedBox(height: 16),
//                   // Donation Start Date Picker
//                   GestureDetector(
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime.now(),
//                         lastDate: DateTime(2101),
//                       );
//                       if (pickedDate != null) {
//                         setState(() {
//                           _dateDebutCollecte = pickedDate;
//                         });
//                       }
//                     },
//                     child: AbsorbPointer(
//                       child: TextFormField(
//                         decoration: InputDecoration(labelText: 'Choose Donation Start Date'),
//                         controller: TextEditingController(text: _dateDebutCollecte == null ? '' : _dateDebutCollecte.toString().substring(0, 10)),
//                         validator: (value) => _dateDebutCollecte == null ? 'Please choose a start date' : null,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // Donation Expiration Date Picker
//                   GestureDetector(
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime.now(),
//                         lastDate: DateTime(2101),
//                       );
//                       if (pickedDate != null) {
//                         setState(() {
//                           _dateFinCollecte = pickedDate;
//                         });
//                       }
//                     },
//                     child: AbsorbPointer(
//                       child: TextFormField(
//                         decoration: InputDecoration(labelText: 'Choose Donation Expiration Date'),
//                         controller: TextEditingController(text: _dateFinCollecte == null ? '' : _dateFinCollecte.toString().substring(0, 10)),
//                         validator: (value) => _dateFinCollecte == null ? 'Please choose an expiration date' : null,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // Project Description
//                   TextFormField(
//                     controller: _descriptionController,
//                     decoration: InputDecoration(labelText: 'Fund Usage Plan'),
//                     maxLines: 3,
//                     validator: (value) => value!.isEmpty ? 'Please enter a fund usage plan' : null,
//                   ),
//                   SizedBox(height: 16),
//                   // Name of Recipients
//                   TextFormField(
//                     controller: _recipientsNameController,
//                     decoration: InputDecoration(labelText: 'Name of Recipients (People/Organization)'),
//                     validator: (value) => value!.isEmpty ? 'Please enter the name of recipients' : null,
//                   ),
//                   SizedBox(height: 16),
//                   // Donation Proposal Document Picker
//                   GestureDetector(
//                     onTap: () async {
//                       final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
//                       if (result != null && result.files.single.path != null) {
//                         setState(() {
//                           _proposalDocument = File(result.files.single.path!);
//                         });
//                       }
//                     },
//                     child: Container(
//                       height: 50,
//                       width: double.infinity,
//                       color: Colors.grey[200],
//                       child: Center(
//                         child: Text(_proposalDocument == null ? 'Upload Donation Proposal Documents' : _proposalDocument!.path.split('/').last),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // Medical Documents Picker
//                   GestureDetector(
//                     onTap: () async {
//                       final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
//                       if (result != null && result.files.single.path != null) {
//                         setState(() {
//                           _medicalDocument = File(result.files.single.path!);
//                         });
//                       }
//                     },
//                     child: Container(
//                       height: 50,
//                       width: double.infinity,
//                       color: Colors.grey[200],
//                       child: Center(
//                         child: Text(_medicalDocument == null ? 'Upload Medical Documents (optional for medical)' : _medicalDocument!.path.split('/').last),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // Project Story
//                   TextFormField(
//                     controller: _histoireController,
//                     decoration: InputDecoration(labelText: 'Story'),
//                     maxLines: 3,
//                     validator: (value) => value!.isEmpty ? 'Please enter the story of donation recipients' : null,
//                   ),
//                   SizedBox(height: 16),
//                   // Terms and Conditions Checkbox
//                   Row(
//                     children: [
//                       Checkbox(value: true, onChanged: (value) {}),
//                       Expanded(child: Text('By checking this, you agree to the terms & conditions that apply to us.')),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   // Create & Submit Button
//                   Row(
//                     children: [
//                       ElevatedButton(
//                         onPressed: () async {
//                           if (_formKey.currentState!.validate()) {
//                             setState(() => _isLoading = true);

//                             try {
//                               // Upload files to Firebase Storage
//                               final storageService = StorageService(FirebaseStorage.instance);
//                               List<String> imageUrls = [];
//                               for (var image in _images) {
//                                 String imageUrl = await storageService.uploadFile(image, 'projets/images/${image.path.split('/').last}');
//                                 imageUrls.add(imageUrl);
//                               }
//                               String? proposalDocumentUrl;
//                               if (_proposalDocument != null) {
//                                 proposalDocumentUrl = await storageService.uploadFile(_proposalDocument!, 'projets/documents/${_proposalDocument!.path.split('/').last}');
//                               }
//                               String? medicalDocumentUrl;
//                               if (_medicalDocument != null) {
//                                 medicalDocumentUrl = await storageService.uploadFile(_medicalDocument!, 'projets/medical/${_medicalDocument!.path.split('/').last}');
//                               }

//                               // Create Project in Database
//                               await projetViewModel.setProjet(
//                                 titre: _titreController.text,
//                                 description: _descriptionController.text,
//                                 montantTotal: int.parse(_montantTotalController.text),
//                                 dateDebutCollecte: _dateDebutCollecte!,
//                                 dateFinCollecte: _dateFinCollecte!,
//                                 histoire: _histoireController.text,
//                                 montantObtenu: 0, // montantObtenu initially 0
//                                 categorieId: _category!, // CategorieId from dropdown
//                                 createdAt: DateTime.now(),
//                                 imageUrls: imageUrls,
//                                 proposalDocumentUrl: proposalDocumentUrl,
//                                 medicalDocumentUrl: medicalDocumentUrl,
//                               );

//                               // Prepare data for Gemini Multimodal
//                               final projet = ProjetModel(
//                                 titre: _titreController.text,
//                                 description: _descriptionController.text,
//                                 montantTotal: int.parse(_montantTotalController.text),
//                                 dateDebutCollecte: _dateDebutCollecte!,
//                                 dateFinCollecte: _dateFinCollecte!,
//                                 histoire: _histoireController.text,
//                                 montantObtenu: 0,
//                                 categorieId: _category!,
//                                 createdAt: DateTime.now(),
//                                 imageUrls: imageUrls,
//                                 proposalDocumentUrl: proposalDocumentUrl,
//                                 medicalDocumentUrl: medicalDocumentUrl, 
//                                 userId: '',
//                               );

//                               // Build Gemini Multimodal prompt
//                               final prompt = """
//                               Verify if the provided project is valid based on the following criteria:
//                               - Title: ${projet.titre}
//                               - Description: ${projet.description}
//                               - Total Donation Amount: ${projet.montantTotal}
//                               - Donation Start Date: ${projet.dateDebutCollecte}
//                               - Donation Expiration Date: ${projet.dateFinCollecte}
//                               - Story: ${projet.histoire}
//                               - Category: ${projet.categorieId}
//                               - Image URLs: ${projet.imageUrls}
//                               - Donation Proposal Document URL: ${projet.proposalDocumentUrl}
//                               - Medical Document URL: ${projet.medicalDocumentUrl}

//                               If the project is invalid, provide the reason why.
//                               """;

//                               // Send project data to Gemini for verification
//                               final response = await http.post(
//                                 Uri.parse(_geminiMultimodalUrl),
//                                 headers: {
//                                   'Authorization': 'Bearer $_geminiApiKey',
//                                   'Content-Type': 'application/json',
//                                 },
//                                 body: jsonEncode({
//                                   'prompt': prompt,
//                                   'input': {}, // Add any relevant input data if needed
//                                 }),
//                               );

//                               // Process Gemini Multimodal response
//                               final responseBody = jsonDecode(response.body);
//                               final validationResult = responseBody['result'];
//                               final validationReason = responseBody['reason'];

//                               // Display validation results to the user
//                               if (validationResult == 'valid') {
//                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Project created successfully')));
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Project is invalid: $validationReason')));
//                                 // You can handle the invalid project case here (e.g., prompt the user to correct the information)
//                               }

//                               setState(() => _isLoading = false);
//                             } catch (e) {
//                               setState(() => _isLoading = false);
//                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
//                             }
//                           }
//                         },
//                         child: Text('Create & Submit'),
//                       ),
//                       SizedBox(width: 16),
//                       ElevatedButton(
//                         onPressed: () {},
//                         child: Text('Draft'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (_isLoading)
//             Center(
//               child: CircularProgressIndicator(),
//             ),
//         ],
//       ),
//     );
//   }
// }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///
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
import 'package:video_player/video_player.dart';

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
  List<XFile?> _images = [];
  XFile? _video;
  VideoPlayerController? _videoController;
  bool _videoSelected = false;
  bool _thumbnailSelected = false;
  XFile? _thumbnailImage;
  File? _businessModelDocument;
  File? _businessPlanDocument;
  String? _category;
  bool _isLoading = false;
  bool _termsAndConditionsChecked = false;

  Future<void> _selectVideo(ImageSource source) async {
    // Autoriser uniquement la sélection de la galerie
    if (source == ImageSource.gallery) {
      final pickedVideo = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 5), // Limite à 5 minutes
      );

      if (pickedVideo != null) {
        setState(() {
          _video = pickedVideo;
          _videoController = VideoPlayerController.file(File(_video!.path))
            ..initialize().then((_) {
              setState(() {});
            });
          _videoSelected = true;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner une vidéo à partir de votre galerie.')),
      );
    }
  }

  Future<void> _selectImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        if (!_thumbnailSelected) {
          _thumbnailSelected = true;
          _thumbnailImage = pickedImage;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cette image sera utilisée comme vignette.')),
          );
        }
        _images.add(pickedImage);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
      if (index == 0 && _thumbnailSelected) {
        _thumbnailSelected = false;
        _thumbnailImage = null;
      }
    });
  }

  Future<void> _selectDocument(String typeDocument) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        if (typeDocument == 'businessModel') {
          _businessModelDocument = File(result.files.single.path!);
        } else if (typeDocument == 'businessPlan') {
          _businessPlanDocument = File(result.files.single.path!);
        }
      });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _titreController.dispose();
    _descriptionController.dispose();
    _montantTotalController.dispose();
    _histoireController.dispose();
    _recipientsNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projetViewModel = ref.watch(projetViewModelProvider.notifier);
    final categorieProviderValue = ref.watch(categorieProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer une nouvelle collecte de fonds'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section de la vignette
                  if (_thumbnailImage != null)
                    Image.file(
                      File(_thumbnailImage!.path),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  const SizedBox(height: 16),

                  // Section de la vidéo
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      _video != null && _videoController != null &&
                          _videoController!.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _videoController!.value.aspectRatio,
                              child: VideoPlayer(_videoController!),
                            )
                          : const SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: Center(
                                child: Icon(
                                  Icons.videocam,
                                  size: 48,
                                ),
                              ),
                            ),
                      if (!_videoSelected)
                        Positioned(
                          bottom: 16,
                          right: 16,
                          child: FloatingActionButton(
                            onPressed: () {
                              _selectVideo(ImageSource.gallery);
                            },
                            child: const Icon(Icons.videocam),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Section des images
                  if (_videoSelected)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Titre de la section des images
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Images',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Images
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _images.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Image.file(
                                      File(_images[index]!.path),
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _removeImage(index);
                                      },
                                      icon: const Icon(Icons.close),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Bouton pour ajouter des images
                        Row(
                          children: [
                            // Icône pour ajouter des images
                            IconButton(
                              onPressed: () {
                                _selectImage(ImageSource.gallery);
                              },
                              icon: const Icon(Icons.add_photo_alternate),
                              iconSize: 32,
                            ),
                            // Texte pour le bouton
                            const Text('Ajouter des images'),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),

                  // Champ de texte pour le titre
                  TextFormField(
                    controller: _titreController,
                    decoration: InputDecoration(
                      labelText: 'Titre',
                      prefixIcon: const Icon(Icons.title),
                    ),
                    validator: (value) => value!.isEmpty ? 'Veuillez entrer un titre' : null,
                  ),
                  const SizedBox(height: 16),

                  // Menu déroulant pour la catégorie
                  categorieProviderValue.when(
                    data: (categories) => DropdownButtonFormField<String>(
                      value: _category,
                      onChanged: (newValue) => setState(() => _category = newValue),
                      items: categories.map((category) => DropdownMenuItem(value: category.id, child: Text(category.titre))).toList(),
                      decoration: InputDecoration(
                        labelText: 'Catégorie',
                        prefixIcon: const Icon(Icons.category),
                      ),
                      validator: (value) => value == null ? 'Veuillez sélectionner une catégorie' : null,
                    ),
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stack) => Text('Erreur : $error'),
                  ),
                  const SizedBox(height: 16),

                  // Champ de texte pour le montant total
                  TextFormField(
                    controller: _montantTotalController,
                    decoration: InputDecoration(
                      labelText: 'Montant total requis',
                      prefixIcon: const Icon(Icons.attach_money),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) => value!.isEmpty ? 'Veuillez entrer un montant total' : null,
                  ),
                  const SizedBox(height: 16),

                  // Sélecteur de date pour la date de début de la collecte
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
                        decoration: InputDecoration(
                          labelText: 'Date de début de la collecte',
                          prefixIcon: const Icon(Icons.calendar_today),
                        ),
                        controller: TextEditingController(text: _dateDebutCollecte == null ? '' : _dateDebutCollecte.toString().substring(0, 10)),
                        validator: (value) => _dateDebutCollecte == null ? 'Veuillez choisir une date de début' : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Sélecteur de date pour la date de fin de la collecte
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
                        decoration: InputDecoration(
                          labelText: 'Date de fin de la collecte',
                          prefixIcon: const Icon(Icons.calendar_today),
                        ),
                        controller: TextEditingController(text: _dateFinCollecte == null ? '' : _dateFinCollecte.toString().substring(0, 10)),
                        validator: (value) => _dateFinCollecte == null ? 'Veuillez choisir une date de fin' : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Champ de texte pour la description du projet
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Plan d’utilisation des fonds',
                      prefixIcon: const Icon(Icons.description),
                    ),
                    maxLines: 3,
                    validator: (value) => value!.isEmpty ? 'Veuillez entrer un plan d’utilisation des fonds' : null,
                  ),
                  const SizedBox(height: 16),

                  // Champ de texte pour le nom des bénéficiaires
                  TextFormField(
                    controller: _recipientsNameController,
                    decoration: InputDecoration(
                      labelText: 'Nom des bénéficiaires (Personnes/Organisations)',
                      prefixIcon: const Icon(Icons.people),
                    ),
                    validator: (value) => value!.isEmpty ? 'Veuillez entrer le nom des bénéficiaires' : null,
                  ),
                  const SizedBox(height: 16),

                  // Sélecteur de document pour le modèle d’entreprise
                  GestureDetector(
                    onTap: () {
                      _selectDocument('businessModel');
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: Center(
                        child: Text(_businessModelDocument == null ? 'Télécharger le modèle d’entreprise (PDF)' : _businessModelDocument!.path.split('/').last),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Sélecteur de document pour le plan d’entreprise
                  GestureDetector(
                    onTap: () {
                      _selectDocument('businessPlan');
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: Center(
                        child: Text(_businessPlanDocument == null ? 'Télécharger le plan d’entreprise (PDF)' : _businessPlanDocument!.path.split('/').last),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Champ de texte pour l’histoire du projet
                  TextFormField(
                    controller: _histoireController,
                    decoration: InputDecoration(
                      labelText: 'Histoire',
                      // prefixIcon: const Icon(Icons.story),
                    ),
                    maxLines: 3,
                    validator: (value) => value!.isEmpty ? 'Veuillez entrer l’histoire des bénéficiaires' : null,
                  ),
                  const SizedBox(height: 16),

                  // Case à cocher pour les termes et conditions
                  Row(
                    children: [
                      Checkbox(
                        value: _termsAndConditionsChecked,
                        onChanged: (value) {
                          setState(() {
                            _termsAndConditionsChecked = value!;
                          });
                        },
                      ),
                      Expanded(child: const Text('En cochant cette case, vous acceptez les termes et conditions qui s’appliquent à nous.')),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Bouton pour créer et soumettre
                  ElevatedButton(
                    onPressed: _termsAndConditionsChecked
                        ? () async {
                            if (_formKey.currentState!.validate()) {
                              // Afficher un popup avec une barre de progression
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Création en cours'),
                                    content: StatefulBuilder(
                                      builder: (context, setState) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const CircularProgressIndicator(),
                                            const SizedBox(height: 16),
                                            Text('Chargement des données...'),
                                            const SizedBox(height: 16),
                                            ElevatedButton(
                                              onPressed: () {
                                                // Annuler l'opération
                                                Navigator.of(context).pop();
                                                setState(() => _isLoading = false);
                                              },
                                              child: const Text('Annuler'),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                },
                              );

                              setState(() => _isLoading = true);

                              try {
                                final storageService = StorageService(FirebaseStorage.instance);
                                List<String> imageUrls = [];
                                for (var image in _images) {
                                  String imageUrl = await storageService.uploadFile(File(image!.path), 'projets/images/${image.path.split('/').last}');
                                  imageUrls.add(imageUrl);
                                }
                                String? businessModelDocumentUrl;
                                if (_businessModelDocument != null) {
                                  businessModelDocumentUrl = await storageService.uploadFile(_businessModelDocument!, 'projets/documents/${_businessModelDocument!.path.split('/').last}');
                                }
                                String? businessPlanDocumentUrl;
                                if (_businessPlanDocument != null) {
                                  businessPlanDocumentUrl = await storageService.uploadFile(_businessPlanDocument!, 'projets/documents/${_businessPlanDocument!.path.split('/').last}');
                                }

                                // Si une vidéo est sélectionnée, télécharger la vidéo sur Firestore
                                if (_video != null) {
                                  String videoUrl = await storageService.uploadFile(File(_video!.path), 'projets/videos/${_video!.path.split('/').last}');
                                  await projetViewModel.setProjet(
                                    titre: _titreController.text,
                                    description: _descriptionController.text,
                                    montantTotal: int.parse(_montantTotalController.text),
                                    dateDebutCollecte: _dateDebutCollecte!,
                                    dateFinCollecte: _dateFinCollecte!,
                                    histoire: _histoireController.text,
                                    montantObtenu: 0, // montantObtenu initialement 0
                                    categorieId: _category!, // CategorieId du menu déroulant
                                    createdAt: DateTime.now(),
                                    imageUrls: imageUrls,
                                    businessModelDocumentUrl: businessModelDocumentUrl,
                                    businessPlanDocumentUrl: businessPlanDocumentUrl,
                                    videoUrl: videoUrl,
                                  );
                                } else {
                                  await projetViewModel.setProjet(
                                    titre: _titreController.text,
                                    description: _descriptionController.text,
                                    montantTotal: int.parse(_montantTotalController.text),
                                    dateDebutCollecte: _dateDebutCollecte!,
                                    dateFinCollecte: _dateFinCollecte!,
                                    histoire: _histoireController.text,
                                    montantObtenu: 0, // montantObtenu initialement 0
                                    categorieId: _category!, // CategorieId du menu déroulant
                                    createdAt: DateTime.now(),
                                    imageUrls: imageUrls,
                                    businessModelDocumentUrl: businessModelDocumentUrl,
                                    businessPlanDocumentUrl: businessPlanDocumentUrl,
                                  );
                                }

                                // Fermer le popup et afficher un message de succès
                                Navigator.of(context).pop();
                                setState(() => _isLoading = false);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('Projet créé avec succès')));
                              } catch (e) {
                                // Fermer le popup et afficher un message d'erreur
                                Navigator.of(context).pop();
                                setState(() => _isLoading = false);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur : $e')));
                              }
                            }
                          }
                        : null,
                    child: const Text('Créer et soumettre'),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Center(
              child: const CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';

// class CreateNewFundraisingPage extends StatefulWidget {
//   const CreateNewFundraisingPage({Key? key}) : super(key: key);

//   @override
//   State<CreateNewFundraisingPage> createState() => _CreateNewFundraisingPageState();
// }

// class _CreateNewFundraisingPageState extends State<CreateNewFundraisingPage> {
//   final _formKey = GlobalKey<FormState>();
//   List<XFile?> _images = [];
//   XFile? _video;
//   VideoPlayerController? _videoController;
//   bool _videoSelected = false;
//   bool _thumbnailSelected = false;
//   XFile? _thumbnailImage;

//   Future<void> _selectVideo(ImageSource source) async {
//     final pickedVideo = await ImagePicker().pickVideo(
//       source: source,
//       maxDuration: const Duration(minutes: 5), // Limit to 5 minutes
//     );

//     if (pickedVideo != null) {
//       setState(() {
//         _video = pickedVideo;
//         _videoController = VideoPlayerController.file(File(_video!.path))
//           ..initialize().then((_) {
//             setState(() {});
//           });
//         _videoSelected = true;
//       });
//     }
//   }

//   Future<void> _selectImage(ImageSource source) async {
//     final pickedImage = await ImagePicker().pickImage(source: source);
//     if (pickedImage != null) {
//       setState(() {
//         if (!_thumbnailSelected) {
//           _thumbnailSelected = true;
//           _thumbnailImage = pickedImage;
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('This image will be used as thumbnail.')),
//           );
//         }
//         _images.add(pickedImage);
//       });
//     }
//   }

//   void _removeImage(int index) {
//     setState(() {
//       _images.removeAt(index);
//       if (index == 0 && _thumbnailSelected) {
//         _thumbnailSelected = false;
//         _thumbnailImage = null;
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _videoController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Create New Fundraising'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Cover Photo (Video Preview)
//                 Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     _video != null && _videoController != null &&
//                         _videoController!.value.isInitialized
//                         ? AspectRatio(
//                             aspectRatio: _videoController!.value.aspectRatio,
//                             child: VideoPlayer(_videoController!),
//                           )
//                         : const SizedBox(
//                             height: 200,
//                             width: double.infinity,
//                             child: Center(
//                               child: Icon(
//                                 Icons.add_a_photo,
//                                 size: 48,
//                               ),
//                             ),
//                           ),
//                     if (!_videoSelected)
//                       Positioned(
//                         bottom: 16,
//                         right: 16,
//                         child: FloatingActionButton(
//                           onPressed: () {
//                             _selectVideo(ImageSource.gallery);
//                           },
//                           child: const Icon(Icons.videocam),
//                         ),
//                       ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),

//                 // Images Section
//                 if (_videoSelected)
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Title for Images Section
//                       const Padding(
//                         padding: EdgeInsets.only(left: 16.0),
//                         child: Text(
//                           'Images',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),

//                       // Images
//                       SizedBox(
//                         height: 100,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: _images.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.only(right: 8.0),
//                               child: Stack(
//                                 alignment: Alignment.topRight,
//                                 children: [
//                                   Image.file(
//                                     File(_images[index]!.path),
//                                     height: 100,
//                                     width: 100,
//                                     fit: BoxFit.cover,
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                       _removeImage(index);
//                                     },
//                                     icon: const Icon(Icons.close),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 16),

//                       // Add Images Button (only after video is selected)
//                       // Using a Row to position the icon and text together
//                       Row(
//                         children: [
//                           // Icon for adding images
//                           IconButton(
//                             onPressed: () {
//                               _selectImage(ImageSource.gallery);
//                             },
//                             icon: const Icon(Icons.add_photo_alternate),
//                             iconSize: 32,
//                           ),
//                           // Text for the button
//                           const Text('Add Images'),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                     ],
//                   ),

//                 // Thumbnail Image
//                 if (_thumbnailImage != null)
//                   Image.file(
//                     File(_thumbnailImage!.path),
//                     height: 100,
//                     width: 100,
//                     fit: BoxFit.cover,
//                   ),
//                 const SizedBox(height: 16),

//                 // Title
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     labelText: 'Title',
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a title';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),

//                 // Category
//                 DropdownButtonFormField<String>(
//                   decoration: const InputDecoration(
//                     labelText: 'Category',
//                   ),
//                   items: const [
//                     DropdownMenuItem(
//                       value: 'Education',
//                       child: Text('Education'),
//                     ),
//                     DropdownMenuItem(
//                       value: 'Healthcare',
//                       child: Text('Healthcare'),
//                     ),
//                     // Add more categories here
//                   ],
//                   onChanged: (value) {
//                     // Handle category selection
//                   },
//                 ),
//                 const SizedBox(height: 16),

//                 // Submit Button
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       // Submit form data
//                     }
//                   },
//                   child: const Text('Submit'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:umoja/main.dart';
// import 'package:umoja/models/projet_model.dart';
// import 'package:umoja/services/database_service.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:umoja/services/storage_service.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:umoja/viewmodels/categorie_viewModel.dart';

// class CreateNewFundraisingPage extends ConsumerStatefulWidget {
//   @override
//   _CreateNewFundraisingPageState createState() => _CreateNewFundraisingPageState();
// }

// class _CreateNewFundraisingPageState extends ConsumerState<CreateNewFundraisingPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _titreController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _montantTotalController = TextEditingController();
//   final _histoireController = TextEditingController();
//   final _recipientsNameController = TextEditingController();
//   DateTime? _dateDebutCollecte;
//   DateTime? _dateFinCollecte;
//   List<File> _images = [];
//   File? _proposalDocument;
//   File? _medicalDocument;
//   String? _category;
//   bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     final projetViewModel = ref.watch(projetViewModelProvider.notifier);
//     final categorieProviderValue = ref.watch(categorieProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create New Fundraising'),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Image Picker
//                   GestureDetector(
//                     onTap: () async {
//                       final picker = ImagePicker();
//                       final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//                       if (pickedFile != null) {
//                         setState(() {
//                           _images.add(File(pickedFile.path));
//                         });
//                       }
//                     },
//                     child: Container(
//                       height: 200,
//                       width: double.infinity,
//                       color: Colors.grey[200],
//                       child: _images.isEmpty
//                           ? Center(child: Text('Add Cover Photos'))
//                           : ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: _images.length,
//                               itemBuilder: (context, index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Image.file(_images[index]),
//                                 );
//                               },
//                             ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // Project Title
//                   TextFormField(
//                     controller: _titreController,
//                     decoration: InputDecoration(labelText: 'Title'),
//                     validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
//                   ),
//                   SizedBox(height: 16),
//                   // Category Dropdown
//                   categorieProviderValue.when(
//                     data: (categories) => DropdownButtonFormField<String>(
//                       value: _category,
//                       onChanged: (newValue) => setState(() => _category = newValue),
//                       items: categories.map((category) => DropdownMenuItem(value: category.id, child: Text(category.titre))).toList(),
//                       decoration: InputDecoration(labelText: 'Category'),
//                       validator: (value) => value == null ? 'Please select a category' : null,
//                     ),
//                     loading: () => CircularProgressIndicator(),
//                     error: (error, stack) => Text('Error: $error'),
//                   ),
//                   SizedBox(height: 16),
//                   // Total Donation Amount
//                   TextFormField(
//                     controller: _montantTotalController,
//                     decoration: InputDecoration(labelText: 'Total Donation Required'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) => value!.isEmpty ? 'Please enter a total donation amount' : null,
//                   ),
//                   SizedBox(height: 16),
//                   // Donation Start Date Picker
//                   GestureDetector(
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime.now(),
//                         lastDate: DateTime(2101),
//                       );
//                       if (pickedDate != null) {
//                         setState(() {
//                           _dateDebutCollecte = pickedDate;
//                         });
//                       }
//                     },
//                     child: AbsorbPointer(
//                       child: TextFormField(
//                         decoration: InputDecoration(labelText: 'Choose Donation Start Date'),
//                         controller: TextEditingController(text: _dateDebutCollecte == null ? '' : _dateDebutCollecte.toString().substring(0, 10)),
//                         validator: (value) => _dateDebutCollecte == null ? 'Please choose a start date' : null,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // Donation Expiration Date Picker
//                   GestureDetector(
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime.now(),
//                         lastDate: DateTime(2101),
//                       );
//                       if (pickedDate != null) {
//                         setState(() {
//                           _dateFinCollecte = pickedDate;
//                         });
//                       }
//                     },
//                     child: AbsorbPointer(
//                       child: TextFormField(
//                         decoration: InputDecoration(labelText: 'Choose Donation Expiration Date'),
//                         controller: TextEditingController(text: _dateFinCollecte == null ? '' : _dateFinCollecte.toString().substring(0, 10)),
//                         validator: (value) => _dateFinCollecte == null ? 'Please choose an expiration date' : null,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // Project Description
//                   TextFormField(
//                     controller: _descriptionController,
//                     decoration: InputDecoration(labelText: 'Fund Usage Plan'),
//                     maxLines: 3,
//                     validator: (value) => value!.isEmpty ? 'Please enter a fund usage plan' : null,
//                   ),
//                   SizedBox(height: 16),
//                   // Name of Recipients
//                   TextFormField(
//                     controller: _recipientsNameController,
//                     decoration: InputDecoration(labelText: 'Name of Recipients (People/Organization)'),
//                     validator: (value) => value!.isEmpty ? 'Please enter the name of recipients' : null,
//                   ),
//                   SizedBox(height: 16),
//                   // Donation Proposal Document Picker
//                   GestureDetector(
//                     onTap: () async {
//                       final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
//                       if (result != null && result.files.single.path != null) {
//                         setState(() {
//                           _proposalDocument = File(result.files.single.path!);
//                         });
//                       }
//                     },
//                     child: Container(
//                       height: 50,
//                       width: double.infinity,
//                       color: Colors.grey[200],
//                       child: Center(
//                         child: Text(_proposalDocument == null ? 'Upload Donation Proposal Documents' : _proposalDocument!.path.split('/').last),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // Medical Documents Picker
//                   GestureDetector(
//                     onTap: () async {
//                       final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
//                       if (result != null && result.files.single.path != null) {
//                         setState(() {
//                           _medicalDocument = File(result.files.single.path!);
//                         });
//                       }
//                     },
//                     child: Container(
//                       height: 50,
//                       width: double.infinity,
//                       color: Colors.grey[200],
//                       child: Center(
//                         child: Text(_medicalDocument == null ? 'Upload Medical Documents (optional for medical)' : _medicalDocument!.path.split('/').last),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // Project Story
//                   TextFormField(
//                     controller: _histoireController,
//                     decoration: InputDecoration(labelText: 'Story'),
//                     maxLines: 3,
//                     validator: (value) => value!.isEmpty ? 'Please enter the story of donation recipients' : null,
//                   ),
//                   SizedBox(height: 16),
//                   // Terms and Conditions Checkbox
//                   Row(
//                     children: [
//                       Checkbox(value: true, onChanged: (value) {}),
//                       Expanded(child: Text('By checking this, you agree to the terms & conditions that apply to us.')),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   // Create & Submit Button
//                   Row(
//                     children: [
//                       ElevatedButton(
//                         onPressed: () async {
//                           if (_formKey.currentState!.validate()) {
//                             setState(() => _isLoading = true);

//                             try {
//                               final storageService = StorageService(FirebaseStorage.instance);
//                               List<String> imageUrls = [];
//                               for (var image in _images) {
//                                 String imageUrl = await storageService.uploadFile(image, 'projets/images/${image.path.split('/').last}');
//                                 imageUrls.add(imageUrl);
//                               }
//                               String? proposalDocumentUrl;
//                               if (_proposalDocument != null) {
//                                 proposalDocumentUrl = await storageService.uploadFile(_proposalDocument!, 'projets/documents/${_proposalDocument!.path.split('/').last}');
//                               }
//                               String? medicalDocumentUrl;
//                               if (_medicalDocument != null) {
//                                 medicalDocumentUrl = await storageService.uploadFile(_medicalDocument!, 'projets/medical/${_medicalDocument!.path.split('/').last}');
//                               }

//                               await projetViewModel.setProjet(
//                                 titre: _titreController.text,
//                                 description: _descriptionController.text,
//                                 montantTotal: int.parse(_montantTotalController.text),
//                                 dateDebutCollecte: _dateDebutCollecte!,
//                                 dateFinCollecte: _dateFinCollecte!,
//                                 histoire: _histoireController.text,
//                                 montantObtenu: 0, // montantObtenu initially 0
//                                 categorieId: _category!, // CategorieId from dropdown
//                                 createdAt: DateTime.now(),
//                                 imageUrls: imageUrls,
//                                 proposalDocumentUrl: proposalDocumentUrl,
//                                 medicalDocumentUrl: medicalDocumentUrl,
//                               );

//                               setState(() => _isLoading = false);
//                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Project created successfully')));
//                             } catch (e) {
//                               setState(() => _isLoading = false);
//                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
//                             }
//                           }
//                         },
//                         child: Text('Create & Submit'),
//                       ),
//                       SizedBox(width: 16),
//                       ElevatedButton(
//                         onPressed: () {},
//                         child: Text('Draft'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (_isLoading)
//             Center(
//               child: CircularProgressIndicator(),
//             ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:umoja/main.dart';
// import 'package:umoja/models/projet_model.dart';
// import 'package:umoja/services/database_service.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:umoja/services/storage_service.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:umoja/viewmodels/categorie_viewModel.dart';

// class CreateNewFundraisingPage extends ConsumerStatefulWidget {
//   @override
//   _CreateNewFundraisingPageState createState() => _CreateNewFundraisingPageState();
// }

// class _CreateNewFundraisingPageState extends ConsumerState<CreateNewFundraisingPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _titreController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _montantTotalController = TextEditingController();
//   final _histoireController = TextEditingController();
//   final _recipientsNameController = TextEditingController();
//   DateTime? _dateDebutCollecte;
//   DateTime? _dateFinCollecte;
//   List<File> _images = [];
//   File? _proposalDocument;
//   File? _medicalDocument;
//   String? _category;
//   bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     final projetViewModel = ref.watch(projetViewModelProvider.notifier);
//     final categorieProviderValue = ref.watch(categorieProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create New Fundraising'),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Image Picker
//                   GestureDetector(
//                     onTap: () async {
//                       final picker = ImagePicker();
//                       final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//                       if (pickedFile != null) {
//                         setState(() {
//                           _images.add(File(pickedFile.path));
//                         });
//                       }
//                     },
//                     child: Container(
//                       height: 200,
//                       width: double.infinity,
//                       color: Colors.grey[200],
//                       child: _images.isEmpty
//                           ? Center(child: Text('Add Cover Photos'))
//                           : ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: _images.length,
//                               itemBuilder: (context, index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Image.file(_images[index]),
//                                 );
//                               },
//                             ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // Project Title
//                   TextFormField(
//                     controller: _titreController,
//                     decoration: InputDecoration(labelText: 'Title'),
//                     validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
//                   ),
//                   SizedBox(height: 16),
//                   // Category Dropdown
//                   categorieProviderValue.when(
//                     data: (categories) => DropdownButtonFormField<String>(
//                       value: _category,
//                       onChanged: (newValue) => setState(() => _category = newValue),
//                       items: categories.map((category) => DropdownMenuItem(value: category.id, child: Text(category.titre))).toList(),
//                       decoration: InputDecoration(labelText: 'Category'),
//                       validator: (value) => value == null ? 'Please select a category' : null,
//                     ),
//                     loading: () => CircularProgressIndicator(),
//                     error: (error, stack) => Text('Error: $error'),
//                   ),
//                   SizedBox(height: 16),
//                   // Total Donation Amount
//                   TextFormField(
//                     controller: _montantTotalController,
//                     decoration: InputDecoration(labelText: 'Total Donation Required'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) => value!.isEmpty ? 'Please enter a total donation amount' : null,
//                   ),
//                   SizedBox(height: 16),
//                   // Donation Start Date Picker
//                   GestureDetector(
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime.now(),
//                         lastDate: DateTime(2101),
//                       );
//                       if (pickedDate != null) {
//                         setState(() {
//                           _dateDebutCollecte = pickedDate;
//                         });
//                       }
//                     },
//                     child: AbsorbPointer(
//                       child: TextFormField(
//                         decoration: InputDecoration(labelText: 'Choose Donation Start Date'),
//                         controller: TextEditingController(text: _dateDebutCollecte == null ? '' : _dateDebutCollecte.toString().substring(0, 10)),
//                         validator: (value) => _dateDebutCollecte == null ? 'Please choose a start date' : null,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // Donation Expiration Date Picker
//                   GestureDetector(
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime.now(),
//                         lastDate: DateTime(2101),
//                       );
//                       if (pickedDate != null) {
//                         setState(() {
//                           _dateFinCollecte = pickedDate;
//                         });
//                       }
//                     },
//                     child: AbsorbPointer(
//                       child: TextFormField(
//                         decoration: InputDecoration(labelText: 'Choose Donation Expiration Date'),
//                         controller: TextEditingController(text: _dateFinCollecte == null ? '' : _dateFinCollecte.toString().substring(0, 10)),
//                         validator: (value) => _dateFinCollecte == null ? 'Please choose an expiration date' : null,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // Project Description
//                   TextFormField(
//                     controller: _descriptionController,
//                     decoration: InputDecoration(labelText: 'Fund Usage Plan'),
//                     maxLines: 3,
//                     validator: (value) => value!.isEmpty ? 'Please enter a fund usage plan' : null,
//                   ),
//                   SizedBox(height: 16),
//                   // Name of Recipients
//                   TextFormField(
//                     controller: _recipientsNameController,
//                     decoration: InputDecoration(labelText: 'Name of Recipients (People/Organization)'),
//                     validator: (value) => value!.isEmpty ? 'Please enter the name of recipients' : null,
//                   ),
//                   SizedBox(height: 16),
//                   // Donation Proposal Document Picker
//                   GestureDetector(
//                     onTap: () async {
//                       final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
//                       if (result != null && result.files.single.path != null) {
//                         setState(() {
//                           _proposalDocument = File(result.files.single.path!);
//                         });
//                       }
//                     },
//                     child: Container(
//                       height: 50,
//                       width: double.infinity,
//                       color: Colors.grey[200],
//                       child: Center(
//                         child: Text(_proposalDocument == null ? 'Upload Donation Proposal Documents' : _proposalDocument!.path.split('/').last),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // Medical Documents Picker
//                   GestureDetector(
//                     onTap: () async {
//                       final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
//                       if (result != null && result.files.single.path != null) {
//                         setState(() {
//                           _medicalDocument = File(result.files.single.path!);
//                         });
//                       }
//                     },
//                     child: Container(
//                       height: 50,
//                       width: double.infinity,
//                       color: Colors.grey[200],
//                       child: Center(
//                         child: Text(_medicalDocument == null ? 'Upload Medical Documents (optional for medical)' : _medicalDocument!.path.split('/').last),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // Project Story
//                   TextFormField(
//                     controller: _histoireController,
//                     decoration: InputDecoration(labelText: 'Story'),
//                     maxLines: 3,
//                     validator: (value) => value!.isEmpty ? 'Please enter the story of donation recipients' : null,
//                   ),
//                   SizedBox(height: 16),
//                   // Terms and Conditions Checkbox
//                   Row(
//                     children: [
//                       Checkbox(value: true, onChanged: (value) {}),
//                       Expanded(child: Text('By checking this, you agree to the terms & conditions that apply to us.')),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   // Create & Submit Button
//                   Row(
//                     children: [
//                       ElevatedButton(
//                         onPressed: () async {
//                           if (_formKey.currentState!.validate()) {
//                             setState(() => _isLoading = true);

//                             try {
//                               final storageService = StorageService(FirebaseStorage.instance);
//                               List<String> imageUrls = [];
//                               for (var image in _images) {
//                                 String imageUrl = await storageService.uploadFile(image, 'projets/images/${image.path.split('/').last}');
//                                 imageUrls.add(imageUrl);
//                               }
//                               String? proposalDocumentUrl;
//                               if (_proposalDocument != null) {
//                                 proposalDocumentUrl = await storageService.uploadFile(_proposalDocument!, 'projets/documents/${_proposalDocument!.path.split('/').last}');
//                               }
//                               String? medicalDocumentUrl;
//                               if (_medicalDocument != null) {
//                                 medicalDocumentUrl = await storageService.uploadFile(_medicalDocument!, 'projets/medical/${_medicalDocument!.path.split('/').last}');
//                               }

//                               await projetViewModel.setProjet(
//                                 titre: _titreController.text,
//                                 description: _descriptionController.text,
//                                 montantTotal: int.parse(_montantTotalController.text),
//                                 dateDebutCollecte: _dateDebutCollecte!,
//                                 dateFinCollecte: _dateFinCollecte!,
//                                 histoire: _histoireController.text,
//                                 montantObtenu: 0, // montantObtenu initially 0
//                                 categorieId: _category!, // CategorieId from dropdown
//                                 createdAt: DateTime.now(),
//                                 imageUrls: imageUrls,
//                                 proposalDocumentUrl: proposalDocumentUrl,
//                                 medicalDocumentUrl: medicalDocumentUrl,
//                               );

//                               setState(() => _isLoading = false);
//                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Project created successfully')));
//                             } catch (e) {
//                               setState(() => _isLoading = false);
//                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
//                             }
//                           }
//                         },
//                         child: Text('Create & Submit'),
//                       ),
//                       SizedBox(width: 16),
//                       ElevatedButton(
//                         onPressed: () {},
//                         child: Text('Draft'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (_isLoading)
//             Center(
//               child: CircularProgressIndicator(),
//             ),
//         ],
//       ),
//     );
//   }
// }


////////////////////////////////////////////////////////////////////////////////////////////////////////


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