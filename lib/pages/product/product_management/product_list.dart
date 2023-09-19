import 'package:e_shopweb/helpers/my_provider.dart';
import 'package:e_shopweb/model/categorie_model.dart';
import 'package:e_shopweb/model/product_model.dart';
import 'package:e_shopweb/widgets/custom_text.dart';
import 'package:e_shopweb/widgets/text_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

import 'package:provider/provider.dart';

import '../../../constants/controllers.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  late GlobalProvider provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<GlobalProvider>(context, listen: false);

    //provider.getCategoryProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
      builder: (context, value, child) {
        List<ProductModel> prodcutList = [];

        List<CategoryModel> categoryListe = value.categoryList;
        for (var index in categoryListe) {
          prodcutList.addAll(index.listProduct as Iterable<ProductModel>);
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top, left: 20),
                child: Row(
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
                    const SizedBox(
                      width: 10,
                    ),
                    const MyText(text: "Catégorie"),
                  ],
                ),
              ),

              //const SizedBox(height: 20), // Espacement entre le bouton et la liste
              (value.isLoading)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : (value.categoryList.isNotEmpty)
                      ? ListView.builder(
                          shrinkWrap:
                              true, // Pour empêcher la liste de prendre tout l'espace disponible
                          itemCount: prodcutList.length,
                          // Remplacez cela par le nombre total d'éléments que vous souhaitez afficher dans la liste.
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.only(left: 30, right: 30),
                              child: Card(
                                  child: Row(
                                children: [
                                  Container(
                                      height: 120,
                                      width: 100,
                                      padding: const EdgeInsets.all(10),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: ImageNetwork(
                                              image:
                                                  prodcutList[index].imageUrl,
                                              height: 120,
                                              width: 100))),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  MyText(text: prodcutList[index].name),
                                  const Spacer(),
                                  const Icon(Icons.delete),
                                  const SizedBox(
                                    width: 5,
                                  )
                                ],
                              )),
                            );
                          },
                        )
                      : const Center(
                          child: MyText(
                            text: "Aucune catégorie",
                            color: Colors.black,
                            size: 30,
                            weight: FontWeight.w600,
                          ),
                        ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: ElevatedButton(
                    style: ButtonStyle(
                      textStyle: const MaterialStatePropertyAll(
                          TextStyle(color: Colors.white, fontSize: 16)),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.teal),
                      splashFactory: InkSparkle.splashFactory,
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                      overlayColor:
                          const MaterialStatePropertyAll(Colors.amber),
                      shadowColor:
                          MaterialStateProperty.all<Color?>(Colors.red),
                    ),
                    onPressed: () {
                      // Action du bouton
                      addCategorieForm();
                      print('Le bouton a été appuyé.');
                    },
                    child: const MyText(
                      text: 'Ajouter une catégorie',
                      color: Colors.white,
                      size: 17,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom),
              )
            ],
          ),
        );
      },
    );
  }

  void addCategorieForm() {
    showDialog(
      context: context,
      builder: (context) {
        return Consumer<GlobalProvider>(
          builder: (context, value, child) {
            return AlertDialog(
              title: const MyText(text: "Ajouter une catégorie"),
              content: Card(
                child: (value.isLoading)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: Form(
                            child: Column(
                          children: [
                            (provider.pickedImage == null)
                                ? Image.asset(
                                    "assets/images/vic17.jpeg",
                                    height: 500,
                                  )
                                : kIsWeb
                                    ? Image.memory(
                                        provider.webImage,
                                        height: 500,
                                      )
                                    : Image.file(
                                        provider.pickedImage!,
                                        height: 500,
                                      ),
                            // Image.asset(
                            //   "assets/images/vic5.jpeg",
                            //   height: 500,
                            // ),
                            MyText(
                                text: provider.pickedImage == null
                                    ? "Null"
                                    : "Image selectionner"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.camera)),
                                IconButton(
                                    onPressed: () {
                                      provider.pickImage(false);
                                    },
                                    icon: const Icon(Icons.photo_library))
                              ],
                            ),
                            TextFormFields(
                              toChange: name,
                              hide: false,
                              prefix: false,
                              suffix: false,
                              labelText: "Nom de la catégorie",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormFields(
                              toChange: description,
                              hide: false,
                              prefix: false,
                              suffix: false,
                              labelText: "Description de la catégorie",
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const MyText(
                                      text: "Annuler",
                                      color: Colors.red,
                                    )),
                                TextButton(
                                    onPressed: () async {
                                      provider.isProcessing();
                                      try {
                                        var imageUrl = await provider
                                            .uploadImageBytesToFirebase(
                                                provider.webImage);
                                        print("Image enregistrer : $imageUrl");
                                        CategoryModel categoryModel =
                                            CategoryModel(
                                                name: name.text,
                                                description: description.text,
                                                image: imageUrl);
                                        await provider.addCategorieProvider(
                                            categoryModel);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                duration: Duration(seconds: 3),
                                                content: MyText(
                                                    text:
                                                        "Catégorie ajoutée avec succès")));
                                      } catch (e) {
                                        print(e);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                duration: Duration(seconds: 2),
                                                content: MyText(
                                                    text:
                                                        "Une erreur s'est produite ")));
                                      }
                                      provider.isProcessing();
                                      name.clear();
                                      description.clear();

                                      Navigator.pop(context);
                                    },
                                    child: const MyText(
                                      text: "Enregistrer",
                                      color: Colors.blue,
                                    ))
                              ],
                            )
                          ],
                        )),
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
