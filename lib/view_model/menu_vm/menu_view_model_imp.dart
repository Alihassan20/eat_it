import 'package:eat_it/feature/category_view/view.dart';
import 'package:eat_it/view_model/menu_vm/menu_view_model.dart';
import 'package:get/get.dart';

class MenuViewModelImp implements MenuViewModel{
  @override
  void navigateCategories() {
    Get.to(()=> CategoryView());
  }

}