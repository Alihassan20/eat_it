import 'package:eat_it/model/size_model.dart';

import 'addon_model.dart';

class FoodModel {
  String description = '', id = '', name = '', image = '';
  double price = 0;
  List<SizeModel> size = List<SizeModel>.empty(growable: true);
  List<AddonModel> addon = List<AddonModel>.empty(growable: true);

  FoodModel(
      {required this.description,
      required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.size,
      required this.addon});

  FoodModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = double.parse(json['price'].toString());

    if (json['addon'] != null) {
      addon = List<AddonModel>.empty(growable: true);
      json['addon'].forEach((v) {
        addon.add(AddonModel.fromJson(v));
      });
    }

    if (json['size'] != null) {
      size = List<SizeModel>.empty(growable: true);
      json['size'].forEach((v) {
        size.add(SizeModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['size'] = this.size.map((e) => e.toJson()).toList();
    data['addon'] = this.addon.map((e) => e.toJson()).toList();

    return data;
  }
}
