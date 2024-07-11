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
// import 'package:video_player/video_player.dart';

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
//   List<XFile?> _images = [];
//   List<XFile?> _video = [];
//   List<XFile?> _documents = [];
//   VideoPlayerController? _videoController;
//   bool _isLoading = false;
//   bool _termsAndConditionsChecked = false;

//   // Add the missing declaration of _thumbnailSelected
//   bool _thumbnailSelected = false; 
//   XFile? _thumbnailImage;
//    String? _category; 

//   Future<void> _selectVideo() async {
//     // Autoriser uniquement la sélection de la galerie
//     final pickedVideo = await ImagePicker().pickVideo(
//       source: ImageSource.gallery,
//       maxDuration: const Duration(minutes: 5), // Limite à 5 minutes
//     );

//     if (pickedVideo != null) {
//       setState(() {
//         _video.add(pickedVideo);
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
//             const SnackBar(content: Text('Cette image sera utilisée comme vignette.')),
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

//   Future<void> _selectDocument() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );
//     if (result != null && result.files.single.path != null) {
//       setState(() {
//         _documents.add(XFile(result.files.single.path!));
//       });
//     }
//   }

//   void _removeDocument(int index) {
//     setState(() {
//       _documents.removeAt(index);
//     });
//   }

//   void _removeVideo(int index) {
//     setState(() {
//       _video.removeAt(index);
//     });
//   }

//   @override
//   void dispose() {
//     _titreController.dispose();
//     _descriptionController.dispose();
//     _montantTotalController.dispose();
//     _histoireController.dispose();
//     _recipientsNameController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final projetViewModel = ref.watch(projetViewModelProvider.notifier);
//     final categorieProviderValue = ref.watch(categorieProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Créer une nouvelle collecte de fonds'),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Section de la vignette
//                   if (_thumbnailImage != null)
//                     Image.file(
//                       File(_thumbnailImage!.path),
//                       height: 100,
//                       width: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   const SizedBox(height: 16),

//                   // Section des images
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Titre de la section des images
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

//                       // Bouton pour ajouter des images
//                       Row(
//                         children: [
//                           // Icône pour ajouter des images
//                           IconButton(
//                             onPressed: () {
//                               _selectImage(ImageSource.gallery);
//                             },
//                             icon: const Icon(Icons.add_photo_alternate),
//                             iconSize: 32,
//                           ),
//                           // Texte pour le bouton
//                           const Text('Ajouter des images'),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                     ],
//                   ),

//                   // Section pour les documents
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Titre de la section des documents
//                       const Padding(
//                         padding: EdgeInsets.only(left: 16.0),
//                         child: Text(
//                           'Documents',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),

//                       // Documents
//                       SizedBox(
//                         height: 100,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: _documents.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.only(right: 8.0),
//                               child: Stack(
//                                 alignment: Alignment.topRight,
//                                 children: [
//                                   // Affichez le nom du document
//                                   Container(
//                                     height: 100,
//                                     width: 100,
//                                     color: Colors.grey[200],
//                                     child: Center(
//                                       child: Text(_documents[index]!.path.split('/').last),
//                                     ),
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                       _removeDocument(index);
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

//                       // Bouton pour ajouter des documents
//                       Row(
//                         children: [
//                           // Icône pour ajouter des documents
//                           IconButton(
//                             onPressed: () {
//                               _selectDocument();
//                             },
//                             icon: const Icon(Icons.add_business),
//                             iconSize: 32,
//                           ),
//                           // Texte pour le bouton
//                           const Text('Ajouter des documents'),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                     ],
//                   ),

//                   // Section pour les vidéos
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Titre de la section des vidéos
//                       const Padding(
//                         padding: EdgeInsets.only(left: 16.0),
//                         child: Text(
//                           'Vidéos',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),

//                       // Vidéos
//                       SizedBox(
//                         height: 100,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: _video.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.only(right: 8.0),
//                               child: Stack(
//                                 alignment: Alignment.topRight,
//                                 children: [
//                                   // Affichez le nom de la vidéo
//                                   Container(
//                                     height: 100,
//                                     width: 100,
//                                     color: Colors.grey[200],
//                                     child: Center(
//                                       child: Text(_video[index]!.path.split('/').last),
//                                     ),
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                       _removeVideo(index);
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

