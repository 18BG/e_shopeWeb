import 'dart:io';

import 'package:e_shopweb/helpers/responsiveness.dart';
import 'package:e_shopweb/model/product_model.dart';
import 'package:e_shopweb/widgets/text_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../constants/controllers.dart';
import '../../../helpers/my_provider.dart';
import '../../../model/categorie_model.dart';
import '../../../widgets/custom_text.dart';

class AddProductMedium extends StatefulWidget {
  final GlobalProvider provider;

  const AddProductMedium({super.key, required this.provider});

  @override
  State<AddProductMedium> createState() => _AddProductMediumState();
}

class _AddProductMediumState extends State<AddProductMedium> {
  final key = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  TextEditingController qteEnStock = TextEditingController();
  TextEditingController prix = TextEditingController();
  String thisCategorie = "";

  CategoryModel? category;
  bool isCategorieSelected = false;
  List<CategoryModel> categoryList = [
    CategoryModel(id: "1", name: "Jean", description: "Style", image: 'ee'),
    CategoryModel(id: "3", name: "Chemise", description: "Style", image: 'ee'),
    CategoryModel(id: "2", name: "Jupe", description: "Style", image: 'ee'),
    CategoryModel(id: "7", name: "Robe", description: "a la mode", image: 'ee'),
    CategoryModel(id: "8", name: "Costume", description: "clear", image: 'ee')
  ];
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  static String? emptyCheck(String? value) {
    if (value!.isEmpty) {
      return "Tous les champs sont obligatoires";
    }
    return null;
  }

  late GlobalProvider provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<GlobalProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Consumer<GlobalProvider>(
      builder: (context, value, child) {
        List<CategoryModel> categoryListe = value.categoryList;
        return (value.isLoading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Container(
                    height:
                        ResponsiveWidget.isSmallScreen(context) ? 1040 : 1500,
                    decoration: BoxDecoration(color: Colors.blueGrey),
                    margin: EdgeInsets.fromLTRB(
                        10, MediaQuery.of(context).padding.top, 10, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                navController.goBack();
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: Colors.teal,
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.chevron_left),
                                    MyText(text: "retour"),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            const MyText(text: "Ajouter un produit"),
                            const Spacer(),
                          ],
                        ),
                        Expanded(
                          child: Card(
                            color: Colors.black,
                            child: Form(
                              key: key,
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: Column(
                                  children: [
                                    const MyText(
                                      text: "Informations du produit",
                                      weight: FontWeight.w700,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const MyText(
                                      text: "Nom du produit",
                                      weight: FontWeight.w300,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormFields(
                                      f: emptyCheck,
                                      hint: "Exemple: Pantalon",
                                      toChange: name,
                                      suffix: false,
                                      prefix: false,
                                      hide: false,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const MyText(
                                      text: "Description",
                                      weight: FontWeight.w300,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormFields(
                                      f: emptyCheck,
                                      labelText: "Description",
                                      toChange: description,
                                      suffix: false,
                                      prefix: false,
                                      hide: false,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const MyText(
                                      text:
                                          "Quantité en stock de ce type produit ",
                                      weight: FontWeight.w300,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 150, right: 150),
                                      child: TextFormFields(
                                        f: emptyCheck,
                                        labelText: "Quantité en Stock",
                                        toChange: qteEnStock,
                                        suffix: false,
                                        prefix: false,
                                        hide: false,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const MyText(
                                      text: "Prix du produit ",
                                      weight: FontWeight.w300,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 150, right: 150),
                                      child: TextFormFields(
                                        f: emptyCheck,
                                        labelText: "Prix",
                                        toChange: prix,
                                        suffix: false,
                                        prefix: false,
                                        hide: false,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Column(
                                        children: [
                                          const MyText(
                                            text: "Image du produit",
                                            weight: FontWeight.bold,
                                            align: TextAlign.start,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 150, right: 150),
                                              child: Card(
                                                  elevation: 10,
                                                  child: (provider
                                                              .pickedImage ==
                                                          null)
                                                      ? Image.asset(
                                                          "assets/images/vic17.jpeg")
                                                      : kIsWeb
                                                          ? Image.memory(
                                                              provider.webImage)
                                                          : Image.file(
                                                              _pickedImage!))),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const MyText(
                                                text: "Importer une image",
                                                weight: FontWeight.w900,
                                                align: TextAlign.start,
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              ElevatedButton.icon(
                                                  onPressed: () async {
                                                    print("picking . . .");
                                                    await provider.pickImage();
                                                    print(webImage);
                                                  },
                                                  icon:
                                                      const Icon(Icons.upload),
                                                  label: const Text("Importer"))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            child: const MyText(
                                              text: "Catégorie : ",
                                              weight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          DropdownButton<CategoryModel>(
                                              value: category,
                                              items: categoryListe
                                                  .map((thisCategory) =>
                                                      DropdownMenuItem<
                                                              CategoryModel>(
                                                          value: thisCategory,
                                                          child: Text(
                                                              thisCategory
                                                                  .name)))
                                                  .toList(),
                                              onChanged:
                                                  (CategoryModel? newValue) {
                                                setState(() {
                                                  category = newValue;
                                                  print(category!.id);
                                                  isCategorieSelected = true;
                                                });
                                              }),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          MyText(
                                              text: (isCategorieSelected)
                                                  ? ""
                                                  : "Chosissez une catégorie"),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        provider.isProcessing();
                                        try {
                                          if (key.currentState!.validate()) {
                                            int? qtenStock =
                                                int.tryParse(qteEnStock.text);
                                            double? price =
                                                double.tryParse(prix.text);
                                            String? id = category!.id;
                                            var imUlr = await provider
                                                .uploadImageBytesToFirebase(
                                                    value.webImage);
                                            ProductModel productModel =
                                                ProductModel(
                                                    name: name.text,
                                                    price: price!,
                                                    description:
                                                        description.text,
                                                    imageUrl: imUlr,
                                                    qteStock: qtenStock!);
                                            await provider.insertProduct(
                                                productModel, id!);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: MyText(
                                                        text:
                                                            "Produit ajouté avec succès")));
                                          }
                                        } catch (e) {
                                          print(e);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: MyText(
                                                      text:
                                                          "Une erreur s'est produite")));
                                        }
                                        provider.isProcessing();
                                        navController.goBack();
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 50,
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15)),
                                            color: Colors.green),
                                        child: const Center(
                                          child: MyText(
                                            text: "Publié",
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
      },
    );
  }
}
