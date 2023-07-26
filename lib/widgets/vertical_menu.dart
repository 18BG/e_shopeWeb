import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/controllers.dart';
import '../constants/style.dart';
import 'custom_text.dart';

class VerticalMenuItem extends StatefulWidget {
  final String itemName;
  final void Function()? onTap;
  const VerticalMenuItem(
      {super.key, required this.itemName, required this.onTap});

  @override
  State<VerticalMenuItem> createState() => _VerticalMenuItemState();
}

class _VerticalMenuItemState extends State<VerticalMenuItem> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (value) {
        value
            ? menuControllere.onHover(widget.itemName)
            : menuControllere.onHover("not hovering");
      },
      child: Obx(() => Container(
            color: menuControllere.isHovering(widget.itemName)
                ? lightGrey.withOpacity(.1)
                : Colors.transparent,
            child: Row(
              children: [
                Visibility(
                  visible: menuControllere.isHovering(widget.itemName) ||
                      menuControllere.isActive(widget.itemName),
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                  child: Container(
                    width: 3,
                    height: 72,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: menuControllere.returnIconFor(widget.itemName),
                    ),
                    if (!menuControllere.isActive(widget.itemName))
                      Flexible(
                          child: MyText(
                        text: widget.itemName,
                        color: menuControllere.isHovering(widget.itemName)
                            ? dark
                            : lightGrey,
                        align: TextAlign.center,
                      ))
                    else
                      Flexible(
                          child: MyText(
                        text: widget.itemName,
                        size: 18,
                        color: dark,
                        weight: FontWeight.bold,
                        align: TextAlign.center,
                      )),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      icon: _isExpanded
                          ? Icon(Icons.expand_less)
                          : Icon(Icons.expand_more),
                    ),
                    if (_isExpanded)
                      Column(
                        children: [
                          InkWell(
                              onTap: () {
                                widget.onTap;
                                print("1111");
                              },
                              child: Text("1111")),
                          Text("555")
                        ],
                      ),
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