//                       // Bouton pour ajouter des vidéos
//                       Row(
//                         children: [
//                           // Icône pour ajouter des vidéos
//                           IconButton(
//                             onPressed: () {
//                               _selectVideo();
//                             },
//                             icon: const Icon(Icons.video_library),
//                             iconSize: 32,
//                           ),
//                           // Texte pour le bouton
//                           const Text('Ajouter des vidéos'),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                     ],
//                   ),

//                   // Champ de texte pour le titre
//                   TextFormField(
//                     controller: _titreController,
//                     decoration: InputDecoration(
//                       labelText: 'Titre',
//                       prefixIcon: const Icon(Icons.title),
//                     ),
//                     validator: (value) => value!.isEmpty ? 'Veuillez entrer un titre' : null,
//                   ),
//                   const SizedBox(height: 16),

//                   // Menu déroulant pour la catégorie
//                   categorieProviderValue.when(
//                     data: (categories) => DropdownButtonFormField<String>(
//                       value: _category,
//                       onChanged: (newValue) => setState(() => _category = newValue),
//                       items: categories.map((category) => DropdownMenuItem(value: category.id, child: Text(category.titre))).toList(),
//                       decoration: InputDecoration(
//                         labelText: 'Catégorie',
//                         prefixIcon: const Icon(Icons.category),
//                       ),
//                       validator: (value) => value == null ? 'Veuillez sélectionner une catégorie' : null,
//                     ),
//                     loading: () => const CircularProgressIndicator(),
//                     error: (error, stack) => Text('Erreur : $error'),
//                   ),
//                   const SizedBox(height: 16),

//                   // Champ de texte pour le montant total
//                   TextFormField(
//                     controller: _montantTotalController,
//                     decoration: InputDecoration(
//                       labelText: 'Montant total requis',
//                       prefixIcon: const Icon(Icons.attach_money),
//                     ),
//                     keyboardType: TextInputType.number,
//                     validator: (value) => value!.isEmpty ? 'Veuillez entrer un montant total' : null,
//                   ),
//                   const SizedBox(height: 16),

//                   // Sélecteur de date pour la date de début de la collecte
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
//                         decoration: InputDecoration(
//                           labelText: 'Date de début de la collecte',
//                           prefixIcon: const Icon(Icons.calendar_today),
//                         ),
//                         controller: TextEditingController(text: _dateDebutCollecte == null ? '' : _dateDebutCollecte.toString().substring(0, 10)),
//                         validator: (value) => _dateDebutCollecte == null ? 'Veuillez choisir une date de début' : null,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),

//                   // Sélecteur de date pour la date de fin de la collecte
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
//                         decoration: InputDecoration(
//                           labelText: 'Date de fin de la collecte',
//                           prefixIcon: const Icon(Icons.calendar_today),
//                         ),
//                         controller: TextEditingController(text: _dateFinCollecte == null ? '' : _dateFinCollecte.toString().substring(0, 10)),
//                         validator: (value) => _dateFinCollecte == null ? 'Veuillez choisir une date de fin' : null,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),

//                   // Champ de texte pour la description du projet
//                   TextFormField(
//                     controller: _descriptionController,
//                     decoration: InputDecoration(
//                       labelText: 'Plan d’utilisation des fonds',
//                       prefixIcon: const Icon(Icons.description),
//                     ),
//                     maxLines: 3,
//                     validator: (value) => value!.isEmpty ? 'Veuillez entrer un plan d’utilisation des fonds' : null,
//                   ),
//                   const SizedBox(height: 16),

//                   // Champ de texte pour le nom des bénéficiaires
//                   TextFormField(
//                     controller: _recipientsNameController,
//                     decoration: InputDecoration(
//                       labelText: 'Nom des bénéficiaires (Personnes/Organisations)',
//                       prefixIcon: const Icon(Icons.people),
//                     ),
//                     validator: (value) => value!.isEmpty ? 'Veuillez entrer le nom des bénéficiaires' : null,
//                   ),
//                   const SizedBox(height: 16),

