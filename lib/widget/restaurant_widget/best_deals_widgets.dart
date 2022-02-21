import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/color.dart';
import '../../model/popular_item_model.dart';
import '../../state/main_state.dart';
import '../../view_model/restaurant_details_vm/restaurant_view_details_model.dart';

class BestDealsWidgets extends StatelessWidget {
  RestaurantDetailsViewModel viewModel ;
  MainStateController mainStateController;
   BestDealsWidgets(this.viewModel,this.mainStateController);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: viewModel.displayBestDealsByRestaurantId(
            mainStateController
                .selectedRestaurant.value.resturantId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var listBestDeals =
            snapshot.data as List<PopularItemModel>;
            return CarouselSlider(
                items: listBestDeals
                    .map((e) => Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width:
                      MediaQuery.of(context).size.width,
                      margin:const  EdgeInsets.symmetric(
                          horizontal: 5.0),
                      child: Card(
                          semanticContainer: true,
                          clipBehavior:
                          Clip.antiAliasWithSaveLayer,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ImageFiltered(
                                imageFilter:
                                ImageFilter.blur(
                                  sigmaX: 5,
                                  sigmaY: 5,
                                ),
                                child: CachedNetworkImage(
                                    errorWidget: (context, url, error) =>
                                    const Center(child: Icon(Icons.image)),
                                    progressIndicatorBuilder: (context, url, dowloadProgress) =>
                                    const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    imageUrl: e.image,
                                    fit: BoxFit.cover),
                              ),
                              Center(
                                child: Text('${e.name}',style: GoogleFonts.jetBrainsMono(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900, color: kwhite),),
                              )
                            ],
                          )),
                    );
                  },
                ))
                    .toList(),
                options: CarouselOptions(
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(seconds: 3),
                    autoPlayCurve: Curves.easeIn,
                    height: double.infinity));
          }
        },
      ),
    );
  }
}
