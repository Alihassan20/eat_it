import 'package:eat_it/firebase/restaurant_refrence.dart';
import 'package:eat_it/model/restaurant_model.dart';

import 'main_view_model.dart';

class MainViewModelImp implements MainViewModel {
  @override
  Future<List<RestaurantModel>> displayRestaurantList() {
    return getRestaurantList();
  }

}