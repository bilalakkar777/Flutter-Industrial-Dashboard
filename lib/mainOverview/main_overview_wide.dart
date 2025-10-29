import 'dart:ui';

import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pcfsim_ui/mainOverview/main_overview_state.dart';
import 'package:pcfsim_ui/apptheme/apptheme.dart';
import 'package:pcfsim_ui/mainbackground/mainbackground.dart';

class WideMenuButton extends StatelessWidget {
  const WideMenuButton(
      {required this.onPressed,
      required this.icon,
      required this.isSelected,
      super.key});

  final void Function() onPressed;
  final Widget icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    if (!isSelected) {
      return IconButton(
        onPressed: onPressed,
        icon: icon,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
        ),
      );
    } else {
      return IconButton(
          onPressed: onPressed,
          icon: icon,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromRGBO(35, 112, 255, 1)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
            // iconColor: MaterialStateProperty.all<Color>(AppTheme.passiveColor),
          ));
    }
  }
}

class MainOverviewWideLayout extends StatelessWidget {
  const MainOverviewWideLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Container(
          decoration: BoxDecoration(
            // color: AppTheme.primaryColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          height: 35,
          child: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
              style: ButtonStyle(
                  // overlayColor:
                  //      MaterialStateProperty.all<Color>(AppTheme.primaryColor),
                  )),
        ),
        body: BlocConsumer<MainOverviewCubit, MainOverviewState>(
            listener: (context, state) => {},
            builder: (context, state) {
              MainOverviewCubit cubit = context.watch<MainOverviewCubit>();
              return Row(children: [
                Expanded(
                    flex: state.wideMenuFlexLeft,
                    child: WideMenu(
                      onInfoTap: () {
                        cubit.onIntroductionTap();
                      },
                      onMiningTap: () {
                        cubit.onMiningTap();
                      },
                      onDeliveryTap: () {
                        cubit.onDeliveryTap();
                      },
                      onAutomationTap: () {
                        cubit.onAutomationTap();
                      },
                      onOperatorTap: () {
                        cubit.onOperatorTap();
                      },
                      onHomeTap: () {
                        cubit.onHomeTap();
                      },
                    )),
                Expanded(flex: state.wideMenuFlexRight, child: WideContent()),
              ]);
            }));
  }
}

class WideContent extends StatelessWidget {
  const WideContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainBackground(),
        Container(
            width: double.infinity,
            height: double.infinity,
            child: ClipRect(
                child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: SimpleMap(
                instructions: SMapWorld.instructions,
                defaultColor: const Color.fromARGB(255, 106, 100, 100),
                colors: SMapWorldColors(dE: Colors.green).toMap(),
                callback: (id, name, tapdetails) {
                  print(id);
                },
              ),

              // const Placeholder(
              //   color: Color.fromRGBO(255, 255, 255, 1),
              //   strokeWidth: 5,
              // ),
            ))),
      ],
    );
  }
}

class WideMenu extends StatelessWidget {
  const WideMenu(
      {required this.onInfoTap,
      required this.onMiningTap,
      required this.onDeliveryTap,
      required this.onAutomationTap,
      required this.onOperatorTap,
      required this.onHomeTap,
      super.key});

  final void Function() onInfoTap;
  final void Function() onMiningTap;
  final void Function() onDeliveryTap;
  final void Function() onAutomationTap;
  final void Function() onOperatorTap;
  final void Function() onHomeTap;

  @override
  Widget build(BuildContext context) {
    MainOverviewState state = context.watch<MainOverviewCubit>().state;
    return Column(
      children: [
        //const Expanded(flex: 1, child: SizedBox()),
        Expanded(
            flex: 16,
            child: Container(
                width: 65,
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  //   stops: const [0.1, 0.5, 0.9],
                  //   colors: [
                  //     AppTheme.primaryColor,
                  //     AppTheme.primaryColor.withBlue(150),
                  //     AppTheme.primaryColor.withBlue(100),
                  //   ],
                  // ),
                  // borderRadius: const BorderRadius.only(
                  //     topRight: Radius.circular(15),
                  //     bottomRight: Radius.circular(15),
                  //     topLeft: Radius.circular(15),
                  //     bottomLeft: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          WideMenuButton(
                              isSelected: state.isIntroductionSelected,
                              icon: const Icon(
                                Icons.info,
                                size: 36,
                              ),
                              onPressed: () => onInfoTap()),
                          WideMenuButton(
                            isSelected: state.isMiningSelected,
                            onPressed: () => onMiningTap(),
                            icon: const Icon(
                              Icons.front_loader,
                              size: 36,
                            ),
                          ),
                          WideMenuButton(
                            isSelected: state.isDeliverySelected,
                            onPressed: () => onDeliveryTap(),
                            icon: const Icon(
                              Icons.local_shipping,
                              size: 36,
                            ),
                          ),
                          WideMenuButton(
                            isSelected: state.isAutomationSelected,
                            onPressed: () => onAutomationTap(),
                            icon: const Icon(
                              Icons.precision_manufacturing,
                              size: 36,
                            ),
                          ),
                          WideMenuButton(
                            isSelected: state.isOperatorSelected,
                            onPressed: () => onOperatorTap(),
                            icon: const Icon(
                              Icons.pallet,
                              size: 36,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            WideMenuButton(
                                isSelected: state.isHomeSelected,
                                onPressed: () => onHomeTap(),
                                icon: const Icon(
                                  Icons.home_filled,
                                  size: 36,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )),
                  ],
                ))),
        //const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }
}
