import 'dart:io';

import 'package:event_app/core/services/storage_service.dart';
import 'package:event_app/core/widgets/main_app_bar.dart';
import 'package:event_app/features/events/domain/entities/event.dart';
import 'package:event_app/features/events/presentation/bloc/events_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class CreateEventPage extends StatefulWidget {
  final bool? isEditable;
  final Event? event;

  const CreateEventPage({super.key, this.isEditable, this.event});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  late String? thumbnailUrl;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEditable == true && widget.event != null) {
      final event = widget.event!;
      _titleController.text = event.title;
      _locationController.text = event.location;
      _dateController.text = event.date;
      _timeController.text = event.time;
      _categoryController.text = event.category;
      _descriptionController.text = event.description;
      thumbnailUrl = event.thumbnail;
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final storageService = StorageService();

      setState(() {
        _isLoading = true;
      });

      final tempThumbnailUrl =
          await storageService.uploadEventThumbnail(imageFile);

      setState(() {
        _isLoading = false;
      });

      if (tempThumbnailUrl != null) {
        setState(() {
          _image = imageFile;
          thumbnailUrl = tempThumbnailUrl;
        });
      } else {
        showMessage('Failed to upload image');
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      showMessage('No image selected');
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != TimeOfDay.now()) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void closeImageLoadingDialog() {
      context.pop();
    }

    showImageLoadingDialog() {
      return showDialog(
        context: context,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      ).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    return BlocListener<EventsBloc, EventsState>(
      bloc: context.read<EventsBloc>(),
      listener: (context, state) {
        context
            .read<EventsBloc>()
            .add(LoadEventsByUserEvent(FirebaseAuth.instance.currentUser!.uid));
        if (state is EventSuccessfullyCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Event created successfully.')),
          );
          context.goNamed('myEvents');
        } else if (state is EventSuccessfullyUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Event updated successfully.')),
          );
          context.goNamed('myEvents');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(
          title: 'Create Event',
          automaticallyImplyLeading: true,
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Location',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter location';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      onTap: () {
                        _selectDate(context);
                      },
                      readOnly: true,
                      controller: _dateController,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            // _selectDate(context);
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select a date';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      onTap: () {
                        _selectTime(context);
                      },
                      readOnly: true,
                      controller: _timeController,
                      decoration: InputDecoration(
                        labelText: 'Time',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () {
                            // _selectTime(context);
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select a time';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _categoryController,
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter category';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    if (widget.isEditable == true &&
                        widget.event != null &&
                        widget.event!.thumbnail.isNotEmpty &&
                        _image == null)
                      Image.network(
                        widget.event!.thumbnail,
                        // width: double.infinity,
                        // height: 160,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 160,
                            color: Colors.grey[200],
                            child: const Icon(Icons.broken_image,
                                size: 50, color: Colors.grey),
                          );
                        },
                      ),
                    SizedBox(height: 16.0),
                    GestureDetector(
                      onTap: () async {
                        _isLoading = true;
                        if (_isLoading) showImageLoadingDialog();
                        await _pickImage();
                        if (!_isLoading) closeImageLoadingDialog();
                      },
                      child: _image != null
                          ? Image.file(_image!)
                          : Container(
                              color: Colors.grey[200],
                              height: 150,
                              child: Icon(Icons.add_a_photo,
                                  color: Colors.grey[800]),
                            ),
                    ),
                    SizedBox(height: 60.0),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (thumbnailUrl != null) {
                        final User? user = _auth.currentUser;
                        final event = Event(
                          id: widget.isEditable == true ? widget.event?.id : '',
                          title: _titleController.text,
                          location: _locationController.text,
                          date: _dateController.text,
                          time: _timeController.text,
                          organizerId: user?.uid ?? 'N/A',
                          organizerName: user?.displayName ?? 'N/A',
                          thumbnail: thumbnailUrl!,
                          category: _categoryController.text,
                          description: _descriptionController.text,
                        );
                        widget.isEditable == true
                            ? context
                                .read<EventsBloc>()
                                .add(UpdateEventEvent(event))
                            : context
                                .read<EventsBloc>()
                                .add(CreateEventEvent(event));
                      } else if (thumbnailUrl == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please select an image')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Failed to upload image')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    backgroundColor: Colors.blue.shade900,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(widget.isEditable == true
                      ? 'Update Event'
                      : 'Create Event'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
