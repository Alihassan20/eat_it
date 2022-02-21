import 'package:eat_it/model/category_model.dart';

abstract class CategoryViewModel{
  Future<List<CategoryModel>> displayCategoryByRestaurantId(String restaurantId);

}