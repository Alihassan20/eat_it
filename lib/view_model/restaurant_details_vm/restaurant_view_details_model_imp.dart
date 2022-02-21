import 'package:eat_it/firebase/best_deals_refrence.dart';
import 'package:eat_it/firebase/popular_refrence.dart';
import 'package:eat_it/model/popular_item_model.dart';
import 'package:eat_it/view_model/restaurant_details_vm/restaurant_view_details_model.dart';

class RestaurantDetailsViewModelImp implements RestaurantDetailsViewModel {
  @override
  Future<List<PopularItemModel>> displayMostPopularByRestaurantId(String restaurantId) {
 return getPopularByRestaurantId(restaurantId);
  }

  @override
  Future<List<PopularItemModel>> displayBestDealsByRestaurantId(String restaurantId) {
    return getBestDealsByRestaurantId(restaurantId);

  }



 

}