//                   // Champ de texte pour l’histoire du projet
//                   TextFormField(
//                     controller: _histoireController,
//                     decoration: InputDecoration(
//                       labelText: 'Histoire',
//                       // prefixIcon: const Icon(Icons.story),
//                     ),
//                     maxLines: 3,
//                     validator: (value) => value!.isEmpty ? 'Veuillez entrer l’histoire des bénéficiaires' : null,
//                   ),
//                   const SizedBox(height: 16),

//                   // Case à cocher pour les termes et conditions
//                   Row(
//                     children: [
//                       Checkbox(
//                         value: _termsAndConditionsChecked,
//                         onChanged: (value) {
//                           setState(() {
//                             _termsAndConditionsChecked = value!;
//                           });
//                         },
//                       ),
//                       Expanded(child: const Text('En cochant cette case, vous acceptez les termes et conditions qui s’appliquent à nous.')),
//                     ],
//                   ),
//                   const SizedBox(height: 16),

//                   // Bouton pour créer et soumettre
//                   ElevatedButton(
//                     onPressed: _termsAndConditionsChecked
//                         ? () async {
//                             if (_formKey.currentState!.validate()) {
//                               // Afficher un popup avec une barre de progression
//                               showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     title: const Text('Création en cours'),
//                                     content: StatefulBuilder(
//                                       builder: (context, setState) {
//                                         return Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             const CircularProgressIndicator(),
//                                             const SizedBox(height: 16),
//                                             Text('Chargement des données...'),
//                                             const SizedBox(height: 16),
//                                             ElevatedButton(
//                                               onPressed: () {
//                                                 // Annuler l'opération
//                                                 Navigator.of(context).pop();
//                                                 setState(() => _isLoading = false);
//                                               },
//                                               child: const Text('Annuler'),
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     ),
//                                   );
//                                 },
//                               );

//                               setState(() => _isLoading = true);

//                               try {
//                                 final storageService = StorageService(FirebaseStorage.instance);
//                                 List<String> imageUrls = [];
//                                 for (var image in _images) {
//                                   String imageUrl = await storageService.uploadFile(File(image!.path), 'projets/images/${image.path.split('/').last}');
//                                   imageUrls.add(imageUrl);
//                                 }
//                                 List<String> documentUrls = [];
//                                 for (var document in _documents) {
//                                   String documentUrl = await storageService.uploadFile(File(document!.path), 'projets/documents/${document.path.split('/').last}');
//                                   documentUrls.add(documentUrl);
//                                 }
//                                 List<String> videoUrls = [];
//                                 for (var videoFile in _video) {
//                                   String videoUrl = await storageService.uploadFile(File(videoFile!.path), 'projets/videos/${videoFile.path.split('/').last}');
//                                   videoUrls.add(videoUrl);
//                                 }

//                                 // Créer le projet
//                                 await projetViewModel.setProjet(
//                                   titre: _titreController.text,
//                                   description: _descriptionController.text,
//                                   montantTotal: int.parse(_montantTotalController.text),
//                                   dateDebutCollecte: _dateDebutCollecte!,
//                                   dateFinCollecte: _dateFinCollecte!,
//                                   histoire: _histoireController.text,
//                                   montantObtenu: 0, // montantObtenu initialement 0
//                                   categorieId: _category!, // CategorieId du menu déroulant
//                                   createdAt: DateTime.now(),
//                                   imageUrls: imageUrls,
//                                   documents: documentUrls,
//                                   videos: videoUrls,
//                                   likes: [],
//                                 );

//                                 // Fermer le popup et afficher un message de succès
//                                 Navigator.of(context).pop();
//                                 setState(() => _isLoading = false);
//                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('Projet créé avec succès')));
//                               } catch (e) {
//                                 // Fermer le popup et afficher un message d'erreur
//                                 Navigator.of(context).pop();
//                                 setState(() => _isLoading = false);
//                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur : $e')));
//                               }
//                             }
//                           }
//                         : null,
//                     child: const Text('Créer et soumettre'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (_isLoading)
//             Center(
//               child: const CircularProgressIndicator(),
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
                                    likes: [],
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
                                    likes: [],
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
