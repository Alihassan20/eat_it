import 'dart:convert';

import 'package:eat_it/model/category_model.dart';
import 'package:firebase_database/firebase_database.dart';

Future<List<CategoryModel>> getCategoryByRestaurantId(String restaurantId) async {

  var list = List<CategoryModel>.empty(growable: true);
  var source = await FirebaseDatabase.instance.reference()
      .child('Restaurant')
      .child(restaurantId)
      .child('Category')
      .once();
  var values = source.value;
  values.forEach((key, value){
    list.add(CategoryModel.fromjson(jsonDecode(jsonEncode(value))));
  });

  return list;
}