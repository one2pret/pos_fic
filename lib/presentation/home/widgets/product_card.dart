import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_fic/core/constants/variables.dart';
import 'package:pos_fic/core/extensions/int_ext.dart';
import 'package:pos_fic/data/models/response/product_response_model.dart';
import 'package:pos_fic/presentation/home/bloc/checkout/checkout_bloc.dart';

import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';

/// Mendefinisikan widget kartu produk dengan data dan callback untuk tombol keranjang
class ProductCard extends StatelessWidget {
  final Product data;
  final VoidCallback onCartButton;

  /// Konstruktor dari widget ini
  const ProductCard({
    super.key,
    required this.data,
    required this.onCartButton,
  });

  @override
  Widget build(BuildContext context) {
    /// Membangun widget stack dengan container dan positioned
    return Stack(
      children: [
        /// Container dengan padding dan decorasi
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: AppColors.card),
              borderRadius: BorderRadius.circular(19),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Container dengan alignment, padding, dan decorasi untuk gambar produk
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.disabled.withOpacity(0.4),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
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
                  ),
                ),
              ),

              /// Spacer untuk memisahkan gambar dan teks
              const Spacer(),

              /// Teks nama produk
              Text(
                data.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              /// Teks kategori produk
              const SpaceHeight(8.0),
              Text(
                data.category,
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 12,
                ),
              ),

              /// Teks harga produk dan tombol tambah ke keranjang
              const SpaceHeight(8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Teks harga produk
                  Flexible(
                    child: Text(
                      data.price.currencyFormatRp,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  /// Tombol tambah ke keranjang
                  GestureDetector(
                    onTap: () {
                      /// Menambahkan event addCheckout dengan data ke bloc CheckoutBloc
                      context
                          .read<CheckoutBloc>()
                          .add(CheckoutEvent.addCheckout(data));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                        color: AppColors.primary,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        /// Positioned dengan circle avatar untuk menampilkan jumlah produk
        BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            return state.maybeWhen(
                orElse: () => const SizedBox(),
                success: (products, qty, price) {
                  if (qty == 0) {
                    return const SizedBox();
                  }
                  return products.any((element) => element.product == data)
                      ? products
                                  .firstWhere(
                                      (element) => element.product == data)
                                  .quantity >
                              0
                          ? Positioned(
                              top: 8,
                              right: 8,
                              child: CircleAvatar(
                                backgroundColor: AppColors.primary,
                                child: Text(
                                  products
                                      .firstWhere(
                                          (element) => element.product == data)
                                      .quantity
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox()
                      : const SizedBox();
                });
          },
        ),
      ],
    );
  }
}
