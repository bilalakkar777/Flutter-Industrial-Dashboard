import 'package:flutter/material.dart';
import 'package:pcfsim_ui/helpers/reponsiveness.dart';
import 'package:pcfsim_ui/widgets/horizontal_menu_item.dart';
import 'package:pcfsim_ui/vertical_menu_item.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final Function() onTap;
  final bool isVertical;

  const SideMenuItem({
    Key? key,
    required this.itemName,
    required this.onTap,
    required this.isVertical,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return VertticalMenuItem(
        itemName: itemName,
        onTap: onTap,
      );
    } else {
      return HorizontalMenuItem(
        itemName: itemName,
        onTap: onTap,
      );
    }
  }
}
