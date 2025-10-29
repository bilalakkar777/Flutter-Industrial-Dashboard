import 'package:flutter/material.dart';
import 'package:pcfsim_ui/constants/controllers.dart';

import 'package:pcfsim_ui/helpers/reponsiveness.dart';
import 'package:pcfsim_ui/routing/routes.dart';
import 'package:pcfsim_ui/widgets/custom_text.dart';
import 'package:pcfsim_ui/widgets/side_menu_item.dart';
import 'package:get/get.dart';
import 'package:pcfsim_ui/apptheme/apptheme.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool isVertical = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: light,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(width: width / 48),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset("assets/icons/idta.gif"),
                    ),
                    const Flexible(
                      child: CustomText(
                        text: "idta",
                        size: 20,
                        weight: FontWeight.bold,
                        color: active,
                      ),
                    ),
                    SizedBox(width: width / 48),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Switch(
                value: isVertical,
                onChanged: (value) {
                  setState(() {
                    isVertical = value;
                  });
                },
              ),
              Text(
                isVertical ? 'Vertical Menu' : 'Horizontal Menu',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
          Divider(
            color: lightGrey.withOpacity(.1),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItemRoutes
                .map((item) => SideMenuItem(
                    itemName: item.name,
                    onTap: () {
                      if (!menuController.isActive(item.name)) {
                        menuController.changeActiveItemTo(item.name);
                        if (ResponsiveWidget.isSmallScreen(context)) {
                          Get.back();
                        }
                        navigationController.navigateTo(item.route);
                      }
                    },
                    isVertical: isVertical))
                .toList(),
          )
        ],
      ),
    );
  }
}
