import 'package:flutter/material.dart';

// CONCEPT 2: Passing Data Between Screens
// This demonstrates how to send data to another screen using constructors

void main() => runApp(const Concept2App());

class Concept2App extends StatelessWidget {
  const Concept2App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  // Sample product data
  final List<Map<String, dynamic>> products = const [
    {'name': 'Fresh Matooke', 'price': 15000, 'description': 'Fresh green bananas from the farm'},
    {'name': 'Ugali Flour', 'price': 5000, 'description': 'Fine maize flour for perfect ugali'},
    {'name': 'Rice', 'price': 8000, 'description': 'Long-grain aromatic rice'},
    {'name': 'Beans', 'price': 6000, 'description': 'Protein-rich kidney beans'},
    {'name': 'Cooking Oil', 'price': 12000, 'description': 'Pure vegetable cooking oil'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Concept 2: Products'),
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.purple,
                child: Text('${index + 1}'),
              ),
              title: Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('UGX ${product['price']}'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // PASSING DATA: Send product data to detail screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      productName: product['name'],
                      price: product['price'],
                      description: product['description'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  // RECEIVING DATA: These parameters receive the passed data
  final String productName;
  final int price;
  final String description;

  const ProductDetailScreen({
    super.key,
    required this.productName,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
        backgroundColor: Colors.orange,
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
                  color: Colors.orange.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.shopping_bag, size: 80, color: Colors.orange),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Product Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _buildDetailRow('Name:', productName),
                  _buildDetailRow('Price:', 'UGX $price'),
                  _buildDetailRow('Description:', description),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text('Go Back'),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}