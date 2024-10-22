// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:datapractice/screen_pages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetAllPage extends StatefulWidget {
  const GetAllPage({super.key});
  @override
  State<GetAllPage> createState() => _GetAllPageState();
}

class _GetAllPageState extends State<GetAllPage> {
  List<dynamic> posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    var url = Uri.https('dummyjson.com', 'posts');
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    setState(() {
      posts = data['posts'];
    });
  }

  Future<void> deletePost(int id) async {
    final url = Uri.parse('https://dummyjson.com/posts/$id');

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      setState(() {
        posts.removeWhere((post) => post['id'] == id);
      });
    } else {
      print('failed to delete post ${response.statusCode}');
    }
  }

  Future<void> getPost(int id) async {
    final data = posts.firstWhere((post) => post['id'] == id);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return GetPost(
        title: data['title'],
        body: data['body'],
        tags: data['tags'],
        like_reactions: data['reactions']['likes'],
        dislike_reactions: data['reactions']['dislikes'],
        views: data['views'],
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts List"),
      ),
      body: posts.isEmpty
          ? _loader()
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post['title']),
                  trailing: SizedBox(
                    width: 120, 
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment:
                          MainAxisAlignment.end, 
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            deletePost(post['id']);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPost(
                                  id: post['id'],
                                  initialTitle: post['title'],
                                  initialBody: post['body'],
                                ),
                              ),
                            );

                            if (result != null) {
                              setState(() {
                                post['title'] = result['title'];
                                post['body'] = result['body'];
                              });
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.view_compact_alt),
                          onPressed: () {
                            getPost(post['id']);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _loader() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
