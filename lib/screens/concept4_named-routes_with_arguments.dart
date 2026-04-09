import 'package:flutter/material.dart';

// CONCEPT 4: Passing Arguments with Named Routes
// This demonstrates how to send data using named routes

void main() {
  runApp(const Concept4App());
}

class RouteNames {
  static const String home = '/';
  static const String detail = '/detail';
}

class Concept4App extends StatelessWidget {
  const Concept4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Concept 4: Arguments',
      initialRoute: RouteNames.home,
      routes: {
        RouteNames.home: (context) => const HomeScreen(),
        RouteNames.detail: (context) => const DetailScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> items = const [
    {'name': 'Ugali', 'price': 5000, 'type': 'Food'},
    {'name': 'Sukuma Wiki', 'price': 2000, 'type': 'Vegetable'},
    {'name': 'Nyama Choma', 'price': 15000, 'type': 'Meat'},
    {'name': 'Mandazi', 'price': 500, 'type': 'Snack'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Concept 4: Pass Arguments'),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigo,
                child: Text('${index + 1}'),
              ),
              title: Text(item['name']),
              subtitle: Text('UGX ${item['price']} • ${item['type']}'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // SENDING DATA: Pass arguments with named route
                Navigator.pushNamed(
                  context,
                  RouteNames.detail,
                  arguments: {
                    'name': item['name'],
                    'price': item['price'],
                    'type': item['type'],
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // RECEIVING DATA: Get arguments passed to this screen
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(args['name']),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  args['type'] == 'Food' ? Icons.fastfood :
                  args['type'] == 'Vegetable' ? Icons.eco :
                  args['type'] == 'Meat' ? Icons.restaurant :
                  Icons.cake,
                  size: 80,
                  color: Colors.indigo,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Item Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildDetailRow('Name:', args['name']),
                    _buildDetailRow('Price:', 'UGX ${args['price']}'),
                    _buildDetailRow('Type:', args['type']),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Text(value),
        ],
      ),
    );
  }
}