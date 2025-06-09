// lib/models/photo_item.dart
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PhotoItem {
  final String id;
  final String imageUrl;
  final bool isVideo;
  final String duration;
  final StaggeredGridTile pattern;

  PhotoItem({
    required this.id,
    required this.imageUrl,
    this.isVideo = false,
    this.duration = '0:00',
    required this.pattern,
  });
}