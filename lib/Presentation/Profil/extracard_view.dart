import 'package:flutter/material.dart';

import '../Auth/screens/default_button.dart';

class OrderSuccessPage extends StatefulWidget {
  final String orderId = '888333777'; // Example Order ID

  const OrderSuccessPage({Key? key}) : super(key: key);

  @override
  State<OrderSuccessPage> createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage>
    with SingleTickerProviderStateMixin {
  // Animation controller
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Fade animation
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Slide animation for button
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the animations
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // Prevents back navigation
        onWillPop: () async => false,
    child: Scaffold(
    appBar: AppBar(
    title: const Text("Order Confirmation"),
    centerTitle: true,
    automaticallyImplyLeading: false, // Hides the back button
    ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Fade-in animation for the image
            FadeTransition(
              opacity: _fadeAnimation,
              child: Center(
                child: Image.network(
                  'https://cdn.pixabay.com/photo/2022/10/01/11/41/delivery-7491357_960_720.png', // Replace with your image
                  height: 300,
                  width: 300,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // AnimatedOpacity for the success message
            AnimatedOpacity(
              opacity: _controller.value,
              duration: const Duration(seconds: 2),
              child: const Center(
                child: Text(
                  'Your order is placed successfully!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Fade in the Order ID text
            FadeTransition(
              opacity: _fadeAnimation,
              child: Center(
                child: Text(
                  'Order ID: ${widget.orderId}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Slide in the button from below
            SlideTransition(
              position: _slideAnimation,
              child: DefaultButton(
                function: () {
                  Navigator.pushNamed(context, '/placedOrder');
                },
                btnContent:
                  'Go to My Orders',
                bgColor: Colors.deepOrange,
                contentColor: Colors.white,
                btnIcon: Icons.shopping_cart_checkout,
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}
