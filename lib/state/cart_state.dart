import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/cart_model.dart';
import '../model/food_model.dart';

class CartStateController extends GetxController {
  var cart = List<CartModel>.empty(growable: true).obs;
  final box = GetStorage();

  addToCart(FoodModel foodModel,{ quantity=1}) async {
    try{
      var cartItem = CartModel(
        id: foodModel.id,
        name: foodModel.name,
        image: foodModel.image,
        price: foodModel.price,
        size: foodModel.size,
        addon: foodModel.addon,
        description: foodModel.description,
        quantity:quantity,
      );
      if(isExists (cartItem)) {
        var foodNeedTOUpdate= cart.firstWhere((element)  =>
        element.id == cartItem.id);
        foodNeedTOUpdate.quantity += quantity as int;
      }
      else{
        cart.add(cartItem);
      }

      var jsonDBEncode = jsonEncode(cart);
      await box.write('CART_STORAGE', jsonDBEncode);
      cart.refresh();
      Get.snackbar ('Add Cart Success', 'Your cart has been updated!');
    }catch(e){
      Get.snackbar('Add Cart Error', e.toString ());
    }
  }

  bool isExists(CartModel cartItem) {
    return cart.contains(cartItem);
  }

  sumCart() {
    return cart.length == 0 ? 0 : cart.map((e)=>  e.price*e.quantity)
        .reduce((value, element) =>
    value + element);
  }

  int getQuantity(){
    return cart.length== 0 ? 0 : cart.map((e)=>e.quantity)
        .reduce ((value, element) => value+element);}

  getShippingFee()=> sumCart()*0.1; //10% of total value

  getSubTotal () => sumCart() + getShippingFee();


}