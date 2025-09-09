import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flash_food/Core/Routes/routes_name.dart';
import 'package:flash_food/Core/app_colors.dart';
import 'package:flash_food/Core/assets_constantes.dart';
import 'package:flash_food/Core/font_size.dart';
import 'package:flash_food/Core/response_conf.dart';
import 'package:flash_food/Core/text_styles.dart';


// FoodItem Widget as per your original implementation
class FoodItem extends StatelessWidget {
  final Map myObj;

  const FoodItem({super.key, required this.myObj});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RoutesName.aboutMenu),
      child: Container(
        height: getHeight(153),
        width: getWidth(224),
        margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getSize(12)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 60,
              offset: Offset(6, 6),
              spreadRadius: 0,
            )
          ],
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: getWidth(153),
              height: getHeight(120),
              padding: EdgeInsets.all(getSize(8)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(getSize(8)),
                image: const DecorationImage(
                  image: AssetImage(AssetsConstants.ordinaryBurger),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: getHeight(30),
                    height: getHeight(50),
                    padding: EdgeInsets.all(getSize(5)),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      color: Pallete.pureError,
                      size: getSize(15),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  child: Text(
                    myObj['name'].toString(),
                    style: TextStyles.bodyLargeMedium.copyWith(
                      color: Pallete.neutral100,
                      fontSize: getFontSize(FontSizes.large),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: getSize(130),
                  child: Text(
                    myObj['description'].toString(),
                    style: TextStyles.bodySmallMedium.copyWith(
                      color: Pallete.neutral100,
                      fontSize: getFontSize(FontSizes.small),
                    ),
                  ),
                ),
                Container(
                  width: getSize(130),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Pallete.orangePrimary,
                            size: getSize(16),
                          ),
                          Text(
                            myObj['available'].toString(),
                            style: TextStyles.bodySmallRegular.copyWith(
                              color: Pallete.neutral100,
                              fontSize: getFontSize(FontSizes.superSmall),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Pallete.orangePrimary,
                            size: getSize(16),
                          ),
                          Text(
                            myObj['rating'].toString(),
                            style: TextStyles.bodySmallMedium.copyWith(
                              color: Pallete.neutral100,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(4),
                Container(
                  width: getSize(130),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$${(myObj['price'])}',
                        style: TextStyles.bodyLargeBold.copyWith(
                          color: Pallete.orangePrimary,
                          fontSize: getFontSize(FontSizes.medium),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          print(myObj['name'].toString());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            shape: BoxShape.circle
                          ),
                          child: Icon(
                            Icons.add,
                            color: Pallete.whiteError,
                            size: getSize(18),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}