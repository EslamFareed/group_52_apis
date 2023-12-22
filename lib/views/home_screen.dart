import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_7/controllers/db/offline/shared_helper.dart';
import 'package:flutter_application_7/controllers/db/online/dio_helper.dart';
import 'package:flutter_application_7/models/category_model.dart';
import 'package:flutter_application_7/models/product_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<ProductModel> products = [];
  List<CategoryModel> categories = [];

  @override
  Widget build(BuildContext context) {
    print(SharedHelper.prefs.getString("token"));
    return Scaffold(
      appBar: AppBar(
        title: const Text("APIS"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: DioHelper.dio
                  .get("https://api.escuelajs.co/api/v1/categories"),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return const Center(child: Text("Error"));
                } else {
                  if (snapshot.data!.statusCode == 200) {
                    // handle data
                    var data = snapshot.data!.data;
                    for (var element in data) {
                      categories.add(CategoryModel.fromJson(element));
                    }
                    return SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, i) {
                          return Card(
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                    image: NetworkImage(categories[i].image!),
                                    fit: BoxFit.cover),
                              ),
                              alignment: Alignment.center,
                              child: FittedBox(
                                child: Text(
                                  categories[i].name!,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: categories.length,
                      ),
                    );
                  } else {
                    return const Center(child: Text("Error"));
                  }
                }
              },
            ),
            FutureBuilder(
              future:
                  DioHelper.dio.get("https://api.escuelajs.co/api/v1/products"),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return const Center(child: Text("Error"));
                } else {
                  if (snapshot.data!.statusCode == 200) {
                    // handle data
                    var data = snapshot.data!.data;
                    for (var element in data) {
                      products.add(ProductModel.fromJson(element));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, i) {
                        return Card(
                          child: ListTile(
                            title: Text(products[i].title ?? ""),
                            leading: FadeInImage(
                              width: 60,
                              height: 40,
                              fit: BoxFit.cover,
                              placeholderFit: BoxFit.cover,
                              imageErrorBuilder: (c, t, o) {
                                return Image.network(
                                  "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
                                  width: 60,
                                  height: 40,
                                  fit: BoxFit.cover,
                                );
                              },
                              placeholder: const NetworkImage(
                                  "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png"),
                              image: NetworkImage(
                                products[i].images![0],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: products.length,
                    );
                  } else {
                    return const Center(child: Text("Error"));
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
