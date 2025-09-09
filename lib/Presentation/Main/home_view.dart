import 'package:flash_food/Core/Routes/routes_name.dart';
import 'package:flash_food/Core/app_colors.dart';
import 'package:flash_food/Core/assets_constantes.dart';
import 'package:flash_food/Core/font_size.dart';
import 'package:flash_food/Core/response_conf.dart';
import 'package:flash_food/Core/text_styles.dart';
import 'package:flash_food/Presentation/Base/food_item.dart';
import 'package:flash_food/Presentation/Models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeView extends StatefulWidget {
   HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
   List burgerList = [
    {
      'name': 'Classic Beef Burger',
      'description': 'Juicy beef patty with lettuce, tomato, and cheese',
      'rating': '4.5',
      'available': 'Available',
      'price': 9.99,
    },
    {
      'name': 'Cheese Deluxe',
      'description': 'Beef patty loaded with double cheddar cheese',
      'rating': '4.7',
      'available': "Available",
      'price': 10.99,
    },
    {
      'name': 'Spicy Chicken Burger',
      'description': 'Crispy fried chicken with spicy mayo and lettuce',
      'rating': '4.6',
      'available': 'Available',
      'price': 8.99,
    },
    {
      'name': 'Veggie Supreme',
      'description': 'Grilled veggie patty with avocado and special sauce',
      'rating': '4.2',
      'available': 'Available',
      'price': 7.99,
    },
    {
      'name': 'BBQ Bacon Burger',
      'description': 'Beef patty with bacon, BBQ sauce, and onion rings',
      'rating': '4.8',
      'available': 'Available',
      'price': 11.49,
    },
    {
      'name': 'Mushroom Swiss Burger',
      'description': 'Grilled mushrooms, Swiss cheese, and garlic aioli',
      'rating': '4.3',
      'available': 'Available',
      'price': 9.49,
    }
  ];

   List tacoList = [
     {
       'name': 'Chicken Taco',
       'description': 'Grilled chicken with fresh salsa and cheese',
       'rating': 4.5,
       'available': 'Available',
       'price': 8.99,
     },
     {
       'name': 'Beef Taco',
       'description': 'Spicy beef with lettuce and sour cream',
       'rating': 4.7,
       'available': 'Available',
       'price': 9.49,
     },
     {
       'name': 'Veggie Taco',
       'description': 'Loaded with grilled veggies and guacamole',
       'rating': 4.2,
       'available': 'Available',
       'price': 7.99,
     },
   ];

   List drinkList = [
     {
       'name': 'Lemonade',
       'description': 'Refreshing homemade lemonade',
       'rating': 4.8,
       'available': 'Available',
       'price': 2.99,
     },
     {
       'name': 'Iced Tea',
       'description': 'Chilled iced tea with lemon',
       'rating': 4.6,
       'available': 'Available',
       'price': 2.49,
     },
     {
       'name': 'Soda',
       'description': 'Choice of cola or lemon-lime soda',
       'rating': 4.5,
       'available': 'Available',
       'price': 1.99,
     },
   ];

   List pizzaList = [
     {
       'name': 'Margherita Pizza',
       'description': 'Classic pizza with tomato and fresh basil',
       'rating': 4.7,
       'available': 'Available',
       'price': 12.99,
     },
     {
       'name': 'Pepperoni Pizza',
       'description': 'Topped with pepperoni and mozzarella cheese',
       'rating': 4.8,
       'available': 'Available',
       'price': 13.49,
     },
     {
       'name': 'Vegetable Pizza',
       'description': 'Loaded with seasonal vegetables',
       'rating': 4.4,
       'available': 'Available',
       'price': 11.99,
     },
   ];

   var selectedKey = 0;

   List newList = [];
   @override
   void initState(){
    super.initState();
    newList = List.from(burgerList);

   }


   @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: getHeight(250),
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: getWidth(24),
            ).copyWith(
              top: MediaQuery.of(context).viewPadding.top,
            ),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AssetsConstants.homeTopBackgroundImage),
                    fit: BoxFit.fill)),
            child: Padding(
              padding:
                  EdgeInsets.only(top: getHeight(20), bottom: getHeight(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Your Location",
                                style: TextStyles.bodyMediumRegular
                                    .copyWith(color: Colors.white, fontSize: getFontSize(FontSizes.medium)),
                              ),
                              const Gap(8),
                              const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Colors.white,
                                size: 16,
                              )
                            ],
                          ),
                          const Gap(8),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                                size: getSize(24),
                              ),
                              const Gap(8),
                              Text(
                                "Colombo, Sri Lanka",
                                style: TextStyles.bodyMediumSemiBold
                                    .copyWith(color: Colors.white, fontSize: getFontSize(FontSizes.medium)),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () => Navigator.pushNamed(context, RoutesName.search),
                            child: Container(
                              height: getSize(40),
                              width: getSize(40),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 1)),
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: getSize(24),
                              ),
                            ),
                          ),
                          const Gap(16),
                          InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, RoutesName.notification),
                            child: Container(
                              height: getSize(40),
                              width: getSize(40),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 1)),
                              child: Icon(
                                Icons.notifications_none_rounded,
                                color: Colors.white,
                                size: getSize(24),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const Gap(26),
                  Text(
                    "Provide the best \nfood for you",
                    style: TextStyles.headingH4SemiBold
                        .copyWith(color: Pallete.neutral10, fontSize: getFontSize(FontSizes.h4)),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(24)),
            child: Column(
              children: [
                const Gap(26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Find by Category",
                      style: TextStyles.bodyLargeSemiBold
                          .copyWith(color: Pallete.neutral100, fontSize: getFontSize(FontSizes.large)),
                    ),
                    Text(
                      "See All",
                      style: TextStyles.bodyMediumMedium
                          .copyWith(color: Pallete.orangePrimary, fontSize: getFontSize(FontSizes.medium)),
                    )
                  ],
                ),
                const Gap(18),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: categories
                        .asMap()
                        .map((key, category) => MapEntry(
                            key,
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  if (category.designation == "Burger") {
                                    newList = List.from(burgerList);
                                    selectedKey = 0;
                                  } else if (category.designation == "Taco") {
                                    newList = List.from(tacoList);
                                    selectedKey = 1;
                                  } else if (category.designation == "Drink") {
                                    newList = List.from(drinkList);
                                    selectedKey = 2;
                                  } else if (category.designation == "Pizza") {
                                    newList = List.from(pizzaList);
                                    selectedKey = 3;
                                  }
                                });
                              },
                              child: Container(
                                width: getSize(65),
                                height: getSize(65),
                                padding: const EdgeInsets.all(8),
                                decoration: ShapeDecoration(
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x0A111111),
                                      blurRadius: 24,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                  color: key == selectedKey
                                      ? Pallete.orangePrimary
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(category.link),
                                    const Gap(4),
                                    Text(
                                      category.designation.toString(),
                                      style: TextStyles.bodyMediumMedium.copyWith(
                                          color: key == selectedKey
                                              ? Colors.white
                                              : Pallete.neutral60),
                                    )
                                  ],
                                ),
                              ),
                            )))
                        .values
                        .toList()),
                const Gap(24),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: newList.length,
                  itemBuilder: ((context, index) {
                    var mObj = newList[index] as Map? ?? {};
                    return FoodItem(
                      myObj: mObj,
                    );
                  }),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
