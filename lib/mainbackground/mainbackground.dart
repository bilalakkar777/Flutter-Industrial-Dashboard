import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pcfsim_ui/apptheme/apptheme.dart';
import 'package:pcfsim_ui/mainbackground/mainbackground_state.dart';

class MainBackground extends StatelessWidget {
  const MainBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MainBackgroundCubit(),
        child: BlocBuilder<MainBackgroundCubit, MainBackgroundState>(
            builder: (context, state) {
          return SizedBox.expand(
              child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg')),
            ),
          ));
        }));
  }
}
