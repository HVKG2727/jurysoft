import 'package:flutter/material.dart';
import 'package:jurysoft/model/DataModel.dart';
import 'package:provider/provider.dart';

import '../provider/ProviderPage.dart';
import 'cart.dart';

class Cart {
  List<CartItem> items = [];

  void addToCart(Product product) {
    bool productExists = items.any((item) => item.product == product);

    if (productExists) {
      for (var item in items) {
        if (item.product == product) {
          item.quantity++;
          break;
        }
      }
    } else {
      items.add(CartItem(product: product, quantity: 1));
    }
  }
}

class DetailPage extends StatefulWidget {
  final Product products;

  const DetailPage({Key? key, required this.products}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isChecked = false;
  int _currentIndex = 0;
  Cart cart = Cart();

  @override
  Widget build(BuildContext context) {
    int cartItemCount = cart.items.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.2,
              child: Image.asset(
                widget.products.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.products.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\u{20B9}${widget.products.price.toString()}",
                    style: const TextStyle(fontSize: 18, color: Colors.green),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.products.description,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          cart.addToCart(widget.products);
                          setState(() {
                            cartItemCount = cart.items.length;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Item added to cart')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Add to Cart",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          cart.addToCart(widget.products);
                          final cartProvider =
                              Provider.of<CartProvider>(context, listen: false);
                          await cartProvider
                              .updateCartItemCount(cart.items.length);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Item added to cart')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrangeAccent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 65, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Buy Now",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      CartView(cart: cart, products: widget.products)));
            },
            child: const Icon(Icons.shopping_cart),
          ),
          if (cartItemCount > 0)
            Positioned(
              top: 5,
              right: 5,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  cartItemCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),

            const SizedBox(), // Spacer
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
