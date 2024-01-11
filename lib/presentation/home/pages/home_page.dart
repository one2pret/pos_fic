import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_fic/core/components/menu_button.dart';
import 'package:pos_fic/core/components/search_input.dart';
import 'package:pos_fic/core/components/spaces.dart';
import 'package:pos_fic/presentation/home/bloc/product/product_bloc.dart';
import 'package:pos_fic/presentation/home/models/product_category.dart';
import 'package:pos_fic/presentation/home/models/product_model.dart';
import 'package:pos_fic/presentation/home/widgets/product_card.dart';
import 'package:pos_fic/presentation/home/widgets/product_empty.dart';

import '../../../core/assets/assets.gen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  final indexValue = ValueNotifier(0);

  // List<ProductModel> searchResults = [];
  /*  final List<ProductModel> products = [
    ProductModel(
      image: Assets.images.f1.path,
      name: 'Nutty Latte',
      category: ProductCategory.drink,
      price: 39000,
      stock: 10,
    ),
    ProductModel(
      image: Assets.images.f2.path,
      name: 'Iced Latte',
      category: ProductCategory.drink,
      price: 24000,
      stock: 10,
    ),
    ProductModel(
      image: Assets.images.f3.path,
      name: 'Iced Mocha',
      category: ProductCategory.drink,
      price: 33000,
      stock: 10,
    ),
    ProductModel(
      image: Assets.images.f4.path,
      name: 'Hot Mocha',
      category: ProductCategory.drink,
      price: 33000,
      stock: 10,
    ),
  ];
 */
  @override
  void initState() {
    // searchResults = products;
    context.read<ProductBloc>().add(const ProductEvent.fetchLocal());

    super.initState();
  }

  void onCategoryTap(int index) {
    searchController.clear();
    indexValue.value = index;
    String category = 'all';
    switch (index) {
      case 0:
        category = 'all';
        break;
      case 1:
        category = 'drink';
        break;
      case 2:
        category = 'food';
        break;
      case 3:
        category = 'snack';
        break;
    }
    context.read<ProductBloc>().add(ProductEvent.fetchByCategory(category));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Menu",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: const [],
          ),
          body: ListView(padding: const EdgeInsets.all(16), children: [
            SearchInput(
              controller: searchController,
              onChanged: (value) {
                /* indexValue.value = 0;
                searchResults = products
                    .where((e) =>
                        e.name.toLowerCase().contains(value.toLowerCase()))
                    .toList(); */
              },
            ),
            const SpaceHeight(20),
            ValueListenableBuilder(
              valueListenable: indexValue,
              builder: (context, value, _) {
                return Row(
                  children: [
                    MenuButton(
                      iconPath: Assets.icons.allCategories.path,
                      label: 'Semua',
                      isActive: value == 0,
                      onPressed: () => onCategoryTap(0),
                    ),
                    const SpaceWidth(10.0),
                    MenuButton(
                      iconPath: Assets.icons.drink.path,
                      label: 'Minuman',
                      isActive: value == 1,
                      onPressed: () => onCategoryTap(1),
                    ),
                    const SpaceWidth(10.0),
                    MenuButton(
                      iconPath: Assets.icons.food.path,
                      label: 'Makanan',
                      isActive: value == 2,
                      onPressed: () => onCategoryTap(2),
                    ),
                    const SpaceWidth(10.0),
                    MenuButton(
                      iconPath: Assets.icons.snack.path,
                      label: 'Snack',
                      isActive: value == 3,
                      onPressed: () => onCategoryTap(3),
                    ),
                  ],
                );
              },
            ),
            const SpaceHeight(35),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                return state.maybeWhen(orElse: () {
                  return const SizedBox();
                }, loading: () {
                  return const Center(child: CircularProgressIndicator());
                }, error: (message) {
                  return Center(child: Text(message));
                }, success: (products) {
                  if (products.isEmpty) {
                    return const ProductEmpty();
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 30,
                            crossAxisSpacing: 30,
                            childAspectRatio: 0.65),
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(
                          data: products[index], onCartButton: () {});
                    },
                  );
                });
              },
            ),
          ])),
    );
  }
}
