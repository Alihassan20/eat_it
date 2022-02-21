import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_it/widget/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/color.dart';
import '../../state/category_state.dart';

class FoodListView extends StatelessWidget {
  FoodListView({Key? key}) : super(key: key);

  //final viewModel = CategoryViewModelImp();
  final categoryStateController = Get.put(CategoryStateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 10,
          backgroundColor: kwhite,
          iconTheme: const IconThemeData(color: Colors.black, size: 30),
          title: Text(
            categoryStateController.selectedCategory.value.name,
            style: GoogleFonts.jetBrainsMono(
                fontWeight: FontWeight.w900, color: kblack),
          )),
      body: Column(
        children: [
          Expanded(
            child: LiveList(
              showItemDuration: const Duration(milliseconds: 300),
              showItemInterval: const Duration(milliseconds: 300),
              reAnimateOnVisibility: true,
              scrollDirection: Axis.vertical,
              itemCount:
                  categoryStateController.selectedCategory.value.foods.length,
              itemBuilder: animationItemBuilder(
                (index) => InkWell(
                  onTap: () {
                    // categoryStateController.selectedCategory.value=listCategory[index];
                    // Get.to(()=>FoodListView());
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 6 * 2,
                    child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                                errorWidget: (context, url, error) =>
                                    const Center(child: Icon(Icons.image)),
                                progressIndicatorBuilder:
                                    (context, url, dowloadProgress) =>
                                        const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                imageUrl: categoryStateController
                                    .selectedCategory.value.foods[index].image,
                                fit: BoxFit.cover),
                            Container(color: Colors.black12),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                color: Colors.black38,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(top: 20, bottom: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                categoryStateController
                                                    .selectedCategory
                                                    .value
                                                    .foods[index]
                                                    .name,
                                                textAlign: TextAlign.center,
                                                style:
                                                    GoogleFonts.jetBrainsMono(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: kwhite),
                                              ),
                                              Text(
                                                '\$ Price ${categoryStateController.selectedCategory.value.foods[index].price}',
                                                textAlign: TextAlign.center,
                                                style:
                                                    GoogleFonts.jetBrainsMono(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: kwhite),
                                              ),
                                              Row(children: [
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.white,
                                                    )),
                                                const SizedBox(
                                                  width: 50,
                                                ),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.add_shopping_cart,
                                                      color: Colors.white,
                                                    )),
                                              ])
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
