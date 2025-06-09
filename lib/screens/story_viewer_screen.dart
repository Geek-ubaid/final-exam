import 'package:flutter/material.dart';
import 'package:final_exam/models/memory_group.dart';

class StoryViewerScreen extends StatefulWidget {
  final MemoryGroup memoryGroup;

  const StoryViewerScreen({super.key, required this.memoryGroup});

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5), // Each story lasts 5 seconds
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextStory(); // Go to the next story when the timer completes
      }
    });

    _startStoryTimer();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startStoryTimer() {
    _animationController.stop();
    _animationController.reset();
    _animationController.forward();
  }

  void _nextStory() {
    if (_currentIndex < widget.memoryGroup.imagePaths.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _startStoryTimer();
    } else {
      Navigator.of(context).pop();
    }
  }

  void _previousStory() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _startStoryTimer();
    }
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.stop();
  }

  void _onTapUp(TapUpDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (details.globalPosition.dx > screenWidth / 3) {
      _nextStory();
    } else { 
      _previousStory();
    }
  }
  
  void _onLongPress() {
    _animationController.stop();
  }
  
  void _onLongPressEnd(LongPressEndDetails details) {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final currentImagePath = widget.memoryGroup.imagePaths[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onLongPress: _onLongPress,
        onLongPressEnd: _onLongPressEnd,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // zoom in animation for images in story view
            ClipRect(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                final scale = 1.0 + (_animationController.value * 0.2);
                
                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              child: Image.asset(
                currentImagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
            _buildUIOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildUIOverlay() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildProgressBars()),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Spacer(),
            _buildBottomContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBars() {
    return Row(
      children: List.generate(widget.memoryGroup.imagePaths.length, (index) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: (index == _currentIndex)
                      ? _animationController.value // Animate current bar
                      : (index < _currentIndex)
                          ? 1.0 // Filled for past stories
                          : 0.0, // Empty for future stories
                  backgroundColor: Colors.white.withOpacity(0.5),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 2.5,
                );
              },
            ),
          ),
        );
      }),
    );
  }


  Widget _buildBottomContent() {
    return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.2),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.memoryGroup.title,
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Oct 29, 2024', // You can make this dynamic
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.white, size: 28),
              onPressed: () {
                _showLikeSnackBar(context);
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    ),
  );
}


void _showLikeSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  final snackBar = SnackBar(
    content: Text(
      'Added to favorites!',
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
    ),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    backgroundColor: Colors.white.withOpacity(0.95),
    action: SnackBarAction(
      label: 'Undo',
      textColor: Colors.blueAccent,
      onPressed: () {
        print('Undo like!');
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
}