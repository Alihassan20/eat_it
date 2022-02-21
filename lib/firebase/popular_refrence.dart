import 'dart:convert';

import 'package:eat_it/model/popular_item_model.dart';
import 'package:firebase_database/firebase_database.dart';


Future<List<PopularItemModel>> getPopularByRestaurantId(String restaurantId) async {

  var list = List<PopularItemModel>.empty(growable: true);
  var source = await FirebaseDatabase.instance.reference()
      .child('Restaurant')
      .child(restaurantId)
      .child('MostPopular')
      .once();
  var values = source.value;
  values.forEach((key, value){
    list.add(PopularItemModel.fromJson(jsonDecode(jsonEncode(value))));
  });

  return list;
}