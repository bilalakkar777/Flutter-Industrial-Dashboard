import 'package:flutter/material.dart';
import 'package:pcfsim_ui/constants/controllers.dart';
import 'package:pcfsim_ui/helpers/reponsiveness.dart';
import 'package:pcfsim_ui/pages/operation/widgets/operation_table.dart';
import 'package:pcfsim_ui/widgets/custom_text.dart';
import 'package:get/get.dart';

class OperationPage extends StatelessWidget {
  const OperationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Expanded(
            child: ListView(
          children: const [
            Operationtable(),
          ],
        )),
      ],
    );
  }
}
