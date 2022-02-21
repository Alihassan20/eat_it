import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../model/restaurant_model.dart';

class RestaurantImageWidgets extends StatelessWidget {
  List<RestaurantModel> list;
  int index;
   RestaurantImageWidgets(this.list,this.index);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: CachedNetworkImage(
                errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.image)),
                progressIndicatorBuilder: (context, url, dowloadProgress) =>
                const Center(
                  child: CircularProgressIndicator(),
                ),
                imageUrl: list[index].imageUrl,
                fit: BoxFit.cover)));
  }
}
