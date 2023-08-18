import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

import '../model/DataModel.dart';
import 'Detail.dart';
import 'checkout.dart';

class CartView extends StatefulWidget {
  final Cart cart;
  final Product products;

  CartView({required this.cart, required this.products});

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  double calculateTotalPrice() {
    double totalPrice = 0;
    final Product products;
    for (var cartItem in widget.cart.items) {
      totalPrice +=
          (double.parse(cartItem.product.price.toString()) * cartItem.quantity);
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    double totalCartPrice = calculateTotalPrice();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.cart.items.length,
        itemBuilder: (context, index) {
          CartItem cartItem = widget.cart.items[index];
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 10,
            child: ListTile(
              leading: Image.asset(cartItem.product.imageUrl), // Product image
              title: Text(cartItem.product.name),
              subtitle: Text("\u{20B9}${cartItem.product.price.toString()}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (cartItem.quantity > 1) {
                          cartItem.quantity--;
                        }
                      });
                    },
                  ),
                  Text(cartItem.quantity.toString()),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        cartItem.quantity++;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () async {
            List<Map<String, dynamic>> transactions = [
              {
                "amount": {
                  "total": totalCartPrice.toStringAsFixed(2),
                  // Convert to string
                  "currency": "USD",
                  "details": {
                    "subtotal": totalCartPrice.toStringAsFixed(2),
                    // Convert to string
                    "shipping": '0',
                    "shipping_discount": 0
                  }
                },
                "description": "The payment transaction description.",
                "item_list": {
                  "items": widget.cart.items.map((cartItem) {
                    return {
                      "name": cartItem.product.name,
                      "quantity": cartItem.quantity.toString(),
                      "price": cartItem.product.price.toStringAsFixed(2),
                      // Convert to string
                      "currency": "USD"
                    };
                  }).toList(),
                }
              }
            ];
            print(totalCartPrice);
            print("totalCartPrice");
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PaypalCheckout(
                sandboxMode: true,
                clientId:
                    "AbnFYRSuR641lBDmY_o_Wj1pib-iDTyRzVD7s7xpV5Nl_susnizIkSH6VDvrdlrOPc0D5Wk_jnacDuXX",
                secretKey:
                    "EMsJIpjOjNRaQdQe4W0uB04YEYDNm0x5wo4UvLBhhsx-rgS7M-C_akroafmon0qZ7BgzBMUOfGLqXPp_",
                returnURL: "success.snippetcoder.com",
                cancelURL: "cancel.snippetcoder.com",
                transactions: transactions,
                note: "Contact us for any questions on your order.",
                onSuccess: (Map params) async {
                  print("onSuccess: $params");
                  Navigator.pop(context);
                },
                onError: (error) {
                  print("onError: $error");
                  Navigator.pop(context);
                },
                onCancel: () {
                  print('cancelled:');
                },
              ),
            ));
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.deepOrangeAccent,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'Total: \u{20B9}${totalCartPrice.toStringAsFixed(2)}',
            // Display total price
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

////////////////////paypal///////////////////
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../model/DataModel.dart';
// import 'Detail.dart';
// import 'StripeService.dart'; // Import your StripeService

// class CartView extends StatefulWidget {
//   final Cart cart;
//   final Product products;
//
//   CartView({required this.cart, required this.products});
//
//   @override
//   _CartViewState createState() => _CartViewState();
// }
//
// class _CartViewState extends State<CartView> {
//   double calculateTotalPrice() {
//     double totalPrice = 0;
//     for (var cartItem in widget.cart.items) {
//       totalPrice += (double.parse(cartItem.product.price.toString()) * cartItem.quantity);
//     }
//     return totalPrice;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double totalCartPrice = calculateTotalPrice();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         itemCount: widget.cart.items.length,
//     itemBuilder: (context, index) {
//           CartItem cartItem = widget.cart.items[index];
//           return Card(
//             margin: EdgeInsets.all(10),
//             elevation: 10,
//             child: ListTile(
//               leading: Image.asset(cartItem.product.imageUrl), // Product image
//               title: Text(cartItem.product.name),
//               subtitle: Text("\u{20B9}${cartItem.product.price.toString()}"),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.remove),
//                     onPressed: () {
//                       setState(() {
//                         if (cartItem.quantity > 1) {
//                           cartItem.quantity--;
//                         }
//                       });
//                     },
//                   ),
//                   Text(cartItem.quantity.toString()),
//                   IconButton(
//                     icon: Icon(Icons.add),
//                     onPressed: () {
//                       setState(() {
//                         cartItem.quantity++;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.all(16),
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => CheckoutPage(totalAmount: totalCartPrice),
//               ),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             primary: Colors.deepOrangeAccent,
//             padding: EdgeInsets.symmetric(vertical: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           child: Text(
//             'Total: \u{20B9}${totalCartPrice.toStringAsFixed(2)}',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class CheckoutPage extends StatefulWidget {
//   final double totalAmount;
//
//   CheckoutPage({required this.totalAmount});
//
//   @override
//   _CheckoutPageState createState() => _CheckoutPageState();
// }
//
// class _CheckoutPageState extends State<CheckoutPage> {
//   final String paypalPaymentUrl = 'YOUR_PAYPAL_PAYMENT_URL'; // Replace with your server's PayPal payment URL
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Checkout'),
//       ),
//       body: WebView(
//         initialUrl: paypalPaymentUrl,
//         javascriptMode: JavascriptMode.unrestricted,
//         navigationDelegate: (NavigationRequest request) {
//           // Handle redirects or navigation events here
//           return NavigationDecision.navigate;
//         },
//       ),
//     );
//   }
// }
