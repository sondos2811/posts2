// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, library_private_types_in_public_api, unused_local_variable

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetPost extends StatelessWidget {
  final String title, body;
  final List<dynamic> tags;
  final int like_reactions, dislike_reactions, views;

  const GetPost({
    super.key,
    required this.title,
    required this.body,
    required this.tags,
    required this.like_reactions,
    required this.dislike_reactions,
    required this.views,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                SizedBox(height: 10),
                Text(body),
                SizedBox(height: 10),
                Text(
                    'Tags: ${tags.join(', ')}'), // Displaying tags as a comma-separated string
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(like_reactions.toString()),
                    Icon(Icons.thumb_up),
                    SizedBox(width: 10),
                    Text(dislike_reactions.toString()),
                    Icon(Icons.thumb_down),
                    SizedBox(width: 10),
                    Text(views.toString()),
                    Icon(Icons.visibility),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditPost extends StatefulWidget {
  final int id;
  final String initialTitle;
  final String initialBody;

  const EditPost(
      {super.key,
      required this.id,
      required this.initialTitle,
      required this.initialBody});

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _bodyController = TextEditingController(text: widget.initialBody);
  }

  Future<void> _updatePost() async {
    Uri.parse('https://dummyjson.com/posts/${widget.id}');
    Navigator.pop(context, {
      'title': _titleController.text,
      'body': _bodyController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _bodyController,
              decoration: const InputDecoration(labelText: 'Body'),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updatePost,
              child: const Text("Update Post"),
            ),
          ],
        ),
      ),
    );
  }
}

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  Future<void> _addPost() async {
    final String title = _titleController.text;
    final String body = _bodyController.text;
    const int userId = 1;
    final url = Uri.parse('https://dummyjson.com/posts/add');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': title,
        'body': body,
        'userId': userId,
      }),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Post added successfully!")),
    );
    _titleController.clear();
    _bodyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: _bodyController,
              decoration: const InputDecoration(labelText: "Body"),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _addPost,
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text(
                "Add Post",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
