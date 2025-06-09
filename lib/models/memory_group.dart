class MemoryGroup {
  final String title;
  final List<String> imagePaths; // A list of local asset paths

  MemoryGroup({
    required this.title,
    required this.imagePaths,
  });

  // A helper getter to easily access the cover image for the group card.
  String get coverImagePath {
    if (imagePaths.isNotEmpty) {
      return imagePaths.first;
    }
    // Return a placeholder path if the group is empty.
    return 'assets/images/placeholder.jpg'; // Make sure you have a placeholder!
  }
}