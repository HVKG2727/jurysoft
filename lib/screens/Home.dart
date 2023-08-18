import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../model/DataModel.dart';
import 'Detail.dart';
import 'cart.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key});

  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  int _currentIndex = 0;
  Cart cart = Cart();

  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
  }

  void filterProducts(String query) {
    setState(() {
      filteredProducts = products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    int cartItemCount = 0;
    return Scaffold(
      backgroundColor: const Color(0XFFffffff),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(top: 50, left: 15),
                    child: const Text(
                      "Hi Jurysoft !!",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                Container(
                    alignment: Alignment.topLeft,
                    margin:
                        const EdgeInsets.only(top: 18, left: 15, bottom: 25),
                    child: const Text("Welcome to Fyze Shopping",
                        style: TextStyle(
                          fontSize: 23,
                        ))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterProducts,
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: filteredProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(products: filteredProducts[index])));
                    },
                    child: Card(
                      color: const Color(0xFFffffff),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 4,
                      child: Column(
                        children: [
                          Image.asset(filteredProducts[index].imageUrl),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              filteredProducts[index].name,
                              style: const TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            "\u{20B9}${filteredProducts[index].price.toString()}",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (int index) =>
                    StaggeredTile.count(1, index.isEven ? 1.2 : 1.2),
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 0.0,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CartView(
                        cart: cart,
                        products: filteredProducts[0],
                      )));
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
