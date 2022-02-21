import 'package:eat_it/constant/color.dart';
import 'package:eat_it/view_model/menu_vm/menu_view_model_imp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../widget/menu/menu_widget.dart';

class MenuScreen extends StatelessWidget {
  final ZoomDrawerController zoomDrawerController;
  final viewModel = MenuViewModelImp();

  MenuScreen(this.zoomDrawerController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                DrawerHeader(
                    child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 40),
                      child: const CircleAvatar(
                        maxRadius: 40,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.restaurant,
                          color: kwhite,
                          size: 40,
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
            const Divider(),
            Menu_widget(
              'Home',
              Icons.home,
              () => zoomDrawerController.toggle!(),
            ),
            const Divider(),
            Menu_widget(
              'Categories',
              Icons.list,
              () {
                viewModel.navigateCategories();
                print("p,h,an");
              },
            ),
          ],
        ),
      ),
    );
  }
}
