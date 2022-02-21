import 'dart:convert';

import 'package:eat_it/model/restaurant_model.dart';
import 'package:firebase_database/firebase_database.dart';

import '../constant/strings.dart';

Future<List<RestaurantModel>> getRestaurantList() async {

  var list = List<RestaurantModel>.empty(growable: true);
  var source = await FirebaseDatabase.instance.reference().child('Restaurant').once();
    var values = source.value;
    RestaurantModel? restaurantModel ;
    values.forEach((key, value){
      restaurantModel= RestaurantModel.fromJson(jsonDecode(jsonEncode(value)));
      restaurantModel!.resturantId = key;
      list.add(restaurantModel!);
    });

  return list;
}