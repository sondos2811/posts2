import 'package:datapractice/get_all.dart';
import 'package:datapractice/screen_pages.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: 200,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GetAllPage()));
              },
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text(
                "get all posts",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 200,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddPostPage()),
                );
              },
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text(
                "add post",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ]),
      ),
    ));
  }
}
