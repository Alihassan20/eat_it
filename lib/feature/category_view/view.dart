import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_it/model/category_model.dart';
import 'package:eat_it/view_model/category_vm/category_view_model_ipm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/color.dart';
import '../../state/category_state.dart';
import '../../state/main_state.dart';
import '../../widget/common_widgets.dart';
import '../food_listView/view.dart';

class CategoryView extends StatelessWidget {
   CategoryView({Key? key}) : super(key: key);
final viewModel = CategoryViewModelImp();
   final mainStateController = Get.put(MainStateController());
   final categoryStateController = Get.put(CategoryStateController());


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 10,
          backgroundColor: kwhite,
          iconTheme: const IconThemeData(color: Colors.black, size: 30),
          title: Text("Categories", style: GoogleFonts.jetBrainsMono(
              fontWeight: FontWeight.w900, color: kblack),
          )),
      body:FutureBuilder(
        future: viewModel.displayCategoryByRestaurantId(mainStateController.selectedRestaurant.value.resturantId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var listCategory = snapshot.data as List<CategoryModel>;
            return Container(
              margin: const EdgeInsets.only(top: 10, left: 8),
              child: LiveGrid(
                showItemDuration: const Duration(milliseconds: 300),
                showItemInterval: const Duration(milliseconds: 300),
                reAnimateOnVisibility: true,
                scrollDirection: Axis.vertical,
                itemCount: listCategory.length,
                itemBuilder: animationItemBuilder(
                      (index) => InkWell(
                    onTap: () {
                      categoryStateController.selectedCategory.value=listCategory[index];
                      Get.to(()=>FoodListView());
                    },
                    child: Card(
                        semanticContainer: true,
                        clipBehavior:
                        Clip.antiAliasWithSaveLayer,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                                errorWidget: (context, url, error) =>
                                const Center(child: Icon(Icons.image)),
                                progressIndicatorBuilder: (context, url, dowloadProgress) =>
                                const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                imageUrl: listCategory[index].image,
                                fit: BoxFit.cover),
                            Container(color: Colors.black38),
                            Center(
                              child: Text('${listCategory[index].name}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.jetBrainsMono(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900, color: kwhite),),
                            )
                          ],
                        )),
                  ),
                ), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 1, mainAxisSpacing: 1),
              ),
            );
          }
        },
      ),

    );
  }
}
