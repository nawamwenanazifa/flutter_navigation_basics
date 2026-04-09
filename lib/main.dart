import 'package:flutter/material.dart';

// Import all first six concept files from the screens folder
import 'screens/concept1_basic_navigation.dart';
import 'screens/concept2_passing_data.dart';
import 'screens/concept3_named_route.dart';
import 'screens/concept4_named-routes_with_arguments.dart';
import 'screens/concept5_bottom_navigation.dart';
import 'screens/concept6_drawer_navigation.dart';

void main() {
  runApp(const NavigationConceptSelector());
}

class NavigationConceptSelector extends StatelessWidget {
  const NavigationConceptSelector({super.key});

  final List<Map<String, dynamic>> concepts = const [
    {
      'id': 1,
      'title': 'Concept 1: Basic Navigation',
      'description': 'Learn push() and pop() - Stack-based navigation',
      'icon': Icons.layers,
      'color': Colors.blue,
      'file': 'screens/concept1_basic_navigation.dart',
      'route': 'Concept 1',
    },
    {
      'id': 2,
      'title': 'Concept 2: Passing Data',
      'description': 'Send data between screens using constructor parameters',
      'icon': Icons.send,
      'color': Colors.purple,
      'file': 'screens/concept2_passing_data.dart',
      'route': 'Concept 2',
    },
    {
      'id': 3,
      'title': 'Concept 3: Named Routes',
      'description': 'Navigate using string names (like URLs)',
      'icon': Icons.signpost,
      'color': Colors.teal,
      'file': 'screens/concept3_named_routes.dart',
      'route': 'Concept 3',
    },
    {
      'id': 4,
      'title': 'Concept 4: Named Routes with Arguments',
      'description': 'Pass data using named routes',
      'icon': Icons.message,
      'color': Colors.indigo,
      'file': 'screens/concept4_named_routes_with_arguments.dart',
      'route': 'Concept 4',
    },
    {
      'id': 5,
      'title': 'Concept 5: Bottom Navigation Bar',
      'description': 'Switch between main app sections',
      'icon': Icons.navigation, // ✅ FIXED ICON
      'color': Colors.pink,
      'file': 'screens/concept5_bottom_navigation.dart',
      'route': 'Concept 5',
    },
    {
      'id': 6,
      'title': 'Concept 6: Drawer Navigation',
      'description': 'Side menu for navigation options',
      'icon': Icons.menu,
      'color': Colors.orange,
      'file': 'screens/concept6_drawer_navigation.dart',
      'route': 'Concept 6',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: HomeScreen(concepts: concepts),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> concepts;

  const HomeScreen({super.key, required this.concepts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Navigation Guide"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: concepts.length,
        itemBuilder: (context, index) {
          final concept = concepts[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 4,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: (concept['color'] as Color).withOpacity(0.2),
                child: Icon(
                  concept['icon'],
                  color: concept['color'],
                ),
              ),
              title: Text(
                concept['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(concept['description']),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                _navigateToConcept(context, concept['id']);
              },
            ),
          );
        },
      ),
    );
  }

  void _navigateToConcept(BuildContext context, int id) {
    switch (id) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Concept1App()),
        );
        break;

      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Concept2App()),
        );
        break;

      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Concept3App()),
        );
        break;

      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Concept4App()),
        );
        break;

      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Concept5App()),
        );
        break;

      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Concept6App()),
        );
        break;
    }
  }
}