import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_it/model/size_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/color.dart';
import '../../state/cart_state.dart';
import '../../state/food_details_state.dart';
import '../../state/food_list_state.dart';
import '../../state/main_state.dart';
import '../../widget/food_details/food_details_image_widgets.dart';

class FoodDetails extends StatelessWidget {
  FoodDetails({Key? key}) : super(key: key);
  final foodListStateController = Get.put(FoodListController());
  final foodDetailsStateController = Get.put(FoodDetailsStateController());
  final CartStateController cartStateController = Get.put(CartStateController());
  MainStateController controllers = Get.put(MainStateController());



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            title: Text(
              '${foodListStateController.selectedFood.value.name}',
              style: GoogleFonts.jetBrainsMono(color: Colors.black),
            ),
            elevation: 10,
            backgroundColor: kwhite,
            foregroundColor: kblack,
            bottom: PreferredSize(
                preferredSize:
                    Size.square(MediaQuery.of(context).size.height / 3),
                child: FoodDetailsImageWidgets(foodListStateController,(){
                   cartStateController.addToCart(foodListStateController.selectedFood.value,controllers.selectedRestaurant.value.resturantId,quantity:foodDetailsStateController.quantity.value);
                })),
            iconTheme: const IconThemeData(color: Colors.black, size: 30),
          ),
        ];
      },
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                  elevation: 12,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              '${foodListStateController.selectedFood.value.name}',
                              style: GoogleFonts.jetBrainsMono(
                                  color: Colors.blueGrey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                          const SizedBox(
                              height: 10
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  '\$${foodListStateController.selectedFood.value.price}',
                                  style: GoogleFonts.jetBrainsMono(
                                      color: Colors.blueGrey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900)),
                              Obx(()=> ElegantNumberButton(
                                  initialValue: foodDetailsStateController.quantity.value,
                                  minValue: 1,
                                  maxValue: 100,
                                  onChanged: (value) {
                                    foodDetailsStateController
                                        .quantity.value=value.toInt();
                                  },
                                  color: Colors.amberAccent,
                                  decimalPlaces: 0),

                              )
                            ],
                          )
                        ]),
                  )),
              Card(
                  elevation: 12,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RatingBar.builder(
                              initialRating: 5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemBuilder: (context,_){
                                return const Icon(Icons.star, color: Colors.amber,);
                              }, onRatingUpdate: (value){}),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                              '${foodListStateController.selectedFood.value.description}',
                              style: GoogleFonts.jetBrainsMono(
                                color: Colors.blueGrey,
                                fontSize: 14,
                              )),


                        ]),
                  )),
              foodListStateController.selectedFood.value.size.isNotEmpty?
              Card(
                  elevation: 12,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(()=>ExpansionTile(title:Text(
                              'Size',
                              style: GoogleFonts.jetBrainsMono(
                                  color: Colors.blueGrey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                              children: foodListStateController.selectedFood.value.size
                                  .map((v) => RadioListTile<SizeModel>(
                                title: Text(v.name),
                                value: v,
                                groupValue: foodDetailsStateController.selectedSize.value,
                                onChanged: (value) => foodDetailsStateController.selectedSize.value=value!,
                              )).toList()),)

                        ]),
                  ))
                  :
              Container()
              ,
              foodListStateController.selectedFood.value.addon.isNotEmpty?
              Card(
                  elevation: 12,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(()=>ExpansionTile(title:Text(
                              'Addon',
                              style: GoogleFonts.jetBrainsMono(
                                  color: Colors.blueGrey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                              children: foodListStateController
                                  .selectedFood.value.addon
                                  .map((e)=> ChoiceChip (label: Text(e.name)
                                , selected: foodDetailsStateController.selectedAddon.contains(e),
                                  onSelected: (selected) => selected ? foodDetailsStateController.selectedAddon.add(e):
                                  foodDetailsStateController.selectedAddon.remove(e),
                                selectedColor: Colors.amberAccent,

                              )).toList()

                                 ))

                        ]),
                  ))
                  :
              Container()

            ],
          ),
        ),
      )
    )));
  }
}
