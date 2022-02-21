import 'package:eat_it/firebase/category_refrence.dart';
import 'package:eat_it/model/category_model.dart';
import 'package:eat_it/view_model/category_vm/category_view_model.dart';

class CategoryViewModelImp implements CategoryViewModel{
  @override
  Future<List<CategoryModel>> displayCategoryByRestaurantId(String restaurantId) {
    return getCategoryByRestaurantId(restaurantId);

  }

}