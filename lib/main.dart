
import 'package:flutter/material.dart';

void main() {
  runApp(const LanjuApp());
}

class LanjuApp extends StatelessWidget {
  const LanjuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lanju',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF087E68),
        ),
        useMaterial3: true,
      ),
      home: const LanjuHome(),
    );
  }
}

class LanjuHome extends StatefulWidget {
  const LanjuHome({super.key});

  @override
  State<LanjuHome> createState() => _LanjuHomeState();
}

class _LanjuHomeState extends State<LanjuHome> {
  int selectedTab = 0;
  String selectedCategory = 'All';
  String searchText = '';

  final TextEditingController searchController =
      TextEditingController();

  final List<Map<String, dynamic>> products = [
    {
      'name': 'iPhone 13',
      'price': 'Rs. 125,000',
      'location': 'Karachi',
      'category': 'Mobiles',
      'icon': Icons.phone_iphone,
    },
    {
      'name': 'Honda 125',
      'price': 'Rs. 285,000',
      'location': 'Lahore',
      'category': 'Vehicles',
      'icon': Icons.motorcycle,
    },
    {
      'name': 'Modern Sofa',
      'price': 'Rs. 45,000',
      'location': 'Islamabad',
      'category': 'Furniture',
      'icon': Icons.chair,
    },
    {
      'name': 'Gaming Laptop',
      'price': 'Rs. 95,000',
      'location': 'Skardu',
      'category': 'Electronics',
      'icon': Icons.laptop,
    },
    {
      'name': 'Mountain Bicycle',
      'price': 'Rs. 28,000',
      'location': 'Gilgit',
      'category': 'Vehicles',
      'icon': Icons.pedal_bike,
    },
    {
      'name': 'LED Television',
      'price': 'Rs. 55,000',
      'location': 'Peshawar',
      'category': 'Electronics',
      'icon': Icons.tv,
    },
  ];

  final List<String> categories = [
    'All',
    'Mobiles',
    'Vehicles',
    'Electronics',
    'Furniture',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF087E68),
        foregroundColor: Colors.white,
        title: const Text(
          'Lanju',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Icon(Icons.location_on_outlined),
          SizedBox(width: 6),
          Center(child: Text('Pakistan')),
          SizedBox(width: 15),
        ],
      ),
      body: selectedTab == 0
          ? homePage()
          : selectedTab == 1
              ? sellPage()
              : selectedTab == 2
                  ? const Center(
                      child: Text('Your messages will appear here'),
                    )
                  : const Center(
                      child: Text('Welcome to your Lanju account'),
                    ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedTab,
        onDestinationSelected: (index) {
          setState(() => selectedTab = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            label: 'Sell',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chats',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  Widget homePage() {
    final filteredProducts = products.where((product) {
      final matchesSearch = product['name']
          .toString()
          .toLowerCase()
          .contains(searchText.toLowerCase());

      final matchesCategory = selectedCategory == 'All' ||
          product['category'] == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Find anything you need!',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: searchController,
          onChanged: (value) {
            setState(() => searchText = value);
          },
          decoration: InputDecoration(
            hintText: 'Search products...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Browse Categories',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 45,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: categories.map((category) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(category),
                  selected: selectedCategory == category,
                  selectedColor: const Color(0xFFB8E5D9),
                  onSelected: (_) {
                    setState(() => selectedCategory = category);
                  },
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Fresh Recommendations',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        if (filteredProducts.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Text('No products found'),
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredProducts.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.78,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final product = filteredProducts[index];

              return Card(
                color: Colors.white,
                clipBehavior: Clip.antiAlias,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(product['name']),
                        content: Text(
                          '${product['price']}\nLocation: ${product['location']}',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          color: const Color(0xFFE4F1ED),
                          child: Icon(
                            product['icon'],
                            size: 65,
                            color: const Color(0xFF087E68),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['price'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF087E68),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              product['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              product['location'],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  Widget sellPage() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sell on Lanju',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Product name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Price in Rs.',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                if (nameController.text.trim().isEmpty ||
                    priceController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enter product name and price'),
                    ),
                  );
                  return;
                }

                setState(() {
                  products.insert(0, {
                    'name': nameController.text.trim(),
                    'price': 'Rs. ${priceController.text.trim()}',
                    'location': 'Pakistan',
                    'category': 'All',
                    'icon': Icons.shopping_bag,
                  });
                  selectedTab = 0;
                  selectedCategory = 'All';
                  searchText = '';
                  searchController.clear();
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Product added to this demo!'),
                  ),
                );
              },
              child: const Text('Publish Product'),
            ),
          ),
        ],
      ),
    );
  }
}
