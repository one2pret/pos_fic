import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos_fic/data/models/response/product_response_model.dart';
import 'package:pos_fic/presentation/home/models/order_item.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const _Success([], 0, 0)) {
    on<_AddCheckout>((event, emit) {
      var currentStates = state as _Success;
      List<OrderItem> newCheckout = [...currentStates.products];
      emit(const _Loading());
      if (newCheckout.any((element) => element.product == event.product)) {
        var index = newCheckout
            .indexWhere((element) => element.product == event.product);
        newCheckout[index].quantity++;
      } else {
        newCheckout.add(OrderItem(
          product: event.product,
          quantity: 1,
        ));
      }

      /*  int totalQuantity = 0;
      int totalPrice = 0; 

      for (var element in newCheckout) {
        totalQuantity += element.quantity;
        totalPrice += element.product.price * element.quantity;
      }
       */

      // make total totalQuantity use fold
      int totalQuantity = newCheckout.fold(
          0, (previousValue, item) => previousValue + item.quantity);

      // make totalPrice use fold
      int totalPrice = newCheckout.fold(
          0,
          (previousValue, item) =>
              previousValue + item.product.price * item.quantity);

      emit(_Success(newCheckout, totalQuantity, totalPrice));
    });

    on<_RemoveCheckout>((event, emit) {
      var currentStates = state as _Success;
      List<OrderItem> newCheckout = [...currentStates.products];
      emit(const _Loading());
      if (newCheckout.any((element) => element.product == event.product)) {
        var index = newCheckout
            .indexWhere((element) => element.product == event.product);
        if (newCheckout[index].quantity > 1) {
          newCheckout[index].quantity--;
        } else {
          newCheckout.removeAt(index);
        }
      }

      // make total totalQuantity use fold
      int totalQuantity = newCheckout.fold(
          0, (previousValue, item) => previousValue + item.quantity);

      // make totalPrice use fold
      int totalPrice = newCheckout.fold(
          0,
          (previousValue, item) =>
              previousValue + item.product.price * item.quantity);

      emit(_Success(newCheckout, totalQuantity, totalPrice));
    });

    on<_Started>((event, emit) {
      emit(const _Loading());
      emit(const _Success([], 0, 0));
    });
  }
}
