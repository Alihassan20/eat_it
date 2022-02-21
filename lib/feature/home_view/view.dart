import 'package:auto_animated/auto_animated.dart';
import 'package:eat_it/constant/color.dart';
import 'package:eat_it/model/restaurant_model.dart';
import 'package:eat_it/state/main_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/strings.dart';
import '../../view_model/home_vm/main_view_model_imp.dart';
import '../../widget/common_widgets.dart';
import '../../widget/home_widget/restaurant_info.dart';
import '../../widget/home_widget/restaurant_image.dart';
import '../drawer/restaurant_home.dart';

class HomeView extends StatefulWidget {
  final FirebaseApp app;

  HomeView({required this.app});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final viewModel = MainViewModelImp();
  final mainStateController = Get.put(MainStateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 15),
        title: Text(
          restaurantText,
          style: GoogleFonts.jetBrainsMono(
              fontWeight: FontWeight.w900, color: kblack),
        ),
        backgroundColor: kwhite,
        elevation: 10,
      ),
      body: FutureBuilder(
        future: viewModel.displayRestaurantList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var list = snapshot.data as List<RestaurantModel>;
            return Container(
              margin: const EdgeInsets.only(top: 10, left: 8),
              child: LiveList(
                showItemDuration: const Duration(milliseconds: 350),
                showItemInterval: const Duration(milliseconds: 150),
                reAnimateOnVisibility: true,
                scrollDirection: Axis.vertical,
                itemCount: list.length,
                itemBuilder: animationItemBuilder(
                  (index) => InkWell(
                    onTap: () {
                      mainStateController.selectedRestaurant.value=list[index];
                      Get.to( ()=>RestaurantView());
                    },
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 2.5 * 1.13,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RestaurantImageWidgets(list, index),
                          RestaurantInfoWidgets(list, index),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

}
