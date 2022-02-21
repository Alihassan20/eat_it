

import 'package:eat_it/feature/drawer/menu.dart';
import 'package:eat_it/feature/drawer/restaurant_home_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class RestaurantView extends StatelessWidget {
  final zoomController = ZoomDrawerController();
  RestaurantView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        controller: zoomController,
        mainScreen: RestaurantHomeDetails(zoomController),
        menuScreen: MenuScreen(zoomController),
        borderRadius: 24.0,
        showShadow: true,
        angle: 0.0,
        backgroundColor: Colors.greenAccent,
        slideWidth: MediaQuery.of(context).size.width*0.65,
        openCurve: Curves.bounceInOut,
        closeCurve: Curves.ease,
      ),
    );
  }


}
