import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskmanager/models/product_data.dart';
import 'package:taskmanager/models/cart_model.dart';
import 'package:taskmanager/feature/page/cart_page.dart';
import 'package:taskmanager/models/user_street_widget.dart';
import 'package:taskmanager/models/product_grid_item.dart';
import 'package:taskmanager/feature/profile_screen/profile.dart';

class HomePage extends StatefulWidget {
  static const String route = '/home';

  const HomePage({super.key});
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _products = ProductData.getProducts();
  final _cartModel = CartModel();
  String _selectedCategory = 'Все';

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _selectedCategory == 'Все'
        ? _products
        : _products.where((p) => p.category == _selectedCategory).toList();
    final categories = ['Все', ..._products.map((p) => p.category).toSet()];

    int crossAxisCount = MediaQuery.of(context).size.width > 600 ? 5 : 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Продукты'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push(ProfilePage.route),
          ),
          
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart), 
                onPressed: () => context.push(CartPage.route),
              ),
              if (_cartModel.items.isNotEmpty)
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                    child: Text(
                      _cartModel.items.length.toString(),
                      style: const TextStyle(
                        color: Colors.white, 
                        fontSize: 12
                      ),
                    ),
                  ),
                )
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          const UserStreetWidget(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: categories.map((category) => 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: _selectedCategory == category,
                      onSelected: (_) => setState(() => _selectedCategory = category),
                    ),
                  )
                ).toList(),
              ),
            ),
          ),
          
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return ProductGridItem(
                  product: product, 
                  cartModel: _cartModel,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}