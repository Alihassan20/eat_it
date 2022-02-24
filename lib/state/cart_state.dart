import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/cart_model.dart';
import '../model/food_model.dart';

class CartStateController extends GetxController {
  var cart = List<CartModel>.empty(growable: true).obs;
  final box = GetStorage();

  getCart(String restaurantId) => cart.where((item) =>
      item.restaurantId == restaurantId &&
      (FirebaseAuth.instance.currentUser == null
          ? item.userUid == 'ANOUNYMOUS'
          : item.userUid == FirebaseAuth.instance.currentUser!.uid));

  addToCart(FoodModel foodModel, String restaurantId, {quantity = 1}) async {
    try {
      var cartItem = CartModel(
          id: foodModel.id,
          name: foodModel.name,
          image: foodModel.image,
          price: foodModel.price,
          size: foodModel.size,
          addon: foodModel.addon,
          description: foodModel.description,
          quantity: quantity,
          restaurantId: restaurantId,
          userUid: FirebaseAuth.instance.currentUser == null
              ? 'ANOUNYMOUS'
              : FirebaseAuth.instance.currentUser!.uid);
      if (isExists(cartItem, restaurantId)) {
        var foodNeedTOUpdate =
            cart.firstWhere((element) => element.id == cartItem.id);
        foodNeedTOUpdate.quantity += quantity as int;
      } else {
        cart.add(cartItem);
      }

      var jsonDBEncode = jsonEncode(cart);
      await box.write('CART_STORAGE', jsonDBEncode);
      cart.refresh();
      Get.snackbar('Add Cart Success', 'Your cart has been updated!');
    } catch (e) {
      Get.snackbar('Add Cart Error', e.toString());
    }
  }

  bool isExists(CartModel cartItem, String restaurantId) {
    return cart
        .any((e) => e.id == cartItem.id && e.restaurantId == restaurantId &&
    (FirebaseAuth.instance.currentUser == null
    ? e.userUid == 'ANOUNYMOUS'
        : e.userUid == FirebaseAuth.instance.currentUser!.uid));
  }

  sumCart(String restaurantId) => getCart(restaurantId).length == 0
      ? 0
      : getCart(restaurantId)
          .map((e) => e.price * e.quantity)
          .reduce((value, element) => value + element);

  getQuantity(String restaurantId) => getCart(restaurantId).length == 0
      ? 0
      : getCart(restaurantId)
          .map((e) => e.quantity)
          .reduce((value, element) => value + element);

  getShippingFee(String restaurantId) =>
      sumCart(restaurantId) * 0.1; //10% of total value

  getSubTotal(String restaurantId) =>
      sumCart(restaurantId) + getShippingFee(restaurantId);

  clearCart(restaurantId) {
    cart = getCart(restaurantId).clear();
    saveDatabase();
  }

  saveDatabase() => box.write('CART_STORAGE', jsonEncode(cart));
}
