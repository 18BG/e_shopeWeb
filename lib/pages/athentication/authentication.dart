import 'package:e_shopweb/helpers/my_provider.dart';
import 'package:e_shopweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constants/style.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  late GlobalProvider provider;
  bool isLoading = false;
  TextEditingController mailController = TextEditingController(),
      passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<GlobalProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset("assets/icons/logo.png"),
                    ),
                    Expanded(child: Container())
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      "Login",
                      style: GoogleFonts.roboto(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const Row(
                  children: [
                    MyText(
                        text: "Welcom back to the admin panel",
                        color: lightGrey)
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: mailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: "Email",
                      hintText: "abc@domain.com"),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: "Password",
                      hintText: "123"),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (value) {}),
                        const MyText(
                          text: "Remember me",
                        )
                      ],
                    ),
                    const MyText(
                      text: "Forgot password",
                      color: active,
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      var adminInfo = await provider.login(
                          mailController.text, passwordController.text);
                      if (adminInfo != null) {
                        Navigator.pop(context);
                        Get.offAllNamed("/root");
                      } else {
                        print("llkfdcvfvg");
                        // Les informations d'identification fournies sont incorrectes
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  "Identifiants invalides. Veuillez réessayer.")),
                        );
                      }
                    } catch (e) {
                      print('Erreur lors de la connexion : $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                "Identifiants invalides. Veuillez réessayer.")),
                      );
                      // Affichez un message d'erreur ou effectuez des opérations en cas d'erreur de connexion.
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: (isLoading)
                      ? CircularProgressIndicator()
                      : Container(
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                              color: active,
                              borderRadius: BorderRadius.circular(20)),
                          child: const MyText(
                            text: "Login",
                            color: Colors.white,
                          ),
                        ),
                ),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(text: "Do not have admin credentials?"),
                  TextSpan(
                      text: "Request credentials!",
                      style: TextStyle(color: active)),
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
