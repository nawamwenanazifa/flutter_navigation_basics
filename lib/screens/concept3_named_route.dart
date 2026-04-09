import 'package:flutter/material.dart';

// CONCEPT 3: Named Routes
// This demonstrates using string names for routes (like URLs)

void main() {
  runApp(const Concept3App());
}

// Best Practice: Use constants for route names
class RouteNames {
  static const String home = '/';
  static const String products = '/products';
  static const String details = '/details';
  static const String settings = '/settings';
  static const String about = '/about';
}

class Concept3App extends StatelessWidget {
  const Concept3App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Concept 3: Named Routes',
      // Define all routes in one place
      initialRoute: RouteNames.home,
      routes: {
        RouteNames.home: (context) => const HomeScreen(),
        RouteNames.products: (context) => const ProductsScreen(),
        RouteNames.details: (context) => const DetailsScreen(),
        RouteNames.settings: (context) => const SettingsScreen(),
        RouteNames.about: (context) => const AboutScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Concept 3: Named Routes - Home'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Navigation using named routes',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            _buildNavButton(
              context,
              'Go to Products',
              RouteNames.products,
              Colors.teal,
            ),
            const SizedBox(height: 10),
            _buildNavButton(
              context,
              'Go to Settings',
              RouteNames.settings,
              Colors.orange,
            ),
            const SizedBox(height: 10),
            _buildNavButton(
              context,
              'Go to About',
              RouteNames.about,
              Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String text, String route, Color color) {
    return ElevatedButton(
      onPressed: () {
        // Using pushNamed with route name
        Navigator.pushNamed(context, route);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(200, 50),
      ),
      child: Text(text),
    );
  }
}

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_bag, size: 80, color: Colors.teal),
            const SizedBox(height: 20),
            const Text(
              'Products Screen',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Go back
                    Navigator.pop(context);
                  },
                  child: const Text('POP (Go Back)'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Replace current screen (can't go back to this screen)
                    Navigator.pushReplacementNamed(context, RouteNames.home);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Replace with Home'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        backgroundColor: Colors.teal,
      ),
      body: const Center(
        child: Text('Details Screen'),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.settings, size: 80, color: Colors.orange),
            const SizedBox(height: 20),
            const Text('Settings Screen'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.purple,
      ),
      body: const Center(
        child: Text('About Screen'),
      ),
    );
  }
}