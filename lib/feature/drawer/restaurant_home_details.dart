import 'dart:ui';

import 'package:eat_it/state/main_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/color.dart';
import '../../view_model/restaurant_details_vm/restaurant_view_details_model.dart';
import '../../view_model/restaurant_details_vm/restaurant_view_details_model_imp.dart';
import '../../widget/restaurant_widget/best_deals_widgets.dart';
import '../../widget/restaurant_widget/most_popular_widget.dart';
class RestaurantHomeDetails extends StatelessWidget {
  final ZoomDrawerController zoomDrawerController;
   RestaurantHomeDetails(this.zoomDrawerController);
  final MainStateController mainStateController = Get.find();
  final RestaurantDetailsViewModel viewModel = RestaurantDetailsViewModelImp();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: ()=>zoomDrawerController.toggle!(),
          child: Icon(Icons.view_headline),
        ),
        elevation: 10,
        backgroundColor: kwhite,
        iconTheme: const IconThemeData(color: Colors.black, size: 30),
        title: Text(
          mainStateController.selectedRestaurant.value.name,
          style: GoogleFonts.jetBrainsMono(
              fontWeight: FontWeight.w900, color: kblack),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: MostPopularWidget(viewModel, mainStateController)),
            Expanded(
                flex: 2,
                child: BestDealsWidgets(viewModel,mainStateController))
          ],
        ),
      ),
    );
  }

}
