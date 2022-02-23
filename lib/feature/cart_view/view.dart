import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_it/constant/color.dart';
import 'package:eat_it/view_model/cart_vm/cart_view_model_ipm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../state/cart_state.dart';

class CartView extends StatelessWidget {
  final box = GetStorage();
  final CartStateController controller = Get.put(CartStateController());
  CartViewModelIpm viewModelIpm =CartViewModelIpm();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        actions: [controller.getQuantity()>0?IconButton(onPressed: () {}, icon: Icon(Icons.clear)):Container()],
      ),
      body: controller.getQuantity()>0
          ? Obx(()=> Column(
          children: [
          Expanded(child: ListView.builder(
      itemCount: controller.cart.length,
      itemBuilder: (context, index) {
        return Slidable(
          startActionPane: ActionPane(motion: const ScrollMotion(),children: [
            SlidableAction(
              onPressed:(context){},
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],),
            child: Card(
                elevation: 8.0,
                margin: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 6.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Expanded (flex: 2,child: CachedNetworkImage(
                        errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.image)),
                        progressIndicatorBuilder:
                            (context, url, dowloadProgress) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        imageUrl:
                        controller.cart[index].image,
                        fit: BoxFit.cover),),
                    Expanded(flex: 6,child: Container(
                        padding: const EdgeInsets.only (bottom: 8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Text(
                                        controller.cart[index].name,
                                        style: GoogleFonts.jetBrainsMono(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,)),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Text(
                                        '\$ ${controller.cart[index].price}',
                                        style: GoogleFonts.jetBrainsMono(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,)),
                                ],
                              ),
                              Center(
                                child: ElegantNumberButton(
                                    initialValue: controller.cart[index].quantity,
                                    minValue: 1,
                                    maxValue: 100,
                                    onChanged: (value) {
                                      viewModelIpm.updateCart(controller, index, value.toInt());
                                    },
                                    color: Colors.amberAccent,
                                    decimalPlaces: 0),
                              )

                            ])
                    ))
                  ],
                ),
            )
        ));
          })),
        Card(
          elevation: 12,
          child: Padding (padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 18, fontWeight: FontWeight.bold),),
                    Text(
                      '${controller.sumCart()}',
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 18, fontWeight: FontWeight.bold),)

                  ],),
                  Divider(thickness: 2),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shipping fee',
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 18, fontWeight: FontWeight.bold),),
                      Text(
                        '${controller.getShippingFee().toStringAsFixed(2)}',
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 18, fontWeight: FontWeight.bold),)

                    ],),
                  Divider(thickness: 2),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sub Total',
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 20, fontWeight: FontWeight.bold,color: kPrimaryColor),),
                      Text(
                        '${controller.getSubTotal().toStringAsFixed(2)}',
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 20, fontWeight: FontWeight.bold,color: kPrimaryColor),)

                    ],)

                ],
              ))),
        ],
      )):const  Center(
        child: Text("Your Cart Is Empty"),
      ),
    );
  }
}
