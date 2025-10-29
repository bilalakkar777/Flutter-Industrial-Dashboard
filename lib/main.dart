import 'package:flutter/material.dart';

import 'package:pcfsim_ui/controllers/menu_controller.dart' as menu_controller;
import 'package:pcfsim_ui/controllers/navigation_controller.dart';
import 'package:pcfsim_ui/layout.dart';
import 'package:pcfsim_ui/pages/404/error.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcfsim_ui/apptheme/apptheme.dart';

import 'routing/routes.dart';

void main() {
  Get.put(menu_controller.MenuController());
  Get.put(NavigationController());
  runApp(const PCFSimUI());
}

class PCFSimUI extends StatelessWidget {
  const PCFSimUI({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: rootRoute,
      unknownRoute: GetPage(
          name: '/not-found',
          page: () => const PageNotFound(),
          transition: Transition.fadeIn),
      getPages: [
        GetPage(
            name: rootRoute,
            page: () {
              return SiteLayout();
            }),
      ],
      debugShowCheckedModeBanner: false,
      title: 'IDTA',
      theme: ThemeData(
        scaffoldBackgroundColor: light,
        textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
        primarySwatch: Colors.blue,
      ),
    );
  }
}
