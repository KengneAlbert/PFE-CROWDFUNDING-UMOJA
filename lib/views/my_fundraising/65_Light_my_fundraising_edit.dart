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

class EditFundraisingPage extends ConsumerStatefulWidget {
  final String projectId;

  const EditFundraisingPage({Key? key, required this.projectId}) : super(key: key);

  @override
  _EditFundraisingPageState createState() => _EditFundraisingPageState();
}

class _EditFundraisingPageState extends ConsumerState<EditFundraisingPage> {
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
  bool _isEditing = false;

  ProjetModel? _currentProject;

  Future<void> _loadProject() async {
    final projetViewModel = ref.read(projetViewModelProvider.notifier);
    _currentProject = await projetViewModel.fetchProjectById(widget.projectId);
    if (_currentProject != null) {
      _titreController.text = _currentProject!.titre;
      _descriptionController.text = _currentProject!.description;
      _montantTotalController.text = _currentProject!.montantTotal.toString();
      _dateDebutCollecte = _currentProject!.dateDebutCollecte;
      _dateFinCollecte = _currentProject!.dateFinCollecte;
      _histoireController.text = _currentProject!.histoire;
      _recipientsNameController.text = _currentProject!.histoire;
      _category = _currentProject!.categorieId;

      if (_currentProject!.imageUrls.isNotEmpty) {
        _images = _currentProject!.imageUrls.map((imageUrl) => null).toList();
        for (int i = 0; i < _currentProject!.imageUrls.length; i++) {
          final storageService = StorageService(FirebaseStorage.instance);
          final imageFile = await storageService.downloadFile(_currentProject!.imageUrls[i]);
          if (imageFile != null) {
            _images[i] = XFile(imageFile.path);
            if (i == 0) {
              _thumbnailImage = _images[i];
              _thumbnailSelected = true;
            }
          }
        }
      }

      if (_currentProject!.videoUrl != null) {
        final storageService = StorageService(FirebaseStorage.instance);
        final videoFile = await storageService.downloadFile(_currentProject!.videoUrl!);
        if (videoFile != null) {
          _video = XFile(videoFile.path);
          _videoSelected = true;
          _videoController = VideoPlayerController.file(File(_video!.path))
            ..initialize().then((_) {
              setState(() {});
            });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadProject();
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

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _selectVideo(ImageSource source) async {
    if (source == ImageSource.gallery) {
      final pickedVideo = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 5),
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
  Widget build(BuildContext context) {
    final categorieProviderValue = ref.watch(categorieProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier une collecte de fonds'),
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
                  Row(
                    children: [
                      IconButton(
                        onPressed: _toggleEditing,
                        icon: Icon(_isEditing ? Icons.save : Icons.edit),
                      ),
                      const Text('Modifier'),
                    ],
                  ),
                  if (_thumbnailImage != null)
                    Image.file(
                      File(_thumbnailImage!.path),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  const SizedBox(height: 16),
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
                      if (!_videoSelected && _isEditing)
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
                  if (_videoSelected && _isEditing)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _selectImage(ImageSource.gallery);
                              },
                              icon: const Icon(Icons.add_photo_alternate),
                              iconSize: 32,
                            ),
                            const Text('Ajouter des images'),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  TextFormField(
                    controller: _titreController,
                    decoration: InputDecoration(
                      labelText: 'Titre',
                      prefixIcon: const Icon(Icons.title),
                    ),
                    enabled: _isEditing,
                    validator: (value) => value!.isEmpty ? 'Veuillez entrer un titre' : null,
                  ),
                  const SizedBox(height: 16),
                  categorieProviderValue.when(
                    data: (categories) => DropdownButtonFormField<String>(
                      value: _category,
                      onChanged: _isEditing
                          ? (newValue) => setState(() => _category = newValue)
                          : null,
                      items: categories
                          .map((category) => DropdownMenuItem(
                              value: category.id, child: Text(category.titre)))
                          .toList(),
                      decoration: InputDecoration(
                        labelText: 'Catégorie',
                        prefixIcon: const Icon(Icons.category),
                      ),
                      validator: (value) => value == null
                          ? 'Veuillez sélectionner une catégorie'
                          : null,
                    ),
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stack) => Text('Erreur : $error'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _montantTotalController,
                    decoration: InputDecoration(
                      labelText: 'Montant total requis',
                      prefixIcon: const Icon(Icons.attach_money),
                    ),
                    keyboardType: TextInputType.number,
                    enabled: _isEditing,
                    validator: (value) =>
                        value!.isEmpty ? 'Veuillez entrer un montant total' : null,
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _isEditing
                        ? () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: _dateDebutCollecte ?? DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                _dateDebutCollecte = pickedDate;
                              });
                            }
                          }
                        : null,
                    child: AbsorbPointer(
                      absorbing: !_isEditing,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Date de début de la collecte',
                          prefixIcon: const Icon(Icons.calendar_today),
                        ),
                        controller: TextEditingController(
                            text: _dateDebutCollecte == null
                                ? ''
                                : _dateDebutCollecte.toString().substring(0, 10)),
                        enabled: _isEditing,
                        validator: (value) => _dateDebutCollecte == null
                            ? 'Veuillez choisir une date de début'
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _isEditing
                        ? () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: _dateFinCollecte ?? DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                _dateFinCollecte = pickedDate;
                              });
                            }
                          }
                        : null,
                    child: AbsorbPointer(
                      absorbing: !_isEditing,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Date de fin de la collecte',
                          prefixIcon: const Icon(Icons.calendar_today),
                        ),
                        controller: TextEditingController(
                            text: _dateFinCollecte == null
                                ? ''
                                : _dateFinCollecte.toString().substring(0, 10)),
                        enabled: _isEditing,
                        validator: (value) => _dateFinCollecte == null
                            ? 'Veuillez choisir une date de fin'
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Plan d’utilisation des fonds',
                      prefixIcon: const Icon(Icons.description),
                    ),
                    maxLines: 3,
                    enabled: _isEditing,
                    validator: (value) => value!.isEmpty
                        ? 'Veuillez entrer un plan d’utilisation des fonds'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _recipientsNameController,
                    decoration: InputDecoration(
                      labelText:
                          'Nom des bénéficiaires (Personnes/Organisations)',
                      prefixIcon: const Icon(Icons.people),
                    ),
                    enabled: _isEditing,
                    validator: (value) => value!.isEmpty
                        ? 'Veuillez entrer le nom des bénéficiaires'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _isEditing
                        ? () {
                            _selectDocument('businessModel');
                          }
                        : null,
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: Center(
                        child: Text(_businessModelDocument == null
                            ? 'Télécharger le modèle d’entreprise (PDF)'
                            : _businessModelDocument!.path.split('/').last),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _isEditing
                        ? () {
                            _selectDocument('businessPlan');
                          }
                        : null,
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: Center(
                        child: Text(_businessPlanDocument == null
                            ? 'Télécharger le plan d’entreprise (PDF)'
                            : _businessPlanDocument!.path.split('/').last),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _histoireController,
                    decoration: InputDecoration(
                      labelText: 'Histoire',
                    ),
                    maxLines: 3,
                    enabled: _isEditing,
                    validator: (value) => value!.isEmpty
                        ? 'Veuillez entrer l’histoire des bénéficiaires'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _isEditing && _formKey.currentState!.validate()
                        ? () async {
                            if (_formKey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Modification en cours'),
                                    content: StatefulBuilder(
                                      builder: (context, setState) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const CircularProgressIndicator(),
                                            const SizedBox(height: 16),
                                            const Text(
                                                'Chargement des données...'),
                                            const SizedBox(height: 16),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                setState(() =>
                                                    _isLoading = false);
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
                                final storageService = StorageService(
                                    FirebaseStorage.instance);
                                List<String> imageUrls = [];
                                for (var image in _images) {
                                  if (image != null) {
                                    String imageUrl = await storageService
                                        .uploadFile(
                                            File(image.path),
                                            'projets/images/${image.path.split('/').last}');
                                    imageUrls.add(imageUrl);
                                  } else {
                                    imageUrls.add(_currentProject!.imageUrls[
                                        imageUrls.length]);
                                  }
                                }
                                String? businessModelDocumentUrl;
                                if (_businessModelDocument != null) {
                                  businessModelDocumentUrl =
                                      await storageService.uploadFile(
                                          _businessModelDocument!,
                                          'projets/documents/${_businessModelDocument!.path.split('/').last}');
                                } else {
                                  businessModelDocumentUrl =
                                      _currentProject!
                                          .businessModelDocumentUrl;
                                }
                                String? businessPlanDocumentUrl;
                                if (_businessPlanDocument != null) {
                                  businessPlanDocumentUrl =
                                      await storageService.uploadFile(
                                          _businessPlanDocument!,
                                          'projets/documents/${_businessPlanDocument!.path.split('/').last}');
                                } else {
                                  businessPlanDocumentUrl =
                                      _currentProject!.businessPlanDocumentUrl;
                                }

                                final projetViewModel = ref.read(projetViewModelProvider.notifier);
                                if (_video != null) {
                                  String videoUrl = await storageService.uploadFile(
                                      File(_video!.path),
                                      'projets/videos/${_video!.path.split('/').last}');
                                  await projetViewModel.updateProject(
                                    widget.projectId,
                                    ProjetModel(
                                      id: widget.projectId,
                                      titre: _titreController.text,
                                      description: _descriptionController.text,
                                      montantTotal:
                                          int.parse(_montantTotalController.text),
                                      dateDebutCollecte: _dateDebutCollecte!,
                                      dateFinCollecte: _dateFinCollecte!,
                                      histoire: _histoireController.text,
                                      montantObtenu:
                                          _currentProject!.montantObtenu,
                                      categorieId: _category!,
                                      userId: _currentProject!.userId,
                                      createdAt: _currentProject!.createdAt,
                                      imageUrls: imageUrls,
                                      businessModelDocumentUrl:
                                          businessModelDocumentUrl,
                                      businessPlanDocumentUrl:
                                          businessPlanDocumentUrl,
                                      videoUrl: videoUrl,
                                    ),
                                  );
                                } else {
                                  await projetViewModel.updateProject(
                                    widget.projectId,
                                    ProjetModel(
                                      id: widget.projectId,
                                      titre: _titreController.text,
                                      description: _descriptionController.text,
                                      montantTotal:
                                          int.parse(_montantTotalController.text),
                                      dateDebutCollecte: _dateDebutCollecte!,
                                      dateFinCollecte: _dateFinCollecte!,
                                      histoire: _histoireController.text,
                                      montantObtenu:
                                          _currentProject!.montantObtenu,
                                      categorieId: _category!,
                                      userId: _currentProject!.userId,
                                      createdAt: _currentProject!.createdAt,
                                      imageUrls: imageUrls,
                                      businessModelDocumentUrl:
                                          businessModelDocumentUrl,
                                      businessPlanDocumentUrl:
                                          businessPlanDocumentUrl,
                                      videoUrl: _currentProject!.videoUrl,
                                    ),
                                  );
                                }

                                Navigator.of(context).pop();
                                setState(() => _isLoading = false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Projet modifié avec succès')));
                              } catch (e) {
                                Navigator.of(context).pop();
                                setState(() => _isLoading = false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Erreur : $e')));
                              }
                            }
                          }
                        : null,
                    child: const Text('Modifier'),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
