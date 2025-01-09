import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../localization/custom_localizations.dart';

class ChurchNewsPage extends StatefulWidget {
  @override
  _ChurchNewsPageState createState() => _ChurchNewsPageState();
}

class _ChurchNewsPageState extends State<ChurchNewsPage> {
  List<Map<String, dynamic>> _posts = [];
  File? _imageFile;
  File? _videoFile;
  File? _audioFile;
  final _picker = ImagePicker();
  String _title = '';
  String _content = '';

  // Opens a dialog for adding a new post
  void _showAddPostDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('إضافة منشور جديد'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'العنوان'),
                  onChanged: (value) {
                    setState(() {
                      _title = value;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'المحتوى'),
                  onChanged: (value) {
                    setState(() {
                      _content = value;
                    });
                  },
                  maxLines: 2,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.image),
                      onPressed: _pickImage,
                    ),
                    IconButton(
                      icon: Icon(Icons.video_library),
                      onPressed: _pickVideo,
                    ),
                    IconButton(
                      icon: Icon(Icons.music_note),
                      onPressed: _pickAudio,
                    ),
                  ],
                ),
                if (_imageFile != null)
                  Image.file(_imageFile!, height: 100, fit: BoxFit.cover),
                if (_videoFile != null)
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: VideoPlayer(
                        VideoPlayerController.file(_videoFile!)..initialize()),
                  ),
                if (_audioFile != null) Text('تم تحميل ملف صوتي'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                _addPost();
                Navigator.of(context).pop();
              },
              child: Text('نشر'),
            ),
          ],
        );
      },
    );
  }

  // Method to add a post to the list
  void _addPost() {
    if (_title.isNotEmpty ||
        _content.isNotEmpty ||
        _imageFile != null ||
        _videoFile != null ||
        _audioFile != null) {
      setState(() {
        _posts.add({
          'title': _title,
          'content': _content,
          'image': _imageFile,
          'video': _videoFile,
          'audio': _audioFile,
        });
      });
      _title = '';
      _content = '';
      _imageFile = null;
      _videoFile = null;
      _audioFile = null;
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickAudio() async {
    // Add logic to pick an audio file
  }

  @override
  Widget build(BuildContext context) {
    final localization = CustomLocalizations.of(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(localization.translate('News')),
      //   centerTitle: true,
      //
      // ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/seamless.jpg'),
                fit: BoxFit.cover, // Ensure the background image is contained within the screen
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _posts.length,
                      itemBuilder: (context, index) {
                        final post = _posts[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(post['title'] ?? ''),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (post['content'] != null)
                                  Text(post['content']),
                                if (post['image'] != null)
                                  Image.file(post['image'],
                                      height: 100, fit: BoxFit.cover),
                                if (post['video'] != null)
                                  AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: VideoPlayer(
                                        VideoPlayerController.file(
                                            post['video'])
                                          ..initialize()),
                                  ),
                                if (post['audio'] != null)
                                  Text('ملف صوتي مرفق'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPostDialog,
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        tooltip: localization.translate('Add Post'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
