import 'dart:convert';

import 'package:auto_animated/auto_animated.dart';
import 'package:eat_it/constant/color.dart';
import 'package:eat_it/model/restaurant_model.dart';
import 'package:eat_it/state/cart_state.dart';
import 'package:eat_it/state/main_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/strings.dart';
import '../../model/cart_model.dart';
import '../../view_model/home_vm/main_view_model_imp.dart';
import '../../widget/common_widgets.dart';
import '../../widget/home_widget/restaurant_info.dart';
import '../../widget/home_widget/restaurant_image.dart';
import '../drawer/restaurant_home.dart';

class HomeView extends StatefulWidget {
  final FirebaseApp app;

  HomeView({required this.app});

  final viewModel = MainViewModelImp();
  final mainStateController = Get.put(MainStateController());
  final cartStateController = Get.put(CartStateController());
  final box = GetStorage();

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.box.hasData('CART_STORAGE')) {
        var cartSave = await widget.box.read('CART_STORAGE') as String;
        if (cartSave.length > 0 && cartSave.isNotEmpty) {
          final listCart = jsonDecode(cartSave) as List<dynamic>;
          final listCartParsed =
              listCart.map((e) => CartModel.fromJson(e)).toList();
          if(listCartParsed.length >0)
            widget.cartStateController.cart.value= listCartParsed;
        }
      } else {
        widget.cartStateController.cart.value =
            List<CartModel>.empty(growable: true);
      }
    });
  }

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
        future: widget.viewModel.displayRestaurantList(),
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
                      widget.mainStateController.selectedRestaurant.value =
                          list[index];
                      Get.to(() => RestaurantView());
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
