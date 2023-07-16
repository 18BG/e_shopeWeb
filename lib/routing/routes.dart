const DashboardDisplayName = "DashBoard";
const DashboardRoute = "/dash";

const ProductManagementRoute = "/productManagement";
const ProductManagementDisplayName = "Gestion des produits";

const CommandeManagementRoute = "/commandeManagement";
const CommandeManagementDisplayName = "Gestion des commandes";

class MenuItem {
  final String name;
  final String route;
  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItems = [
  MenuItem(DashboardDisplayName, DashboardRoute),
  MenuItem(ProductManagementDisplayName, ProductManagementRoute),
  MenuItem(CommandeManagementDisplayName, CommandeManagementRoute)
];
