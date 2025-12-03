import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Memories'),
        backgroundColor: Colors.blue,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: 15, // Placeholder count
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: NetworkImage('https://picsum.photos/200'), // Placeholder images
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Upload photo feature coming soon!')),
            );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
