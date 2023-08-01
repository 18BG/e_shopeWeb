import 'package:e_shopweb/helpers/responsiveness.dart';
import 'package:e_shopweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../constants/style.dart';

AppBar topNavBar(BuildContext context, GlobalKey<ScaffoldState> key) => AppBar(
      title: Row(
        children: [
          const Visibility(
              child: Column(
            children: [
              MyText(
                text: "Admin",
                size: 20,
                weight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              MyText(text: "ecommerce")
            ],
          )),
          Expanded(child: Container()),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.sunny,
                color: dark.withOpacity(0.7),
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: dark.withOpacity(0.7),
              )),
          Stack(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    color: dark.withOpacity(.7),
                  )),
              Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: light, width: 2)),
                  ))
            ],
          ),
          Container(
            width: 1,
            height: 22,
            color: lightGrey,
          ),
          const SizedBox(
            width: 24,
          ),
          const MyText(
            text: "Babry",
            color: lightGrey,
          ),
          const SizedBox(
            width: 24,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.all(2),
              child: Container(
                height: 55,
                width: 55,
                decoration: const BoxDecoration(
                    // color: Colors.amber,
                    ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.asset(
                      "assets/images/b1.png",
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          )
        ],
      ),
      iconTheme: const IconThemeData(color: Colors.deepOrange),
      backgroundColor: Colors.transparent,
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 14),
                  child: Image.asset(
                    "assets/images/vic1.jpeg",
                    width: 28,
                  ),
                )
              ],
            )
          : IconButton(
              onPressed: () {
                key.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu)),
      elevation: 0,
    );
