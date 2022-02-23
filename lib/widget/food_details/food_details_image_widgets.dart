import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constant/color.dart';
import '../../state/cart_state.dart';
import '../../state/category_state.dart';
import '../../state/food_list_state.dart';

class FoodDetailsImageWidgets extends StatelessWidget {
  final FoodListController foodListStateController ;
  VoidCallback click ;
  FoodDetailsImageWidgets( this.foodListStateController,this.click);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: double.infinity, // max width
        height: MediaQuery.of(context).size.height / 3 * 0.9,
        child: Hero(
          tag:foodListStateController.selectedFood.value.name,
          child:CachedNetworkImage(
              errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.image)),
              progressIndicatorBuilder:
                  (context, url, dowloadProgress) => const Center(
                child: CircularProgressIndicator(),
              ),
              imageUrl:
              foodListStateController.selectedFood.value.image,
              fit: BoxFit.cover),
        )
      ),
      Align(
          alignment: const Alignment(0.8, 1.0),
          heightFactor: 0.5,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  heroTag: "btn1",
                  onPressed: () {},
                  backgroundColor: kwhite,
                  child: const Icon(Icons.favorite_border,color: kblack,),
                ),
                FloatingActionButton(
                  heroTag: "btn2",
                  onPressed:click,
                  backgroundColor: kwhite,
                  child: const Icon(Icons.add_shopping_cart,color: kblack,),
                )

              ],
            ),
          )),
    ]);
  }
}
