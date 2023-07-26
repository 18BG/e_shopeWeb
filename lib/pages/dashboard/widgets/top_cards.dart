import 'package:e_shopweb/constants/style.dart';
import 'package:flutter/material.dart';

class TopCards extends StatelessWidget {
  final String title;
  final String subtitle;
  final String value;
  final Color? iconColor;
  final IconData icone;
  final bool isActive;
  final void Function()? onTap;
  const TopCards(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.value,
      this.iconColor,
      this.onTap,
      required this.isActive,
      required this.icone});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: onTap,
      child: Container(
        height: 85,
        //width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  //offset: Offset(10, 10),
                  color: lightGrey.withOpacity(.3),
                  blurRadius: 25)
            ],
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: iconColor ?? active,
                  ),
                  child: Icon(icone),
                )),
            SizedBox(
              width: 10,
            ),
            Container(
              padding: EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Container()),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: "$title\n",
                          style: TextStyle(
                              fontSize: 16, color: isActive ? active : dark)),
                      //const SizedBox(height: 5,),
                      TextSpan(
                          text: "$subtitle\n",
                          style: TextStyle(
                              fontSize: 20,
                              color: isActive ? active : dark,
                              fontWeight: FontWeight.bold))
                    ]),
                  ),
                  Expanded(child: Container())
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
