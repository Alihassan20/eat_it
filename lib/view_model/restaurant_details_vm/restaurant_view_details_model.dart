import '../../model/popular_item_model.dart';

abstract class RestaurantDetailsViewModel{
  Future<List<PopularItemModel>> displayMostPopularByRestaurantId(String restaurantId) ;
  Future<List<PopularItemModel>> displayBestDealsByRestaurantId(String restaurantId) ;

}