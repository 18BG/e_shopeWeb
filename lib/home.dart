import 'package:e_shopweb/helpers/responsiveness.dart';
import 'package:e_shopweb/large_screen.dart';
import 'package:e_shopweb/small_screen.dart';

import 'package:e_shopweb/widgets/rotating_widget.dart';
import 'package:e_shopweb/widgets/side_menu.dart';
import 'package:e_shopweb/widgets/top_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helpers/my_provider.dart';

class HomePage extends StatelessWidget {
  //const Home({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  // Appeler getCategoryProvider dès le démarrage
  Future<void> _initializeData(BuildContext context) async {
    GlobalProvider provider =
        Provider.of<GlobalProvider>(context, listen: false);
    if (provider.categoryList.isEmpty || provider.clientsList.isEmpty) {
      // await provider.isProcessing();
      await provider.getCategoryProvider();
      await provider.fetchUsers();
      await provider.fetchVente();
      //await provider.isProcessing();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeData(context),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Afficher le CircularProgressIndicator pendant le chargement
          return RotatingWidget();
        } else if (snapshot.hasError) {
          // Gérer les erreurs si nécessaire
          return const Text('Une erreur s\'est produite');
        } else {
          // L'exécution de getCategoryProvider est terminée, afficher la page d'accueil
          return Scaffold(
              extendBodyBehindAppBar: true,
              key: scaffoldKey,
              appBar: topNavBar(context, scaffoldKey),
              drawer: const Drawer(
                child: SideMenu(),
              ),
              body: const ResponsiveWidget(null, SmallScreen(),
                  largeScreen: LargeScreen()));
        }
      },
    );
  }
}
