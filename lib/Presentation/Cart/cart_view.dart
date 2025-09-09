import 'package:flash_food/Core/app_colors.dart';
import 'package:flash_food/Core/font_size.dart';
import 'package:flash_food/Core/response_conf.dart';
import 'package:flash_food/Core/text_styles.dart';
import 'package:flash_food/Presentation/Auth/screens/default_button.dart';
import 'package:flash_food/Presentation/Base/base.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<Map<String, dynamic>> cartList = [
    {
      'name': 'Classic Beef Burger',
      'price': 9.99,
      'quantity': 3,
    },
    {
      'name': 'Chicken Taco',
      'price': 8.99,
      'quantity': 2,
    },
    {
      'name': 'Lemonade',
      'price': 2.99,
      'quantity': 4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(buildContext: context, screenTitle: "My Cart", isBackup: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(24)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: getSize(800),
                height: getHeight(400),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: cartList.length,
                  itemBuilder: (context, index) {
                    var item = cartList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(item['name'], style: TextStyles.bodyLargeSemiBold),
                        subtitle: Text("\$${item['price'].toStringAsFixed(2)}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (item['quantity'] > 1) {
                                    cartList[index]['quantity']--;
                                  } else {
                                    // Remove the item if quantity is 1
                                    cartList.removeAt(index);
                                  }
                                });
                                updateCartList();
                              },
                            ),
                            Text(item['quantity'].toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  cartList[index]['quantity']++;
                                });
                                updateCartList();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  cartList.removeAt(index);
                                });
                                updateCartList();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Gap(26),
              _buildPaymentSummary(),
              const Gap(26),
              DefaultButton(
                btnContent: "Order Now",
                function: () {
                  Navigator.pushNamed(context, 'payment');
                },
              ),
              const Gap(6),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentSummary() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(getSize(12)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(16)),
        border: Border.all(width: 1, color: const Color(0xFFEDEDED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Summary",
            style: TextStyles.bodyLargeSemiBold.copyWith(
              color: Pallete.neutral100,
              fontSize: getFontSize(FontSizes.large),
            ),
          ),
          const Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Items: ${cartList.length}",
                style: TextStyles.bodyMediumMedium.copyWith(
                  color: const Color(0xFF878787),
                  fontSize: getFontSize(FontSizes.medium),
                ),
              ),
              Text(
                "\$${getTotalPrice().toStringAsFixed(2)}",
                style: TextStyles.bodyMediumBold.copyWith(color: Pallete.neutral100),
              ),
            ],
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery Fee",
                style: TextStyles.bodyMediumMedium.copyWith(
                  color: const Color(0xFF878787),
                  fontSize: getFontSize(FontSizes.medium),
                ),
              ),
              Text(
                "Free",
                style: TextStyles.bodyMediumBold.copyWith(
                  color: Pallete.neutral100,
                  fontSize: getFontSize(FontSizes.medium),
                ),
              ),
            ],
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Discount",
                style: TextStyles.bodyMediumMedium.copyWith(
                  color: const Color(0xFF878787),
                  fontSize: getFontSize(FontSizes.medium),
                ),
              ),
              Text(
                "-\$5.00",
                style: TextStyles.bodyMediumBold.copyWith(
                  color: Pallete.orangePrimary,
                  fontSize: getFontSize(FontSizes.medium),
                ),
              ),
            ],
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyles.bodyMediumMedium.copyWith(
                  color: const Color(0xFF878787),
                  fontSize: getFontSize(FontSizes.medium),
                ),
              ),
              Text(
                "\$${(getTotalPrice() - 5).toStringAsFixed(2)}",
                style: TextStyles.bodyMediumBold.copyWith(
                  color: Pallete.neutral100,
                  fontSize: getFontSize(FontSizes.medium),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var item in cartList) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }

  void updateCartList() {
    // You can perform additional logic here, such as saving to a database
    // or updating a state management solution. For now, it just triggers UI update.
    setState(() {});
  }
}
