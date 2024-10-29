import 'package:flutter/material.dart';

void main() => runApp(AmazonCloneApp());

class AmazonCloneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResponsiveHomePage(),
    );
  }
}

class ResponsiveHomePage extends StatefulWidget {
  @override
  _ResponsiveHomePageState createState() => _ResponsiveHomePageState();
}

class _ResponsiveHomePageState extends State<ResponsiveHomePage> {
  String selectedCategory = 'All';

  void updateCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Amazon Clone'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Welcome to Amazon Clone',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('All'),
              onTap: () => updateCategory('All'),
            ),
            ListTile(
              leading: Icon(Icons.electrical_services),
              title: Text('Electronics'),
              onTap: () => updateCategory('Electronics'),
            ),
            ListTile(
              leading: Icon(Icons.kitchen),
              title: Text('Home Appliances'),
              onTap: () => updateCategory('Home Appliances'),
            ),
            ListTile(
              leading: Icon(Icons.style),
              title: Text('Fashion'),
              onTap: () => updateCategory('Fashion'),
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return Row(
              children: [
                Expanded(
                  child: SideMenu(updateCategory: updateCategory),
                ),
                Expanded(
                  flex: 3,
                  child: ProductGrid(selectedCategory: selectedCategory),
                ),
              ],
            );
          } else {
            return ProductGrid(selectedCategory: selectedCategory);
          }
        },
      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  final Function(String) updateCategory;

  SideMenu({required this.updateCategory});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.category),
          title: Text('All'),
          onTap: () => updateCategory('All'),
        ),
        ListTile(
          leading: Icon(Icons.electrical_services),
          title: Text('Electronics'),
          onTap: () => updateCategory('Electronics'),
        ),
        ListTile(
          leading: Icon(Icons.kitchen),
          title: Text('Home Appliances'),
          onTap: () => updateCategory('Home Appliances'),
        ),
        ListTile(
          leading: Icon(Icons.style),
          title: Text('Fashion'),
          onTap: () => updateCategory('Fashion'),
        ),
      ],
    );
  }
}

class ProductGrid extends StatelessWidget {
  final String selectedCategory;

  ProductGrid({required this.selectedCategory});

  final List<String> productImages = [
    'image1.jpg',
    'image2.jpg',
    'image3.jpg',
    'image4.jpg',
    'image5.jpg',
    'image6.jpg',
    'image7.jpg',
    'image8.jpg',
    'image9.jpg',
    'image10.jpg',
    'image11.jpg',
  ];

  final List<String> productNames = [
    'iPhone 14 Pro Max',
    'Samsung Galaxy S23',
    'Mac book Air Rosegold',
    'Washing Machine',
    'Dryer',
    'Oven',
    'Women Dress',
    'Men White Shirt',
    'Men night suit',
    'Women night suit',
    'Airpods',
  ];

  final List<double> productPrices = [
    999.99,
    1099.99,
    699.99,
    499.99,
    399.99,
    150.00,
    100.00,
    87.50,
    75.00,
    70.00,
    299.99,
  ];

  List<int> getFilteredIndices() {
    switch (selectedCategory) {
      case 'Electronics':
        return [0, 1, 2, 10]; // Indices for Electronics
      case 'Home Appliances':
        return [3, 4, 5]; // Indices for Home Appliances
      case 'Fashion':
        return [6, 7, 8, 9]; // Indices for Fashion
      default:
        return List.generate(productImages.length, (index) => index); // All
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredIndices = getFilteredIndices();

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 2 / 3,
      ),
      itemCount: filteredIndices.length,
      itemBuilder: (context, index) {
        final filteredIndex = filteredIndices[index];
        return Card(
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(
                  productImages[filteredIndex],
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  productNames[filteredIndex],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '\$${productPrices[filteredIndex]}',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
