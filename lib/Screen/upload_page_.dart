import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Tweet extends StatefulWidget {
  const Tweet({Key? key}) : super(key: key);

  @override
  _TweetState createState() => _TweetState();
}

class _TweetState extends State<Tweet> {
  final TextEditingController _textController = TextEditingController();
  XFile? _pickedFile;
  String? _imageUrl;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _pickedFile = XFile(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _uploadTweet() async {
    if (_textController.text.isEmpty) {
      // Don't upload tweet if text is empty
      return;
    }

    String? imageUrl;
    if (_pickedFile != null) {
      // Upload image to Firebase Storage
      final Reference ref = _storage.ref().child('images/${DateTime.now().millisecondsSinceEpoch}');
      final TaskSnapshot task = await ref.putFile(File(_pickedFile!.path));
      imageUrl = await task.ref.getDownloadURL();
    }

    // Save tweet data to Firestore
    await _firestore.collection('tweets').add({
      'text': _textController.text,
      'image_url': imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
      // Add additional fields as needed
    });

    // Clear text field and image selection
    _textController.clear();
    setState(() {
      _pickedFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compose Tweet'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (_pickedFile != null)
                Image.file(
                  File(_pickedFile!.path),
                  fit: BoxFit.cover,
                ),
              ElevatedButton(
                onPressed: () => _getImage(ImageSource.gallery),
                child: const Text('Pick Image'),
              ),
              TextField(
                controller: _textController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'What\'s happening?',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _uploadTweet,
                child: const Text('Tweet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
