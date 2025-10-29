import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pcfsim_ui/mainOverview/main_overview_narrow.dart';
import 'package:pcfsim_ui/mainOverview/main_overview_state.dart';
import 'package:pcfsim_ui/mainOverview/main_overview_wide.dart';

class MainOverview extends StatelessWidget {
  const MainOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MainOverviewCubit(),
        child: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 1024) {
            return const MainOverviewWideLayout();
          } else {
            return const MainOverviewNarrowLayout();
          }
        }));
  }
}
