import 'package:eat_it/state/cart_state.dart';
import 'package:eat_it/view_model/cart_vm/cart_view_model.dart';
import 'package:get/get.dart';

import '../../state/main_state.dart';

class CartViewModelIpm implements CartViewModel{
  MainStateController controllers = Get.put(MainStateController());

  @override
  void updateCart(CartStateController controller, int index, int value) {
    controller.cart[index].quantity=value.toInt();
    controller.cart.refresh();
    controller.saveDatabase();
  }

  void deleteCart(CartStateController controller, int index)
  {
    controller.cart.removeAt(index);
    controller.saveDatabase();
  }

  void clearCart(CartStateController controller)
  {
    controller.clearCart(controllers.selectedRestaurant.value.resturantId);
  }

}