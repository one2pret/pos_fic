import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pos_fic/core/components/spaces.dart';
import 'package:pos_fic/core/constants/variables.dart';

import '../../../core/components/buttons.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/response/product_response_model.dart';

class MenuProductItem extends StatelessWidget {
  final Product data;
  const MenuProductItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 3, color: AppColors.blueLight),
              borderRadius: BorderRadius.circular(10))),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                height: 100,
                fit: BoxFit.fitWidth,
                imageUrl: '${Variables.imageBaseUrl}${data.image}',
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(
                  Icons.food_bank_outlined,
                  size: 80,
                ),
              )),
          /* 
              Image.asset(data.image,
                  height: 74, width: 74, fit: BoxFit.cover)), */
          const SpaceWidth(22),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SpaceHeight(5.0),
                Text(
                  data.category,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SpaceHeight(10.0),
                Row(
                  children: [
                    Flexible(
                        child: Button.outlined(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                contentPadding: const EdgeInsets.all(16.0),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data.name,
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SpaceHeight(10.0),
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      child: CachedNetworkImage(
                                        height: 100,
                                        fit: BoxFit.fitWidth,
                                        imageUrl:
                                            '${Variables.imageBaseUrl}${data.image}',
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.food_bank_outlined,
                                          size: 80,
                                        ),
                                      ),
                                    ),
                                    const SpaceHeight(10.0),
                                    Text(
                                      data.category,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SpaceHeight(10.0),
                                    Text(
                                      data.price.toString(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SpaceHeight(10.0),
                                    Text(
                                      data.stock.toString(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SpaceHeight(10.0),
                                  ],
                                ),
                              );
                            });
                      },
                      label: 'Detail',
                      fontSize: 8.0,
                      height: 31,
                    )),
                    const SpaceWidth(6.0),
                    Flexible(
                        child: Button.outlined(
                      onPressed: () {
                        // context.push(EditProductPage(data: data));
                      },
                      label: 'Ubah Produk',
                      fontSize: 8.0,
                      height: 31,
                    ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
