// lib/widgets/memory_group_card.dart

import 'package:flutter/material.dart';
import 'package:final_exam/models/memory_group.dart';
import 'package:final_exam/screens/story_viewer_screen.dart'; // <-- CHANGE THIS IMPORT

class MemoryGroupCard extends StatelessWidget {
  final MemoryGroup memoryGroup;

  const MemoryGroupCard({
    super.key,
    required this.memoryGroup,
  });

  @override
  Widget build(BuildContext context) {
    // ... (The build method's UI is unchanged)
    return GestureDetector(
      // --- UPDATED NAVIGATION LOGIC ---
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            // This makes the screen slide up from the bottom, which is
            // a common pattern for modal views like stories.
            fullscreenDialog: true,
            builder: (context) => StoryViewerScreen(memoryGroup: memoryGroup),
          ),
        );
      },
      child: ClipRRect( /* ... rest of the UI is the same */
        borderRadius: BorderRadius.circular(16.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(memoryGroup.coverImagePath, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
            Positioned(
              bottom: 12, left: 12, right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(memoryGroup.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('${memoryGroup.imagePaths.length} photos', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withOpacity(0.9))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}