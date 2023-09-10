const RootRoute = "/root";
const DashboardDisplayName = "DashBoard";
const DashboardRoute = "/dash";

const AuthenticationPageDisplayName = "Log Out";
const AuthenticationPageRoute = "/auth";

const ProductManagementRoute = "/productManagement";
const ProductManagementDisplayName = "Gestion des produits";

const CommandeManagementRoute = "/commandeManagement";
const CommandeManagementDisplayName = "Gestion des commandes";

const AddProductRoute = "/addProduct";
const AddProductDisplayName = "Ajout des produits";

const ProductListRoute = "/productList";
const ProductListDisplayName = "Liste des produits";

const CategorieScreenRoute = "/categorieScreen";
const CategorieScreenDisplayName = "Catégorie";

const AddCategorieScreenRoute = "/addcategorie";
const AddCategorieScreenDislayName = "Ajouter une catégorie";

const StockAndPrixScreenRoute = "/stockAndPrix";
const StockAndPrixScreenDisplayName = "StockAndPrix";

class MenuItem {
  final String name;
  final String route;
  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItems = [
  MenuItem(DashboardDisplayName, DashboardRoute),
  MenuItem(ProductManagementDisplayName, ProductManagementRoute),
  MenuItem(CommandeManagementDisplayName, CommandeManagementRoute),
  MenuItem(AuthenticationPageDisplayName, AuthenticationPageRoute),
];
