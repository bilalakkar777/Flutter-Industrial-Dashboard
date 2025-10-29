import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:pcfsim_ui/widgets/custom_text.dart';

/// Example without datasource
class Miningtable extends StatelessWidget {
  const Miningtable({super.key});

  @override
  Widget build(BuildContext context) {

          return SizedBox.expand(
              child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg')),
            ),
          ));
  }
}

