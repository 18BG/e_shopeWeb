import 'package:e_shopweb/controllers/menu_controller.dart';
import 'package:e_shopweb/controllers/nav_controller.dart';
import 'package:e_shopweb/helpers/my_provider.dart';
import 'package:e_shopweb/home.dart';
import 'package:e_shopweb/pages/athentication/authentication.dart';
import 'package:e_shopweb/pages/commande/commande_management.dart';
import 'package:e_shopweb/routing/routes.dart';

import 'package:flutter/material.dart';

import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

// ...

// await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(NavigationController());
  Get.put(MenuControllere());
  Get.put(GlobalProvider());
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => GlobalProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //Appeler getCategoryProvider dès le démarrage
  Future<void> _initializeData(BuildContext context) async {
    var provider = Provider.of<GlobalProvider>(context, listen: false);
    await provider.getCategoryProvider();
    await provider.fetchUsers();
    await provider.fetchVente();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AuthenticationPageRoute,
      getPages: [
        GetPage(name: RootRoute, page: () => HomePage()),
        GetPage(name: AuthenticationPageRoute, page: () => AuthenticationPage())
      ],
      debugShowCheckedModeBanner: false,
      title: 'Dash',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}













// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   // Appeler getCategoryProvider lorsque l'application démarre
//   void _initializeData(BuildContext context) {
//     Provider.of<GlobalProvider>(context, listen: false).getCategoryProvider();
//   }

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance
//         .addPostFrameCallback((_) => _initializeData(context));
//     return GetMaterialApp(
//       initialRoute: AuthenticationPageRoute,
//       getPages: [
//         GetPage(name: RootRoute, page: () => HomePage()),
//         GetPage(name: AuthenticationPageRoute, page: () => AuthenticationPage())
//       ],
//       debugShowCheckedModeBanner: false,
//       title: 'Dash',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//     );
//   }
// }
