import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/controllers.dart';
import '../../../helpers/my_provider.dart';
import '../../../model/categorie_model.dart';
import '../../../widgets/custom_text.dart';

class AddProductSmall extends StatefulWidget {
  final GlobalProvider provider;
  const AddProductSmall({super.key, required this.provider});

  @override
  State<AddProductSmall> createState() => _AddProductSmallState();
}

class _AddProductSmallState extends State<AddProductSmall> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  TextEditingController qtcontroller2 = TextEditingController();

  CategoryModel? category;
  bool isCategorieSelected = false;
  List<CategoryModel> categoryList = [
    CategoryModel(id: "1", name: "Jean", description: "Style", image: 'ee'),
    CategoryModel(id: "3", name: "Chemise", description: "Style", image: 'eee'),
    CategoryModel(id: "2", name: "Jupe", description: "Style", image: ''),
    CategoryModel(
        id: "7", name: "Robe", description: "a la mode", image: 'eee'),
    CategoryModel(id: "8", name: "Costume", description: "clear", image: 'eee')
  ];
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 1040,
          decoration: const BoxDecoration(color: Colors.blueGrey),
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
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(7),
                      decoration: const BoxDecoration(
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
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(color: Colors.white),
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
                        TextField(
                          controller: namecontroller,
                          decoration: InputDecoration(
                            hintText: "Exemple: Pantalon",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
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
                        TextField(
                          controller: desccontroller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: ""),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const MyText(
                          text: "Quantité en stock de ce type produit ",
                          weight: FontWeight.w300,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 150, right: 150),
                          child: TextField(
                            controller: qtcontroller2,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: "Exemple: 100"),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)),
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
                                      child: (_pickedImage == null)
                                          ? Image.asset(
                                              "assets/images/vic17.jpeg")
                                          : kIsWeb
                                              ? Image.memory(webImage)
                                              : Image.file(_pickedImage!))),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                        await _pickImage();
                                        print(webImage);
                                      },
                                      icon: const Icon(Icons.upload),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
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
                                  items: categoryList
                                      .map((thisCategory) =>
                                          DropdownMenuItem<CategoryModel>(
                                              value: thisCategory,
                                              child: Text(
                                                  (thisCategory.name == null)
                                                      ? "Aucune"
                                                      : thisCategory.name)))
                                      .toList(),
                                  onChanged: (CategoryModel? newValue) {
                                    setState(() {
                                      category = newValue;
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
                          onTap: () async {},
                          child: Container(
                            width: 100,
                            height: 50,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
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
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
        });
      } else {
        print('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedImage = File('a');
        });
      } else {
        print('No image has been picked');
      }
    } else {
      print("Something went wrong");
    }
  }
}
