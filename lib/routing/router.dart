import 'package:flutter/material.dart';
import 'package:pcfsim_ui/pages/operation/operation.dart';
import 'package:pcfsim_ui/pages/creation/creation.dart';
import 'package:pcfsim_ui/pages/overview/overview.dart';
import 'package:pcfsim_ui/pages/mining/mining.dart';
import 'package:pcfsim_ui/pages/home/home.dart';
import 'package:pcfsim_ui/pages/transport/transport.dart';
import 'package:pcfsim_ui/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(const OverviewPage());
    case miningPageRoute:
      return _getPageRoute(const MiningPage());
    case transportPageRoute:
      return _getPageRoute(const TransportPage());
    case creationPageRoute:
      return _getPageRoute(const CreationPage());
    case operationPageRoute:
      return _getPageRoute(const OperationPage());
    case homePageRoute:
      return _getPageRoute(const HomePage());
    default:
      return _getPageRoute(const OverviewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
