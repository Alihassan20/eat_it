import 'package:eat_it/state/cart_state.dart';
import 'package:eat_it/view_model/cart_vm/cart_view_model.dart';

class CartViewModelIpm implements CartViewModel{
  @override
  void updateCart(CartStateController controller, int index, int value) {
    controller.cart[index].quantity=value.toInt();
    controller.cart.refresh();
  }

}