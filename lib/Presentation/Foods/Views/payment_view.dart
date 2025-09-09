import 'package:flash_food/Core/app_colors.dart';
import 'package:flash_food/Core/assets_constantes.dart';
import 'package:flash_food/Core/font_size.dart';
import 'package:flash_food/Core/response_conf.dart';
import 'package:flash_food/Core/text_styles.dart';
import 'package:flash_food/Presentation/Auth/screens/default_button.dart';
import 'package:flash_food/Presentation/Base/base.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


class PaymentView extends StatelessWidget {
   PaymentView({Key? key}) : super(key: key);

  List cartList = [
    {
      'name': 'Classic Beef Burger',
      'price': 9.99,
      'quantity': 3,
    },
    {
      'name': 'Chicken Taco',
      'price': 8.99,
      'quantity': 3,
    },
    {
      'name': 'Lemonade',
      'price': 2.99,
      'quantity': 4,
    },
    {
      'name': 'Lemonade',
      'price': 2.99,
      'quantity': 4,
    },
    {
      'name': 'Lemonade',
      'price': 2.99,
      'quantity': 4,
    }
  ];


  @override
  Widget build(BuildContext context) {
    MathUtils.init(context);
    return Scaffold(
      appBar: buildAppBar(buildContext: context, screenTitle: "Payment"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Text(
              'You deserve better meal',
              style: TextStyles.bodyMediumRegular.copyWith(
                  color: Pallete.neutral60,
                  fontSize: getFontSize(FontSizes.medium)),
            ),
            const Gap(4),
            Text('Item Ordered',
                style: TextStyles.bodyLargeSemiBold.copyWith(
                    color: Pallete.neutral100,
                    fontSize: getFontSize(FontSizes.large))),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Container(
                      width: 400,
                      height: 200,
                      child: ListView.builder(
                      itemCount: cartList.length,
                        itemBuilder: (context, index) {
                          var item = cartList[index];
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text((++index).toString()),
                            ),
                            title: Text(item['name']),
                            subtitle: Text('Price: \$${item['price']}'),
                            trailing: Text('Total: \$${(item['price'] * item['quantity']).toStringAsFixed(2)}'),
                          );

                        },
                      ),
                    ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            const Gap(24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Details Transaction",
                  style: TextStyles.bodyLargeSemiBold.copyWith(
                      color: Pallete.neutral100,
                      fontSize: getFontSize(FontSizes.large)),
                ),
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Items Price",
                      style: TextStyles.bodyMediumRegular.copyWith(
                          color: Pallete.neutral60,
                          fontSize: getFontSize(FontSizes.medium)),
                    ),
                    Text(
                      "\$ 70",
                      style: TextStyles.bodyMediumMedium.copyWith(
                          color: Pallete.neutral100,
                          fontSize: getFontSize(FontSizes.medium)),
                    ),
                  ],
                ),
                const Gap(14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Driver",
                      style: TextStyles.bodyMediumRegular.copyWith(
                          color: Pallete.neutral60,
                          fontSize: getFontSize(FontSizes.medium)),
                    ),
                    Text(
                      "\$ 1.5",
                      style: TextStyles.bodyMediumMedium.copyWith(
                          color: Pallete.neutral100,
                          fontSize: getFontSize(FontSizes.medium)),
                    ),
                  ],
                ),
                const Gap(14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tax 10%",
                      style: TextStyles.bodyMediumRegular.copyWith(
                          color: Pallete.neutral60,
                          fontSize: getFontSize(FontSizes.medium)),
                    ),
                    Text(
                      "\$ 7.15",
                      style: TextStyles.bodyMediumMedium.copyWith(
                          color: Pallete.neutral100,
                          fontSize: getFontSize(FontSizes.medium)),
                    ),
                  ],
                ),
                const Gap(14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Price",
                      style: TextStyles.bodyMediumRegular.copyWith(
                          color: Pallete.neutral60,
                          fontSize: getFontSize(FontSizes.medium)),
                    ),
                    Text(
                      "\$ 79",
                      style: TextStyles.bodyMediumBold.copyWith(
                          color: Pallete.orangePrimary,
                          fontSize: getFontSize(FontSizes.medium)),
                    ),
                  ],
                ),
                const Gap(20),
              ],
            ),
            Container(
              height: 2,
              width: double.infinity,
              color: Pallete.neutral30,
            ),
            const Gap(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Deliver To",
                  style: TextStyles.bodyLargeSemiBold.copyWith(
                      color: Pallete.neutral100,
                      fontSize: getFontSize(FontSizes.large)),
                ),
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Name",
                      style: TextStyles.bodyMediumRegular.copyWith(
                          color: Pallete.neutral60,
                          fontSize: getFontSize(FontSizes.medium)),
                    ),
                    Text(
                      "Albert Stevano",
                      style: TextStyles.bodyMediumMedium.copyWith(
                          color: Pallete.neutral100,
                          fontSize: getFontSize(FontSizes.medium)),
                    ),
                  ],
                ),
                const Gap(14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phone No.",
                      style: TextStyles.bodyMediumRegular.copyWith(
                          color: Pallete.neutral60,
                          fontSize: getFontSize(FontSizes.medium)),
                    ),
                    Text(
                      "+12 8347 2838 28",
                      style: TextStyles.bodyMediumMedium.copyWith(
                          color: Pallete.neutral100,
                          fontSize: getFontSize(FontSizes.medium)),
                    ),
                  ],
                ),
                const Gap(14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Address",
                      style: TextStyles.bodyMediumRegular.copyWith(
                          color: Pallete.neutral60,
                          fontSize: getFontSize(FontSizes.medium)),
                    ),
                    Text(
                      "New York",
                      style: TextStyles.bodyMediumMedium.copyWith(
                          color: Pallete.neutral100,
                          fontSize: getFontSize(FontSizes.medium)),
                    ),
                  ],
                ),
                const Gap(14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "House No.",
                      style: TextStyles.bodyMediumRegular.copyWith(
                          color: Pallete.neutral60,
                          fontSize: getFontSize(FontSizes.medium)),
                    ),
                    Text(
                      "BC54 Berlin",
                      style: TextStyles.bodyMediumMedium.copyWith(
                          color: Pallete.neutral100,
                          fontSize: getFontSize(FontSizes.medium)),
                    ),
                  ],
                ),
                const Gap(14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "City",
                      style: TextStyles.bodyMediumRegular.copyWith(
                          color: Pallete.neutral60,
                          fontSize: getFontSize(FontSizes.medium)),
                    ),
                    Text(
                      "New York City",
                      style: TextStyles.bodyMediumMedium.copyWith(
                          color: Pallete.neutral100,
                          fontSize: getFontSize(FontSizes.medium)),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            DefaultButton(btnContent: "Chackout Now",function: (){
              Navigator.pushNamed(context, 'extraCard');
            },),
            const Gap(32),
          ],
        ),
      ),
    );
  }
}
