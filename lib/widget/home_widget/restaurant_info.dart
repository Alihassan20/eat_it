import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/restaurant_model.dart';


class RestaurantInfoWidgets extends StatelessWidget {
  List<RestaurantModel> list;
  int index;
   RestaurantInfoWidgets(this.list,this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            child: Column(children: [
              Text(
                list[index].name,
                style: GoogleFonts.jetBrainsMono(
                    fontWeight: FontWeight.w900),
              ),
              Text(
                list[index].address,
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 12,
                    fontWeight: FontWeight.w900),
              )

            ])));
  }
}
