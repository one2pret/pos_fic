import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos_fic/data/datasources/order_remote_datasource.dart';
import 'package:pos_fic/data/datasources/product_local_datasource.dart';
import 'package:pos_fic/data/models/request/order_request_model.dart';

part 'sync_order_event.dart';
part 'sync_order_state.dart';
part 'sync_order_bloc.freezed.dart';

class SyncOrderBloc extends Bloc<SyncOrderEvent, SyncOrderState> {
  final OrderRemoteDatasource orderRemoteDatasource;

  SyncOrderBloc(this.orderRemoteDatasource) : super(const _Initial()) {
    on<_SendOrder>((event, emit) async {
      emit(const SyncOrderState.loading());
      //get orders from local syc is 0
      final orderIsSyncZero =
          await ProductLocalDatasource.instance.getOrderByIsSync();
   //   print(orderIsSyncZero);
      for (final order in orderIsSyncZero) {
        final orderItems = await ProductLocalDatasource.instance
            .getOrderItemByOrderId(order.id!);
        final orderRequest = OrderRequestModel(
          transactionTime: order.transactionTime,
          kasirId: order.idKasir,
          totalPrice: order.totalPrice,
          totalItem: order.totalQuantity,
          paymentMethod: order.paymentMethod,
          orderItems: orderItems,
        );
        // .map((e) => OrderItem(
        //     productId: e.product.id!,
        //     quantity: e.quantity,
        //     totalPrice: e.quantity * e.product.price))
        // .toList());
        final response = await orderRemoteDatasource.sendOrder(orderRequest);
      //  print(response);
        if (response) {
          await ProductLocalDatasource.instance
              .updateIsSyncOrderById(order.id!);
        }
        emit(const SyncOrderState.success());
      }
    });
  }
}
