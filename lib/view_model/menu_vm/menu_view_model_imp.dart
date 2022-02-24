import 'package:eat_it/feature/category_view/view.dart';
import 'package:eat_it/state/cart_state.dart';
import 'package:eat_it/state/main_state.dart';
import 'package:eat_it/view_model/menu_vm/menu_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_ui/flutter_auth_ui.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../feature/drawer/restaurant_home.dart';

class MenuViewModelImp implements MenuViewModel{
  final cartStateController = Get.put(CartStateController());
  final mainStateController = Get.put(MainStateController());

  @override
  void navigateCategories() {
    Get.to(()=> CategoryView());
  }

  @override
  void backToRestaurantlist() {
    Get.back(closeOverlays: true,canPop: false);
  }

  @override
  void processLoginState(BuildContext context) {
    print('Login click');}

  @override
  bool checkLoginState(BuildContext context) {
    return FirebaseAuth.instance.currentUser !=null ? true : false;
  }

  @override
  void logIn(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      FlutterAuthUi.startUi(
          items: [AuthUiProvider.phone], tosAndPrivacyPolicy: TosAndPrivacyPolicy(
        tosUrl: "https://www.google.com",
        privacyPolicyUrl: "https://www.google.com",
      ),
        androidOption: const AndroidOption(
          enableSmartLock: false, // default true
          showLogo: true, // default false
          overrideTheme: true, // default false

        )).then((value) async{
          navigationHome(context);
      }).catchError((onError){
        Get.snackbar('Error', '$onError');
      });
    }}

  @override
  void logOut(BuildContext context) {

    Get.defaultDialog(
        title: 'Do you really want to logout?',
        content: const Text('Logout'),
    backgroundColor: Colors.white,
      cancel: ElevatedButton(onPressed: ()=>Get.back(), child: const Text("Cancel")),
        confirm: ElevatedButton(onPressed: (){
          FirebaseAuth.instance
              .signOut()
              .then((value) => Get.offAll (RestaurantView()));
        }, child: const Text("logout"))

    );

   }

  @override
  void navigationHome(BuildContext context) async{
    var token= await FirebaseAuth.instance.currentUser!
    .getIdToken();
    var box =  GetStorage ();
    box.write('TOKEN', token);

    if(cartStateController.cart.length>0){
      var newCart = cartStateController.getCart(mainStateController.selectedRestaurant.value.resturantId);
      newCart.forEach((element) =>element.userUid==FirebaseAuth.instance.currentUser!.uid); //update userId

      cartStateController.cart.addAll(newCart); // Add to Global Cart
      cartStateController.saveDatabase (); // Save
    }
    Get.offAll(()=>RestaurantView ());


  }

}


