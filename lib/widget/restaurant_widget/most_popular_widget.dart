import 'package:auto_animated/auto_animated.dart';
import 'package:eat_it/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/popular_item_model.dart';
import '../../state/main_state.dart';
import '../../view_model/restaurant_details_vm/restaurant_view_details_model.dart';
import '../common_widgets.dart';

class MostPopularWidget extends StatelessWidget {
   RestaurantDetailsViewModel viewModel ;
   MainStateController mainStateController;
   MostPopularWidget(this.viewModel,this.mainStateController);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: viewModel.displayMostPopularByRestaurantId(
            mainStateController
                .selectedRestaurant.value.resturantId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var listPopular =
            snapshot.data as List<PopularItemModel>;
            return Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                Text(
                  "Most Popular Categories",
                  style: GoogleFonts.jetBrainsMono(
                      fontSize: 24,
                      color: Colors.black45,
                      fontWeight: FontWeight.w900),
                ),
                Expanded(
                  child: LiveList(
                    showItemDuration: const Duration(milliseconds: 350),
                    showItemInterval: const Duration(milliseconds: 150),
                    reAnimateOnVisibility: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: listPopular.length,
                    itemBuilder: animationItemBuilder(
                          (index) => Container(
                        padding:const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                listPopular[index].image,
                              ),
                              backgroundColor: kPrimaryColor,
                              maxRadius: 60,
                              minRadius: 40,
                            ),
                            const SizedBox(height: 10),
                            Text(listPopular[index].name,style: GoogleFonts.jetBrainsMono(
                                color: Colors.black45,
                                fontWeight: FontWeight.w900),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
