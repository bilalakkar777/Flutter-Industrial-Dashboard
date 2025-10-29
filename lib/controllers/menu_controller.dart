import 'package:flutter/material.dart';
import 'package:pcfsim_ui/routing/routes.dart';
import 'package:get/get.dart';
import 'package:pcfsim_ui/apptheme/apptheme.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = homePageDisplayName.obs;

  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isHovering(String itemName) => hoverItem.value == itemName;

  isActive(String itemName) => activeItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case overviewPageDisplayName:
        return _customIcon(Icons.info, itemName);
      case miningPageDisplayName:
        return _customIcon(Icons.front_loader, itemName);
      case transportPageDisplayName:
        return _customIcon(Icons.local_shipping, itemName);
      case creationPageDisplayName:
        return _customIcon(Icons.precision_manufacturing, itemName);
      case operationPageDisplayName:
        return _customIcon(Icons.pallet, itemName);
      case homePageDisplayName:
        return _customIcon(Icons.home_filled, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) return Icon(icon, size: 22, color: dark);

    return Icon(
      icon,
      color: isHovering(itemName) ? dark : lightGrey,
    );
  }
}
