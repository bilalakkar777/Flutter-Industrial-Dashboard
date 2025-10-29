import 'package:flutter/material.dart';
import 'package:pcfsim_ui/constants/controllers.dart';
import 'package:pcfsim_ui/helpers/reponsiveness.dart';
import 'package:pcfsim_ui/pages/creation/widgets/creation_table.dart';
import 'package:pcfsim_ui/widgets/custom_text.dart';
import 'package:get/get.dart';

class CreationPage extends StatelessWidget {
  const CreationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Container(
                  margin: EdgeInsets.only(top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                  )),
            ],
          ),
        ),
        Expanded(
            child: ListView(
          children: const [CreationTable()],
        )),
      ],
    );
  }
}
