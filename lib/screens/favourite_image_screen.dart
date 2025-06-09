import 'package:flutter/material.dart';

class FavouriteImageScreen extends StatelessWidget {
  const FavouriteImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
        final List<String> allPhotos = List.generate(
      4,
      (index) => 'assets/images/mem_${index + 1}.jpg',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Photos'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(4.0),
        
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,   
          mainAxisSpacing: 4.0,
        ),
        
        itemCount: allPhotos.length,
        
        itemBuilder: (context, index) {
          final imagePath = allPhotos[index];
          
          return GridTile(
            child: GestureDetector(
              onTap: () {
                print('Tapped on photo: $imagePath');
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover, // Ensures the image covers the cell
                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) return child;
                    return AnimatedOpacity(
                      opacity: frame == null ? 0 : 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      child: child,
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade800,
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}