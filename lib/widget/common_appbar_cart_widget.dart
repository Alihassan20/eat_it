import 'package:badges/badges.dart';
import 'package:eat_it/feature/cart_view/view.dart';
import 'package:eat_it/state/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/color.dart';
import '../state/main_state.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  String title;
  final CartStateController cartStateController = Get.put(CartStateController());
  MainStateController controllers = Get.put(MainStateController());


  AppBarWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 10,
      backgroundColor: kwhite,
      iconTheme: const IconThemeData(color: Colors.black, size: 30),
      title: Text(
        "$title",
        style: GoogleFonts.jetBrainsMono(
            fontWeight: FontWeight.w900, color: kblack),
      ),
      actions: [
        Obx(()=>Badge(
          position: const BadgePosition(top: 0, end: 1),
          animationDuration: const Duration(milliseconds: 200),
          animationType: BadgeAnimationType.scale,
          showBadge: true,
          badgeColor: Colors.red,
          badgeContent: Text(
            '${cartStateController.getQuantity(controllers.selectedRestaurant.value.resturantId)}',
            style: GoogleFonts.jetBrainsMono(color: Colors.white),
          ),
          child: IconButton(onPressed: ()=>Get.to(()=>CartView()),icon:const Icon(Icons.shopping_bag)),

        ),
        ),
        const SizedBox(width: 20)
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56.0);
}
