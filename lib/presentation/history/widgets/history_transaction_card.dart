import 'package:flutter/material.dart';
import 'package:pos_fic/core/assets/assets.gen.dart';
import 'package:pos_fic/core/constants/colors.dart';
import 'package:pos_fic/core/extensions/int_ext.dart';
import 'package:pos_fic/presentation/history/models/history_transaction_model.dart';
import 'package:pos_fic/presentation/order/models/order_model.dart';

class HistoryTransactionCard extends StatelessWidget {
  final OrderModel data;
  final EdgeInsetsGeometry? padding;

  const HistoryTransactionCard({
    super.key,
    required this.data,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 48.0,
            blurStyle: BlurStyle.outer,
            spreadRadius: 0,
            color: AppColors.black.withOpacity(0.06),
          ),
        ],
      ),
      child: ListTile(
        leading: Assets.icons.payments.svg(),
        title: Text(data.paymentMethod),
        subtitle: Text('${data.totalQuantity} items'),
        trailing: Text(
          data.totalPrice.currencyFormatRp,
          style: const TextStyle(
            color: AppColors.green,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
