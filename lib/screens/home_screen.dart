import 'package:final_exam/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Pages for the BottomNavigationBar
  static const List<Widget> _widgetOptions = <Widget>[
    PlaceholderWidget('Home'),
    PlaceholderWidget('Search'),
    PlaceholderWidget('Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // --- Actions ---

  // Shows a SnackBar
  void _showSnackBar() {
    final snackBar = SnackBar(
      content: const Text('FAB Clicked! This is a SnackBar.'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Shows an AlertDialog
  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert!'),
          content: const Text('This is a modal alert dialog.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // We use Theme.of(context) to access the colors from our theme file
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      // 1. App Bar
      appBar: AppBar(
        title: const Text('Flutter Scaffold'),
      ),
      // 2. Side Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: colorScheme.primary,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home Page'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.warning),
              title: const Text('Show Alert Dialog'),
              onTap: () {
                Navigator.pop(context); // Close the drawer first
                _showAlertDialog(); // Then show the dialog
              },
            ),
          ],
        ),
      ),
      // 3. Body (changes based on the selected tab)
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // 4. Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: _showSnackBar, // Triggers the SnackBar
        tooltip: 'Show SnackBar',
        child: const Icon(Icons.add),
      ),
      // 5. Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: colorScheme.primary, // Color from theme
        onTap: _onItemTapped,
      ),
    );
  }
}