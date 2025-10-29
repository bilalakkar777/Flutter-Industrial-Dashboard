const rootRoute = "/";

const overviewPageDisplayName = "Overview";
const overviewPageRoute = "/overview";

const miningPageDisplayName = "Mining";
const miningPageRoute = "/mining";

const transportPageDisplayName = "Transport";
const transportPageRoute = "/transport";

const creationPageDisplayName = "Creation";
const creationPageRoute = "/creation";

const operationPageDisplayName = "Operation";
const operationPageRoute = "/operation";

const homePageDisplayName = "Home";
const homePageRoute = "/home";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItemRoutes = [
  MenuItem(overviewPageDisplayName, overviewPageRoute),
  MenuItem(miningPageDisplayName, miningPageRoute),
  MenuItem(transportPageDisplayName, transportPageRoute),
  MenuItem(creationPageDisplayName, creationPageRoute),
  MenuItem(operationPageDisplayName, operationPageRoute),
  MenuItem(homePageDisplayName, homePageRoute),
];
