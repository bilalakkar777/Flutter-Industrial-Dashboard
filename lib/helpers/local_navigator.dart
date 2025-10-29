import 'package:flutter/cupertino.dart';
import 'package:pcfsim_ui/constants/controllers.dart';
import 'package:pcfsim_ui/routing/router.dart';
import 'package:pcfsim_ui/routing/routes.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: homePageRoute,
    );
