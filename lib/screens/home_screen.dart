import 'package:flutter/material.dart';
import 'package:final_exam/models/memory_group.dart';
import 'package:final_exam/widgets/memory_card.dart';

import 'favourite_image_screen.dart';

class MemoryGroupsScreen extends StatelessWidget {
  const MemoryGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Make sure the image paths match the files in your assets/images folder.
    final List<MemoryGroup> memoryGroups = [
      MemoryGroup(
        title: 'Family Gathering',
        imagePaths: [
          'assets/images/family/family_1.jpg',
          'assets/images/family/family_2.jpg',
          'assets/images/family/family_3.jpg',
        ],
      ),
      MemoryGroup(
        title: 'Travel Diaries',
        imagePaths: [
          'assets/images/travel/travel_1.jpg',
          'assets/images/travel/travel_2.jpg',
        ],
      ),
      MemoryGroup(
        title: 'Fun with Friends',
        imagePaths: [
          'assets/images/friends/friends_1.jpg',
          'assets/images/friends/friends_2.jpg',
          'assets/images/friends/friends_3.jpg',
        ],
      ),
      MemoryGroup(
        title: 'Party and Fun',
        imagePaths: [
          'assets/images/party/party_1.jpg',
          'assets/images/party/party_2.jpg',
        ],
      ),
      MemoryGroup(
        title: 'University Chaos',
        imagePaths: [
          'assets/images/university/university_1.jpg',
          'assets/images/university/university_2.jpg',
        ],
      ),
    ];
    // --- END MOCK DATA ---

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Memories'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 0.7,
        ),
        itemCount: memoryGroups.length,
        itemBuilder: (context, index) {
          final group = memoryGroups[index];
          return MemoryGroupCard(memoryGroup: group);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FavouriteImageScreen()),
          );
        },
        tooltip: 'Show SnackBar',
        child: const Icon(Icons.favorite),
      ),
    );
  }
}