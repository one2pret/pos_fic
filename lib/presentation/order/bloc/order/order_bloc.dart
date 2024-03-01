import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos_fic/data/datasources/auth_local_datasource.dart';
import 'package:pos_fic/presentation/home/models/order_item.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const _Success([], 0, 0, '', 0, 0, '')) {
    on<_AddPaymentMethod>((event, emit) async {
      // var currentStates = state as _Success;
      emit(const _Loading()); // emit loading
      final userData = await AuthLocalDatasource().getAuthData();
      emit(_Success(
          event.orders,
          event.orders.fold(
              0, (previousValue, element) => previousValue + element.quantity),
          event.orders.fold(
              0,
              (previousValue, element) =>
                  previousValue + (element.quantity * element.product.price)),
          event.paymentMethod,
          0,
          userData.user.id,
          userData.user.name));
    });

    on<_AddNominalBayar>((event, emit) {
      var currentStates = state as _Success;
      emit(const _Loading()); // emit loading
      emit(_Success(
        currentStates.products,
        currentStates.totalQuantity,
        // event.totalPembelian,
        currentStates.totalPrice,
        currentStates.paymentMethod,
        event.nominal,
        currentStates.idKasir,
        currentStates.namaKasir,
      ));
    });

    //started
    on<_Started>((event, emit) {
      emit(const _Loading());
      emit(const _Success([], 0, 0, '', 0, 0, ''));
    });
  }
}
