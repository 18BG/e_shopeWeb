import 'package:e_shopweb/helpers/responsiveness.dart';
import 'package:e_shopweb/large_screen.dart';
import 'package:e_shopweb/small_screen.dart';
import 'package:e_shopweb/widgets/side_menu.dart';
import 'package:e_shopweb/widgets/top_nav_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  //const Home({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        key: scaffoldKey,
        appBar: topNavBar(context, scaffoldKey),
        drawer: Drawer(
          child: SideMenu(),
        ),
        body: const ResponsiveWidget(null, SmallScreen(),
            largeScreen: LargeScreen()));
  }
}
