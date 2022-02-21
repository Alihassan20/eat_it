import 'food_model.dart';

class CategoryModel {
  String key = '', name = '', image = '';
  List<FoodModel> foods = List<FoodModel>.empty(growable: true);

  CategoryModel({required this.name, required this.image, required this.foods});

  CategoryModel.fromjson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];

    if (json['foods'] != null) {
      foods = List<FoodModel>.empty(growable: true);
      json['foods'].forEach((v) {
        foods.add(FoodModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['foods'] = this.foods.map((e) => e.toJson()).toList();
    return data;
  }
}
