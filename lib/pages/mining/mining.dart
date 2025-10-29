import 'package:flutter/material.dart';
import 'package:pcfsim_ui/constants/controllers.dart';
import 'package:pcfsim_ui/helpers/reponsiveness.dart';
import 'package:pcfsim_ui/pages/mining/widgets/mining_table.dart';
import 'package:pcfsim_ui/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:pcfsim_ui/widgets/osm_map.dart';

import 'package:pcfsim_ui/pages/overview/widgets/overview_cards_large.dart';
import 'package:pcfsim_ui/pages/overview/widgets/overview_cards_medium.dart';
import 'package:pcfsim_ui/pages/overview/widgets/overview_cards_small.dart';

class MiningPage extends StatelessWidget {
  const MiningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(
            () => Row(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (ResponsiveWidget.isLargeScreen(context) ||
              ResponsiveWidget.isMediumScreen(context))
            if (ResponsiveWidget.isCustomSize(context))
              const OverviewCardsMediumScreen()
            else
              const OverviewCardsLargeScreen()
          else
            const OverviewCardsSmallScreen(),
          const SizedBox(height: 20),
          const OSMMap(height: 400),
        ],
      ),
    );
  }
}
