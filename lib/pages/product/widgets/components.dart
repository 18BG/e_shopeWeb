import 'package:flutter/material.dart';

import '../../../widgets/custom_text.dart';

class Components extends StatelessWidget {
  final void Function()? onTap;
  final bool icon;
  final String content;
  final Color textcolor;
  final Color bckgColor;
  const Components(
      {super.key,
      required this.onTap,
      required this.content,
      required this.icon,
      required this.textcolor,
      required this.bckgColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 300,
          height: 50,
          decoration: BoxDecoration(
              border:
                  Border.all(color: (icon) ? Colors.transparent : Colors.blue),
              color: bckgColor.withOpacity(.7),
              borderRadius: BorderRadius.circular(4)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon)
                  const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                const SizedBox(
                  width: 10,
                ),
                MyText(
                  text: content,
                  size: 20,
                  weight: FontWeight.w600,
                  color: textcolor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
