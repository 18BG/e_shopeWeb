import 'package:e_shopweb/controllers/menu_controller.dart';
import 'package:e_shopweb/controllers/nav_controller.dart';
import 'package:e_shopweb/helpers/my_provider.dart';
import 'package:e_shopweb/home.dart';
import 'package:e_shopweb/pages/athentication/authentication.dart';
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
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => GlobalProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
