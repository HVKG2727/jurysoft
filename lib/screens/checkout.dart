// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:stripe_checkout/stripe_checkout.dart';
//
//
// class StripeService {
//  static String secretKey = "sk_test_51NgE8oSAYygqQIfipcJXyAXDYRYgUXQumxF3ArXmrDNi8ihifp1In7iVWqmNZUpSMG6WRwFk1N4WXZgtydN2YbS700L7NMBxz2";
//  static String publishKey = "pk_test_51NgE8oSAYygqQIfiL9IAgKNQ33zF9XmauoA3CF1fNJBfxaic8rEYpfbl6stSiXMRYCbncDDltliF5NB2QUJeQB6R00hRb9P8Ew";
//
//   static Future<dynamic> createCheckoutSession(
//       List<dynamic> productItems,
//       totalAmount,
//       ) async {
//     final url = "https://api.stripe.com/v1/checkout/sessions";
//     String lineItems = "";
//     int index = 0;
//
//     productItems.forEach((val) {
//       var productPrice = (val["productPrice"] * 100).round().toString();
//       lineItems += "line_items[$index][price_data][product_data][name]=${val['productName']}&";
//       lineItems += "line_items[$index][price_data][unit_amount]=$productPrice&";
//       lineItems += "line_items[$index][price_data][product_data][currency]=INR&";
//       lineItems += "line_items[$index][quantity]=${val['quantity'].toString()}&";
//       index++;
//     });
//
//
//     final body = {
//       'success_url': 'https://yourwebsite.com/success',
//       'cancel_url': 'https://yourwebsite.com/cancel',
//       'payment_method_types[]': 'card',
//       'mode': 'payment',
//       'line_items': lineItems,
//     };
//     final response = await http.post(
//       Uri.parse(url),
//       headers: {
//         'Authorization': 'Bearer $secretKey',
//         'Content-Type': 'application/x-www-form-urlencoded',
//       },
//      // body: 'success_url = htteps://checkout.stripe.dev/success&mode=payment$lineItems',
//       //body: 'success_url=https://checkout.stripe.dev/success&mode=payment&$lineItems',
//       body: body,
//     );
//     final resId = json.decode(response.body);
//     final sessionId = resId['id'];
//     print("Session ID: $sessionId");
//     return sessionId;
//
//
//
//
//
//
//
//
//
//
//
//
//     // if (response.statusCode == 200) {
//     //   final responseData = json.decode(response.body);
//     //   final sessionId = responseData['id'];
//     //   return sessionId; // Return the session ID for further processing
//     // } else {
//     //   throw Exception('Failed to create checkout session');
//     // }
//   }
//   static Future<dynamic> stripePamentCheckout (
//       productItems,
//       subTotal,
//       context,
//       mounted, {
//         onSuccess,
//         onCancel,
//         onError,
//  }) async {
//     final  sessionId = await createCheckoutSession(productItems, subTotal);
//     print("helooooooooo$sessionId");
//     final result = await redirectToCheckout(
//       context: context,
//       sessionId: sessionId ?? "",
//       publishableKey:publishKey,
//       successUrl: "https://checkout.stripe.dev/success",
//       canceledUrl: "https://checkout.stripe.dev/cancel",
//     );
//
//     if(mounted) {
//       final text = result.when(
//           redirected: () => 'Redirected Successfully',
//           success: () => onSuccess(),
//           canceled: () => onCancel(),
//           error: (e) => onError(e)
//       );
//       return text;
//     }
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

////////////?///////////PayPal Checkout/////////////////////////
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PayPal Checkout",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {

          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(1),
              ),
            ),
          ),
          child: const Text('Checkout'),
        ),
      ),
    );
  }
}

//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

























// // //
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import 'Detail.dart'; // Import the HTTP package
//
// class StripeService {
//   static String secretKey = "sk_test_51NgE8oSAYygqQIfipcJXyAXDYRYgUXQumxF3ArXmrDNi8ihifp1In7iVWqmNZUpSMG6WRwFk1N4WXZgtydN2YbS700L7NMBxz2";
//   String publishKey = "pk_test_51NgE8oSAYygqQIfiL9IAgKNQ33zF9XmauoA3CF1fNJBfxaic8rEYpfbl6stSiXMRYCbncDDltliF5NB2QUJeQB6R00hRb9P8Ew";
//
//   static Future<dynamic> createCheckoutSession(
//       List<CartItem> items,
//       final double totalCartPrice,
//       ) async {
//     final url = Uri.parse("https://api.stripe.com/v1/checkout/sessions");
//
//     String lineItems = "";
//     int index = 0;
//
//     items.forEach((cartItem) {
//       var productPrice = (cartItem.product.price * 100).round();
//       lineItems += "line_items[${index}][price_data][unit_amount]=$productPrice&";
//       lineItems += "line_items[${index}][price_data][currency]=usd&";
//       lineItems += "line_items[${index}][quantity]=${cartItem.quantity}&";
//       lineItems += "line_items[${index}][description]=${Uri.encodeComponent(cartItem.product.name)}&";
//       index++;
//     });
//
//     final headers = {
//       'Authorization': 'Bearer ${secretKey}',
//       'Content-Type': 'application/x-www-form-urlencoded',
//     };
//
//     final body = {
//       'success_url': 'https://yourwebsite.com/success',
//       'cancel_url': 'https://yourwebsite.com/cancel',
//       'payment_method_types[]': 'card',
//       'mode': 'payment',
//       'line_items': lineItems,
//     };
//
//     final response = await http.post(
//       url,
//       headers: headers,
//       body: body,
//     );
//
//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       final sessionId = responseData['id'];
//       return sessionId; // Return the session ID for further processing
//     } else {
//       throw Exception('Failed to create checkout session');
//     }
//   }
// }



///////////////////Paypal/////////////////////////
// //
//
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
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

