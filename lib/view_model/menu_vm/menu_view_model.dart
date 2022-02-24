import 'package:flutter/material.dart';

abstract class MenuViewModel{
  void navigateCategories();
  void backToRestaurantlist();
  void processLoginState(BuildContext context);
  bool checkLoginState (BuildContext context);
  void logIn(BuildContext context);
  void logOut(BuildContext context);
  void navigationHome(BuildContext context);


}